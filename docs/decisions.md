# Architectural & Business Decisions — Wheelhouse

This document details three critical domain questions that the prose description does not explicitly answer, the working assumptions adopted for the system, and the architectural impact if those assumptions change.

---

## Question 1: How are custom discounts or price reductions authorized and applied?

* **The Question:** The owner mentions that mechanics sometimes charge less than the list price for regulars or easy jobs. Is this discount a free-form manual price override per line item, or does it require owner approval or preset percentage tiers?
* **Assumption Made:** Mechanics have the authority to directly override the `price_charged` on a specific `repair_services` line item at the time of job assignment without needing a formal approval workflow.
* **Impact if Answer is Different:** If discounts require owner approval or specific discount codes, we would need to add an `approved_by_owner` boolean flag or create a `discounts` entity linked to `repair_services`, along with a new approval state (`pending_discount_approval`) in the repair lifecycle.

---

## Question 2: Can a single bike repair order be assigned to multiple mechanics, or is it strictly one mechanic per bike?

* **The Question:** The description mentions three mechanics in the workshop, but it is unclear whether one mechanic takes full ownership of a bike or if multiple mechanics can work on different tasks for the same bike order.
* **Assumption Made:** A repair order is assigned to a single primary mechanic (or left unassigned initially), modeled via a direct `mechanic_id` foreign key on the `repair_orders` table.
* **Impact if Answer is Different:** If multiple mechanics work on different tasks for a single bike, the `mechanic_id` foreign key would move from `repair_orders` into the `repair_services` join table (or a separate `work_logs` table), allowing each individual job/task to be assigned to a different person.

---

## Question 3: What happens when a customer declines a repair quote?

* **The Question:** The owner states that when customers say no to a quote, they "come to pick it up the way it arrived." Does the shop charge a diagnostic/inspection fee for the mechanic's time, or is rejection completely free of charge?
* **Assumption Made:** Rejecting a quote incurs zero cost. The repair order state transitions to `rejected`, no invoice lines are finalized, and the customer retrieves the bike without payment.
* **Impact if Answer is Different:** If a diagnostic fee is charged for rejected quotes, the system must support generating an invoice for `rejected` repair orders containing a standard "Inspection Fee" line item before transitioning to `delivered`.