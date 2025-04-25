# 📧 SieveGenius
A smarter Sieve filter designed to work similarly Apple Intelligence and Gmail's inbox sorting by using powerful label-based organization; primarily designed for ProtonMail but compatible with other email clients supporting Sieve.

## 🌟 Features

```
✅ Automatic email categorization
✅ Smart promotional content detection
✅ Priority handling for important messages
✅ System alert identification
✅ Development-specific filtering
```

## 📋 Required Labels

| Label Name | Purpose |
|------------|---------|
| Important | High-priority messages and system alerts |
| Billing | Payment confirmations, invoices, receipts |
| Newsletters | Subscription-based content and regular updates |
| Security | Authentication, verification, and security notices |
| Social | Messages from social media platforms |
| Work | Professional communications |
| Shopping | Order confirmations, returns, customer service |
| Travel | Reservations, bookings, itineraries |
| Entertainment | Streaming services and media notifications |
| Development | Technical updates, GitHub notifications, etc. |
| Shipping | Package tracking and delivery information |
| Promotions | Marketing emails and special offers |

## 📥 Installation Instructions

1. Log in to your ProtonMail account
2. Navigate to Settings > Filters
3. Click "Add Sieve Filter"
4. Download the filter file: [filter.sieve](https://github.com/cryptofyre/SieveGenius/blob/main/filter.sieve)
5. Copy and paste the content into the filter editor
6. Save the filter

## 📊 Setup & Configuration

### Visual Setup Guide

<div align="center">
  <table>
    <tr>
      <td align="center"><b>Step 1: Accessing Filters</b></td>
      <td align="center"><b>Step 2: Creating New Filter</b></td>
    </tr>
    <tr>
      <td><img src="https://github.com/user-attachments/assets/bd98e8ae-20cb-44dd-b263-12535744e69d" width="450px" /></td>
      <td><img src="https://github.com/user-attachments/assets/9694edfc-abf6-4309-9f81-ca78f1b6b3b3" width="450px" /></td>
    </tr>
    <tr>
      <td align="center"><b>Step 3: Pasting Filter Code</b></td>
      <td align="center"><b>Step 4 (Optional): Activating Filter on existing messages</b></td>
    </tr>
    <tr>
      <td><img src="https://github.com/user-attachments/assets/d994c068-669b-4766-9485-aaf31cafc156" width="450px" /></td>
      <td><img src="https://github.com/user-attachments/assets/55f98703-22ea-4ccc-9324-3c32a803a156" width="450px" /></td>
    </tr>
  </table>
</div>

## ⚠️ Important Notes

- You **MUST** create all labels listed above before activating the filter
- Filter rules are processed in sequential order; order matters
- Messages not matching any rule will remain in your inbox

## 🛠️ Customization

To customize the filter for your needs:
1. Add additional email domains to relevant sections (Required for Work!)
2. Modify keywords in subject line detection
3. Adjust file destination labels as needed

## 📄 License

This project is available under the MIT License.

## 🙏 Credits

Developed by [cryptofyre](https://github.com/cryptofyre) © 2025

> "I am not responsible for your inbox being split apart like my wife, use at your own discretion."
