require ["fileinto", "imap4flags"];

# !!!YOU WILL NEED TO CREATE THE LABEL TAGS FOR THIS FILTER TO WORK!!!
# Important, Billing, Newsletters, Security, Social, Work, Shopping, Travel, Entertainment, Development, Shipping

# I am not responsible for your inbox being split apart like my wife, use at your own discretion.
# - cryptofyre 2025

# ===== BILLING EMAILS =====
if anyof(
    header :contains ["From"] ["billing@github.com", "payments@github.com", "invoice@github.com"],
    allof(
        anyof(
            header :contains ["From"] ["stripe.com", "paypal.com", "invoice@", "billing@", "accounting@"],
            header :contains "Subject" ["payment", "invoice", "receipt", "subscription", "renewal"]
        ),
        not header :contains "Subject" ["off", "sale", "discount", "promo", "deal", "save"]
    )
) {
    fileinto "Billing";
    stop;
}

# ===== WORK EMAILS =====
if anyof(
    # Your company domain - highest priority
    header :contains ["From", "To", "Cc"] ["@cider.sh"],
    
    # GitHub work-related (not promotions)
    allof(
        header :contains ["From"] ["github.com"],
        header :contains "Subject" ["pull request", "PR #", "commit", "issue", "workflow", "CI", "build", "repository"],
        not header :contains "Subject" ["newsletter", "webinar", "% off", "sale"]
    )
) {
    fileinto "Work";
    stop;
}

# ===== SECURITY EMAILS =====
if allof(
    anyof(
        # Specific security-related subjects
        header :contains "Subject" ["2FA", "two-factor", "verification code", "security code", "login attempt", "sign-in from"],
        
        # From security-specific addresses
        header :contains ["From"] ["security@", "auth@", "noreply@auth.", "verification@", "no-reply@auth."],
        
        # Contains security keywords in both From and Subject
        allof(
            header :contains ["From"] ["noreply", "no-reply", "donotreply"],
            header :contains "Subject" ["verify", "password", "authentication", "account security"]
        )
    ),
    # Explicitly exclude known false positives
    not header :contains ["From"] ["nothing.tech", "peacocktv.com", "primevideo.com", "amazon.com", "opencollective.com", "zagg.com", "irobot.com", "microsoft-store"]
) {
    fileinto "Security";
    stop;
}

# ===== SHIPPING & DELIVERY EMAILS =====
if anyof(
    # From shipping companies
    header :contains ["From"] ["fedex.com", "ups.com", "usps.com", "dhl.com", "post."],
    
    # Very specific shipping subjects with specific retailers
    allof(
        header :contains ["From"] ["amazon.com", "walmart.com", "target.com", "ebay.com"],
        header :contains "Subject" ["shipped", "tracking", "delivery", "package"],
        not header :contains "Subject" ["% off", "deal", "promo", "offer", "last chance"]
    )
) {
    fileinto "Shipping";
    stop;
}

# ===== SHOPPING EMAILS =====
if allof(
    anyof(
        # Order confirmations
        allof(
            header :contains ["From"] ["amazon.com", "ebay.com", "walmart.com", "target.com", "bestbuy.com", "newegg.com", "etsy.com"],
            header :contains "Subject" ["order", "purchase", "confirmation", "receipt"]
        ),
        
        # Return/customer service
        allof(
            header :contains ["From"] ["amazon.com", "ebay.com", "walmart.com", "target.com"],
            header :contains "Subject" ["return", "refund", "customer service"]
        )
    ),
    # Exclude shipping notifications (already handled above)
    not header :contains "Subject" ["shipped", "delivery", "tracking"],
    # Exclude promotions
    not header :contains "Subject" ["% off", "deal", "sale", "promo"]
) {
    fileinto "Shopping";
    stop;
}

# ===== STREAMING & ENTERTAINMENT =====
if header :contains ["From"] ["peacocktv.com", "primevideo.com", "netflix.com", "hulu.com", "disneyplus.com", "hbomax.com", "spotify.com", "youtube.com", "nothing.tech", "appletv.com", "max.com", "paramountplus.com", "stream."] {
    fileinto "Entertainment";
    stop;
}

# ===== DEVELOPMENT & OPEN SOURCE =====
if anyof(
    header :contains ["From"] ["opencollective.com", "gitlab.com", "bitbucket.org", "npm.com", "digitalocean.com", "stackoverflow.com", "docker.com", "linux.com", "apache.org", "golang.org", "python.org", "dev@", "developer@"],
    
    # GitHub emails that aren't work-related
    allof(
        header :contains ["From"] ["github.com"],
        not header :contains "Subject" ["pull request", "PR #", "commit", "issue", "workflow", "CI", "build", "repository"]
    )
) {
    fileinto "Development";
    stop;
}

# ===== PROMOTIONS/MARKETING EMAILS =====
if anyof(
    # Clear promotional language in subject
    header :contains "Subject" ["% off", "discount", "offer", "sale", "deal", "save", "limited time", "exclusive", "don't miss", "last day", "flash sale"],
    
    # Known promotional senders
    header :contains ["From"] ["marketing@", "promotion@", "info@", "microsoft-store", "irobot.com", "zagg.com"],
    
    # Has promotional terms in from
    header :contains ["From"] ["newsletter", "offers", "deals", "promos"]
) {
    fileinto "Promotions";
    stop;
}

# ===== NEWSLETTERS =====
if anyof(
    # Explicit newsletter indicators
    header :contains ["List-Unsubscribe"] ["*"],
    header :contains "Subject" ["newsletter", "weekly update", "monthly update", "digest"],
    
    # Common newsletter senders
    header :contains ["From"] ["newsletter@", "updates@", "digest@", "weekly@"]
) {
    fileinto "Newsletters";
    stop;
}

# ===== SOCIAL MEDIA =====
if header :contains ["From"] ["twitter.com", "x.com", "facebook.com", "instagram.com", "linkedin.com", "reddit.com", "tiktok.com", "pinterest.com", "snapchat.com"] {
    fileinto "Social";
    stop;
}

# ===== TRAVEL =====
if anyof(
    header :contains ["From"] ["booking.com", "airbnb.com", "expedia.com", "hotels.com", "kayak.com", "orbitz.com", "tripadvisor.com", "@airline", "@airways", "@air.com", "delta.com", "united.com", "southwest.com"],
    header :contains "Subject" ["reservation", "booking", "itinerary", "flight", "hotel", "travel", "trip"]
) {
    fileinto "Travel";
    stop;
}

# ===== IMPORTANT =====
if anyof(
    header :contains "Importance" "high",
    header :contains "Priority" "urgent",
    header :contains "Subject" ["urgent", "important", "attention", "critical", "action required", "immediate action"]
) {
    addflag "\\Flagged";
    fileinto "Important";
    stop;
}

# ===== DEFAULT RULE =====
# Any email not caught by rules above stays in inbox, obviously.