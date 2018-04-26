# Orders

## Create Order

Initialise a new order

### HTTP Request
`POST /v1/orders`

### Accept
`application/json`

### Content-Type
`application/json`

### Data Params
Order als JSON

### Success Response
#### Code
`200`

#### Content

```json
{
  "orderId": "270",
  "bunches": [
    {
      "items": [
        {
          "mimetype": "application/zip",
          "reference": "custom1.zip",
          "type": "Payload"
        }
      ],
      "project": "custom1"
    }
  ],
  "cart": {
    "subcarts": [
      {
        "items": [
          {
            "count": 1,
            "price": 11900,
            "processorIndex": 0,
            "project": "custom1",
            "sku": "14631000"
          }
        ],
        "orderId": 123,
        "paymentOrderId": "testorder",
        "producer": "Allcop",
        "producerOrderId": 123,
        "producerOrderUniqueIdentifier": "94440000123",
        "shipping": 3450
      }
    ]
  },
  "customer": {
    "billingaddress": {
      "city": "Musterstadt",
      "country": "DE",
      "firstname": "Max",
      "lastname": "Mustermann",
      "street": "Musterstrasse 14",
      "zipcode": "12345"
    },
    "deliveryaddress": {
      "city": "Musterstadt",
      "country": "DE",
      "firstname": "Max",
      "lastname": "Mustermann",
      "street": "Musterstrasse 14",
      "zipcode": "12345"
    },
    "email": "test@test.test"
  },
  "mandator": 0,
  "orderdate": 1518800013000,
  "payload": [
    {
      "mimetype": "application/zip",
      "name": "custom1.zip"
    }
  ],
  "portal": 1000,
  "projects": [
    {
      "count": 1,
      "identifier": "custom1",
      "processor": {
        "identifier": "photo.to.amazonmarketplace.AmazonStandardCupProcessor",
        "metadata": {
          "sku": "14631000"
        }
      },
      "title": "Tasse (14631000)"
    }
  ],
  "status": "Enqueued",
  "statusHistory": [
  ]
}
```

### Error Response
* **422 UNPROCESSABLE ENTITY**
  Die Order führt zu mehr als 9 Subcarts.

```json
{
  "status": "UNPROCESSABLE_ENTITY",
  "timestamp": "2018-01-01 12:34:56.789",
  "message": "More than 9 Subcarts are not allowed",
  "debugMessage": "More than 9 Subcarts are not allowed"
}
```



## Checkout Order

Reichere Order um Checkoutdaten an

### HTTP Request
`POST /v1/orders/:orderid/checkout`

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
`200`

#### Content

```json
{
  "orderId": "270",
  "bunches": [
    {
      "items": [
        {
          "mimetype": "application/zip",
          "reference": "custom1.zip",
          "type": "Payload"
        }
      ],
      "project": "custom1"
    }
  ],
  "cart": {
    "subcarts": [
      {
        "items": [
          {
            "count": 1,
            "price": 11900,
            "processorIndex": 0,
            "project": "custom1",
            "sku": "14631000"
          }
        ],
        "orderId": 123,
        "paymentOrderId": "testorder",
        "producer": "Allcop",
        "producerOrderId": 123,
        "producerOrderUniqueIdentifier": "94440000123",
        "shipping": 3450
      }
    ]
  },
  "customer": {
    "billingaddress": {
      "city": "Musterstadt",
      "country": "DE",
      "firstname": "Max",
      "lastname": "Mustermann",
      "street": "Musterstrasse 14",
      "zipcode": "12345"
    },
    "deliveryaddress": {
      "city": "Musterstadt",
      "country": "DE",
      "firstname": "Max",
      "lastname": "Mustermann",
      "street": "Musterstrasse 14",
      "zipcode": "12345"
    },
    "email": "test@test.test"
  },
  "mandator": 0,
  "orderdate": 1518800013000,
  "payload": [
    {
      "mimetype": "application/zip",
      "name": "custom1.zip"
    }
  ],
  "portal": 1000,
  "projects": [
    {
      "count": 1,
      "identifier": "custom1",
      "processor": {
        "identifier": "photo.to.amazonmarketplace.AmazonStandardCupProcessor",
        "metadata": {
          "sku": "14631000"
        }
      },
      "title": "Tasse (14631000)"
    }
  ],
  "status": "Enqueued",
  "statusHistory": [
  ]
}
```

### Error Response
* **404 NOT FOUND**
No order found

