# User Stories - Wheelhouse Bicycle Shop

## 1. User Stories

### Counter Staff (Daughter)
* **US-01:** As the counter staff, I want to create a new intake record with the customer's name, phone number, bike description, serial number, and promised delivery day so that we can tag the bike and track its turnaround time.
* **US-02:** As the counter staff, I want to search for a bike by customer name, bike brand, or serial number so that I can instantly answer phone inquiries about whether a bike is ready without walking to the back workshop.
* **US-03:** As the counter staff, I want to attach photos of the bike taken during intake so that we have photographic proof of its arrival condition and prevent disputes over pre-existing damage.

### Mechanic
* **US-04:** As a mechanic, I want to write detailed diagnosis notes  on a bike's record so that any team member can read a complete description of the required repair work.
* **US-05:** As a mechanic, I want to view a bike's past repair history so that I can see what work was performed on that specific bike during previous visits
* **US-06:** As a mechanic, I want to select repair items from the wall list and add custom price adjustments so that regulars or simple jobs can be charged at a reduced rate.

### Shop Owner
* **US-07:** As the shop owner, I want to see a list of overdue bikes on my screen so that I can proactively identify repairs that missed their promised completion date before the customer calls.
* **US-08:** As the shop owner, I want to manage the standard service price list so that I can update prices every January without retroactively altering past invoices.
* **US-09:** As the shop owner, I want the system to record customer approval or rejection of price quotes so that we never begin complex repairs without explicit authorization.

### Public / Customer
* **US-10:** As a public user visiting the shop website, I want to view the current standard price list for repair services so that I know service costs beforehand without having to call the shop.
* **US-11:** As a customer, I want my repair history kept private from other public site visitors so that my personal details and bike service records are not accessible to strangers.

### Epic (Large Story) & Split
* **US-12 (EPIC - TOO BIG):** As a mechanic, I want to fully process a bike's repair lifecycle from diagnosis to quote approval, parts installation, and handover so that the shop runs efficiently.

> **Note on US-12 Split:** The story above was split into the following smaller, independently valuable stories:
> * **US-12a:** As a mechanic, I want to log a detailed quote and mark the repair status as "Awaiting Approval" so that the counter staff can call the customer for confirmation.
> * **US-12b:** As a mechanic, I want to mark a repair as "In Progress" or "Ready for Pickup" so that the entire team knows the current status of the bike in real time.

---

## 2. Acceptance Criteria

### US-02: Instant Status Inquiry at the Counter
* **Criterion 1:** When searching by customer name or serial number, the system displays the current repair state (`Received`, `Quoted`, `Approved`, `In Progress`, `Ready`, or `Delivered`) along with the promised completion day.
* **Criterion 2:** If the repair status is `Ready`, the screen prominently displays the total price owed in green text.
* **Criterion 3 (Empty State):** If no bike matches the search term, the system displays the message *"No bikes found matching your criteria. Please verify the name or serial number."* instead of an empty table.

### US-07: Overdue Repair Alert
* **Criterion 1:** The screen filters and displays all bikes whose promised day has passed and whose status is not yet `Ready` or `Delivered`.
* **Criterion 2:** Overdue entries display the number of days past due highlighted in red.
* **Criterion 3 (Empty State):** If all repairs are on schedule, the overdue dashboard displays the message *"All repairs are on schedule. No overdue bikes today."*

### US-08: Standard Service Price List Management
* **Criterion 1:** When a price in the wall list is updated, existing invoice line items created prior to the change maintain their original price charged.
* **Criterion 2:** New repair quotes created after the update automatically populate using the updated price list value.
* **Criterion 3:** Deactivating a service hides it from the public website while retaining its history on past invoices.

### US-10: Public Service Price List Web Page
* **Criterion 1:** The public web page displays all currently active services and their list prices without requiring user login.
* **Criterion 2:** The public page contains no navigation links or access to customer repair histories, internal notes, or phone numbers.
* **Criterion 3 (Empty State):** If no active services are found in the system, the web page displays *"Our service menu is currently being updated. Please call the shop for pricing."*