# Permissions — Wheelhouse

Every rule below is enforced by a Pundit policy in `app/policies/`. The controller, the index
(through the policy scope) and the views all ask the same policy. A request that a policy refuses
answers `403` with a page in the layout of the application. A visitor with no session is sent to sign in.

Roles: **Owner**, **Counter**, **Mechanic**. A **Visitor** has no session.
The account created from the sign-up page has the default role, **Counter**.

Definitions used in the tables:

* **Own repair** (Mechanic only): a repair whose mechanic is the member of the staff joined to the
  mechanic's account. A mechanic account that belongs to no member of the staff has no own repairs
  and reads none.
* **Handed back**: a repair in the final state of its lifecycle, `delivered`.
* **Yes** = allowed. **No** = refused with `403`.

No page lists, edits or deletes accounts.

## Repairs (`RepairPolicy`)

| Action (controller)              | Owner | Counter                    | Mechanic                          | Visitor |
|----------------------------------|-------|----------------------------|-----------------------------------|---------|
| `index` (list)                   | Yes, every repair | Yes, every repair | Yes, **only own repairs** (scope) | No |
| `show`                           | Yes   | Yes                        | Only if it is an own repair       | No      |
| `new` / `create` (taking in)     | Yes   | Yes                        | No                                | No      |
| `edit` / `update`                | Yes, every repair (handed back too) | Yes, if **not** handed back | Only if own repair **and** not handed back | No |
| `destroy`                        | Yes   | No                         | No                                | No      |
| Delete an intake photo (`Repairs::PhotosController#destroy`, same rule as `update`) | Yes | Yes, if not handed back | Own repair, not handed back | No |

Fields each role may write (`RepairPolicy#permitted_attributes`; the form only shows these, and any
other field sent by hand is dropped):

| Field                                    | Owner | Counter | Mechanic |
|------------------------------------------|-------|---------|----------|
| `bike_id`                                | Yes   | Yes     | No       |
| `mechanic_id`                            | Yes   | Yes     | No       |
| `promised_on`                            | Yes   | Yes     | No       |
| `customer_agreed`                        | Yes   | Yes     | No       |
| `repair_services_attributes` (lines and their prices) | Yes | Yes | No |
| `status`                                 | Yes   | Yes     | Yes      |
| `diagnosis`                              | Yes   | Yes     | Yes      |
| `photos` (add intake photos)             | Yes   | Yes     | Yes      |

The account that took a repair in is read from the session; it is never a field.

Scope (`RepairPolicy::Scope`): Owner and Counter get every repair, a Mechanic gets only the repairs
of the member of the staff joined to their account (none if the account has no member of the staff),
a Visitor gets none. It gives the same answer as `show`. Every list of repairs uses it: the repairs
index, the repairs of a bike, of a service and of a member of the staff.

## Customers (`CustomerPolicy`)

| Action               | Owner | Counter | Mechanic | Visitor |
|----------------------|-------|---------|----------|---------|
| `index`              | Yes   | Yes     | No       | No      |
| `show`               | Yes   | Yes     | No       | No      |
| `new` / `create`     | Yes   | Yes     | No       | No      |
| `edit` / `update`    | Yes   | Yes     | No       | No      |
| `destroy`            | Yes   | No      | No       | No      |

## Bikes (`BikePolicy`)

| Action               | Owner | Counter | Mechanic | Visitor |
|----------------------|-------|---------|----------|---------|
| `index`              | Yes   | Yes     | No       | No      |
| `show`               | Yes   | Yes     | No       | No      |
| `new` / `create`     | Yes   | Yes     | No       | No      |
| `edit` / `update`    | Yes   | Yes     | No       | No      |
| `destroy`            | Yes   | No      | No       | No      |

## Services (`ServicePolicy`)

| Action               | Owner | Counter | Mechanic | Visitor |
|----------------------|-------|---------|----------|---------|
| `index`              | Yes   | Yes     | Yes      | Yes (public) |
| `show`               | Yes   | Yes     | Yes      | Yes (public) |
| `new` / `create`     | Yes   | No      | No       | No      |
| `edit` / `update`    | Yes   | No      | No       | No      |
| `destroy`            | Yes   | No      | No       | No      |

## Staff (`MechanicPolicy`)

The controller exposes `index` and `show`; the policy also fixes who may create, edit and delete
staff, so a page added later is covered without writing anything in the controller.

| Action               | Owner | Counter | Mechanic | Visitor |
|----------------------|-------|---------|----------|---------|
| `index`              | Yes   | Yes     | Yes      | No      |
| `show`               | Yes   | Yes     | Yes      | No      |
| `new` / `create`     | Yes   | No      | No       | No      |
| `edit` / `update`    | Yes   | No      | No       | No      |
| `destroy`            | Yes   | No      | No       | No      |

## What the navigation bar shows

| Link       | Owner | Counter | Mechanic | Visitor |
|------------|-------|---------|----------|---------|
| Customers  | Yes   | Yes     | No       | No      |
| Bikes      | Yes   | Yes     | No       | No      |
| Mechanics  | Yes   | Yes     | Yes      | No      |
| Repairs    | Yes   | Yes     | Yes      | No      |
| Services   | Yes   | Yes     | Yes      | Yes     |

Public actions that do not call a policy are listed, with the reason, in [decisions.md](decisions.md).