# Wireframes & Navigation Graph — Wheelhouse

This document contains low-fidelity UI sketches for the key Wheelhouse interfaces and the overall application navigation graph.

---

## 1. Low-Fidelity Screen Sketches

### Screen 1: Counter - Quick Bike Status Inquiry (Requirement 7 Mandatory Screen)
* **Role Viewing:** Counter Staff (Daughter)
* **Purpose:** Answer customer phone calls immediately to state if a bike is ready without walking to the back workshop.

```text
+-----------------------------------------------------------------------+
|  WHEELHOUSE COUNTER  | [Search: Customer Name / Serial #]  [Search]   |
+-----------------------------------------------------------------------+
| RESULTS:                                                              |
| +-------------------------------------------------------------------+ |
| | Customer: John Doe | Bike: Trek Marlin (SN: 992831)              | |
| | Status: READY FOR PICKUP [IN GREEN]                              | |
| | Promised Day: Thursday | Assigned Mechanic: Alex                 | |
| | Total Price: $85.00                                               | |
| | [View Invoice Details] [Mark Delivered & Closed]                  | |
| +-------------------------------------------------------------------+ |
|                                                                       |
| EMPTY STATE MESSAGE (If search finds nothing):                        |
| "No bikes found matching your criteria. Please verify the name or     |
| serial number."                                                       |
+-----------------------------------------------------------------------+
+-----------------------------------------------------------------------+
|  WHEELHOUSE OWNER DASHBOARD                       [Filter: Overdue v] |
+-----------------------------------------------------------------------+
| ATTENTION REQUIRED: OVERDUE REPAIRS                                   |
| +-------------------------------------------------------------------+ |
| | Bike: Giant Escape (SN: 441029) | Promised: Yesterday (1 day late) | |
| | Customer: Sarah Connor (555-0192)                                 | |
| | Status: In Progress | Assigned Mechanic: Sam                      | |
| | Notes: Waiting on replacement brake cable                         | |
| | [Contact Customer] [Reassign Mechanic]                            | |
| +-------------------------------------------------------------------+ |
+-----------------------------------------------------------------------+
+-----------------------------------------------------------------------+
|  MECHANIC WORKBENCH | Repair Order #1042                             |
+-----------------------------------------------------------------------+
| Bike: Trek Marlin (SN: 992831) | Photos: [Photo_1.jpg] [Photo_2.jpg]  |
| Customer: John Doe                                                    |
+-----------------------------------------------------------------------+
| DIAGNOSIS & REPAIR NOTES (Paragraphs / Lists):                        |
| +-------------------------------------------------------------------+ |
| | Replaced rear cassette and chain. Re-trued back wheel.            | |
| +-------------------------------------------------------------------+ |
| SELECTED SERVICES:                                                    |
| [x] Tune-Up ($50.00)                                                  |
| [x] Wheel True ($20.00) [Discount applied: -$5.00] -> Charged: $15.00 |
| [ Add Service from Wall List ]                                       |
+-----------------------------------------------------------------------+
| STATUS: [ In Progress v ]                  [ Save & Update Status ]   |
+-----------------------------------------------------------------------+
+-----------------------------------------------------------------------+
|  WHEELHOUSE BICYCLE SHOP — SERVICE MENU                                |
+-----------------------------------------------------------------------+
| STANDARD REPAIR PRICES                                                |
| +-------------------------------------------------------------------+ |
| | Service Name                                 | Standard Price     | |
| +----------------------------------------------+--------------------+ |
| | Tune-Up                                      | $50.00             | |
| | Wheel True                                   | $20.00             | |
| | Brake Bleed                                  | $35.00             | |
| | Chain Replacement                            | $15.00             | |
| +-------------------------------------------------------------------+ |
| Note: Final quotes depend on physical inspection at intake.           |
+-----------------------------------------------------------------------+
[ Public Website ]
                             |
                   (Public Wall List Menu)
                             |
                             v
                     [ Staff Login ]
                             |
             +---------------+---------------+
             |                               |
             v                               v
   [ Counter Dashboard ]           [ Mechanic Dashboard ]
      /             \                        |
     v               v                       v
[New Bike Intake]  [Counter Search /  [Work Order Details /
 (Create Order)     Status Check]       Note Logger]
     |               |                       |
     +-------+-------+                       |
             |                               |
             v                               v
     [ Active Repair Orders ] <--------------+
             |
             v
   [ Owner Dashboard ]
  (Overdue & Analytics)