```json
{
  "status": "NOT_FOUND",
  "timestamp": "2018-01-01 12:34:56.789",
  "message": "Order not found",
  "debugMessage": "Order not found"
}
```

* **409 CONFLICT**
The order is not temporary (anymore) and can not be changed.

```json
{
  "status": "CONFLICT",
  "timestamp": "2018-01-01 12:34:56.789",
  "message": "Only temporary orders can receive checkout data",
  "debugMessage": "Only temporary orders can receive checkout data"
}
```

_or:_

The carts are different, please get the actual cart from [order get].

```json
{
  "status": "CONFLICT",
  "timestamp": "2018-01-01 12:34:56.789",
  "message": "Carts are different",
  "debugMessage": "Carts are different"
}
```



## Finalize Order

Finalize the order and send it to production

### HTTP Request
`POST /v1/orders/:orderId/data`

### Accept
`application/zip`

### Content-Type
`application/json`

### URL Params
`orderId=[long]`

### Data Params
`file=Payloads als Zipfile`

### Success Response
#### Code
`200`

#### Content
```json
{
  "orderId": "270",
  "bunches": [
    {
      "items": [
        {
          "mimetype": "application/zip",
          "reference": "custom1.zip",
          "type": "Payload"
        }
      ],
      "project": "custom1"
    }
  ],
  "cart": {
    "subcarts": [
      {
        "items": [
          {
            "count": 1,
            "price": 11900,
            "processorIndex": 0,
            "project": "custom1",
            "sku": "14631000"
          }
        ],
        "orderId": 123,
        "paymentOrderId": "testorder",
        "producer": "Allcop",
        "producerOrderId": 123,
        "producerOrderUniqueIdentifier": "94440000123",
        "shipping": 3450
      }
    ]
  },
  "customer": {
    "billingaddress": {
      "city": "Musterstadt",
      "country": "DE",
      "firstname": "Max",
      "lastname": "Mustermann",
      "street": "Musterstrasse 14",
      "zipcode": "12345"
    },
    "deliveryaddress": {
      "city": "Musterstadt",
      "country": "DE",
      "firstname": "Max",
      "lastname": "Mustermann",
      "street": "Musterstrasse 14",
      "zipcode": "12345"
    },
    "email": "test@test.test"
  },
  "mandator": 0,
  "orderdate": 1518800013000,
  "payload": [
    {
      "mimetype": "application/zip",
      "name": "custom1.zip"
    }
  ],
  "portal": 1000,
  "projects": [
    {
      "count": 1,
      "identifier": "custom1",
      "processor": {
        "identifier": "photo.to.amazonmarketplace.AmazonStandardCupProcessor",
        "metadata": {
          "sku": "14631000"
        }
      },
      "title": "Tasse (14631000)"
    }
  ],
  "status": "Enqueued",
  "statusHistory": [
  ]
}
```

### Error Response
* **404 NOT FOUND**
  Keine Order gefunden

```json
{
  "status": "NOT_FOUND",
  "timestamp": "2018-01-01 12:34:56.789",
  "message": "Order not found",
  "debugMessage": "Order not found"
}
```

* **409 CONFLICT**
  Die Order ist nicht (mehr) temporär

```json
{
  "status": "CONFLICT",
  "timestamp": "2018-01-01 12:34:56.789",
  "message": "Only temporary orders can receive data",
  "debugMessage": "Only temporary orders can receive data"
}
```



## Order Status Acknowledge

Acknowledge an order status as processed

### HTTP Request
`PUT /v1/orders/:orderid/status`

### URL Params
Parameter | Type | Description
--------- | -----|------------
orderid | long | The ID of the order which status to acknowledge

### Accept
`application/json`

### Content-Type
`application/json`

### Data Params
```json
{
  
}
```
StatusEntry als JSON

### Success Response
#### Code
`200`

#### Content

### Error Response
```json
{
  "status": "NOT_FOUND",
  "timestamp": "2018-01-01 12:34:56.789",
  "message": "Order not found",
  "debugMessage": "Order not found"
}
```
#### 404 NOT FOUND
  Keine Order gefunden


```json
{
  "status": "CONFLICT",
  "timestamp": "2018-01-01 12:34:56.789",
  "message": "Entry can not be acknowledged",
  "debugMessage": "Entry can not be acknowledged"
}
```

#### 409 CONFLICT
  Die Status-Eintrag kann nicht bestätigt werden


