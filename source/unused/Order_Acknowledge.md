## Order Status Acknowledge

Bestätigt einen Status-Eintrag als abgearbeitet

### URL
`/v1/orders/:orderid/status`

### Method
`PUT`

### Accept
`application/json`

### Content-Type
`application/json`

### URL Params
`orderId=[long]`

### Data Params
StatusEntry als JSON

### Success Response
#### Code
`200`

#### Content

### Error Response
* **404 NOT FOUND**
  Keine Order gefunden

      {
        "status": "NOT_FOUND",
        "timestamp": "2018-01-01 12:34:56.789",
        "message": "Order not found",
        "debugMessage": "Order not found"
      }

* **409 CONFLICT**
  Die Status-Eintrag kann nicht bestätigt werden

      {
        "status": "CONFLICT",
        "timestamp": "2018-01-01 12:34:56.789",
        "message": "Entry can not be acknowledged",
        "debugMessage": "Entry can not be acknowledged"
      }
