# Wheelhouse API v1 Documentation

## Endpoint Routes

- **`GET /api/v1/services`**
  - **Requires Token:** No
  - **Status Codes:** `200`
- **`GET /api/v1/services/:id`**
  - **Requires Token:** No
  - **Status Codes:** `200`, `404`
- **`POST /api/v1/services`**
  - **Requires Token:** Yes
  - **Status Codes:** `201`, `400`, `401`, `422`
- **`GET /api/v1/repairs`**
  - **Requires Token:** Yes
  - **Status Codes:** `200`, `400`, `401`
- **`GET /api/v1/repairs/:id`**
  - **Requires Token:** Yes
  - **Status Codes:** `200`, `401`, `404`

---

## Example JSON Documents

### 1. Service Document
```json
{
  "id": 1,
  "name": "Tune-up",
  "price": "25000.0",
  "repairs_count": 5
}
2. Repair Document
{
  "id": 12,
  "state": "in_progress",
  "created_at": "2026-10-15",
  "promised_on": "2026-10-20",
  "returned_on": null,
  "bike": {
    "brand": "Trek",
    "model": "Marlin 7",
    "serial_number": "WTU1234567X"
  },
  "customer_name": "Teodoro Coz",
  "lines": [
    {
      "service_name": "Tune-up",
      "price_charged": "25000.0"
    }
  ],
  "total": "25000.0",
  "overdue": false,
  "customer_answer": "in_progress"
}
3. Collection Response
[
  {
    "id": 1,
    "name": "Tune-up",
    "price": "25000.0",
    "repairs_count": 5
  }
]
4. Error Document
{
  "errors": [
    "Unauthorized: Invalid or missing token"
  ]
}
Design Decisions
Price Representation:
Prices travel as Strings (e.g., "25000.0") rather than floating-point numbers to prevent binary floating-point precision loss (IEEE 754 imprecisions) during transport and JSON parsing.

Omitted Repair Fields:

bike_id and mechanic_id foreign keys are excluded because external client programs need human-readable object details rather than internal database keys.

Customer phone numbers and personal emails are excluded to protect customer privacy and limit payload size to only what accounting software requires.