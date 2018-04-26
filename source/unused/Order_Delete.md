## Cancel Order

Storniert eine Order

### URL
`/v1/orders/:orderid`

### Method
`DELETE`

### Accept
`application/json`

### Content-Type
`application/json`

### URL Params
`orderId=[long]`

### Data Params
Order als JSON

### Success Response
#### Code
`204`

#### Content
_No Content_

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
  Die Order kann nicht (mehr) storniert werden

      {
        "status": "CONFLICT",
        "timestamp": "2018-01-01 12:34:56.789",
        "message": "Only temporary orders can receive data",
        "debugMessage": "Only temporary orders can receive data"
      }

* **410 GONE**
  Die Order ist bereits storniert

      {
        "status": "GONE",
        "timestamp": "2018-01-01 12:34:56.789",
        "message": "Order is canceled",
        "debugMessage": "Order is canceled"
      }
