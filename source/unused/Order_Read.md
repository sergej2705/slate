## Read Order

Lade eine Order

### URL
`/v1/orders/:orderid`

### Method
`GET`

### Content-Type
`application/json`

### URL Params
`orderId=[long]`

### Data Params
_keine_

### Success Response
#### Code
`200`

#### Content
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

### Error Response
* **404 NOT FOUND**
  Keine Order gefunden

      {
        "status": "NOT_FOUND",
        "timestamp": "2018-01-01 12:34:56.789",
        "message": "Order not found",
        "debugMessage": "Order not found"
      }

* **410 GONE**
  Die Order ist storniert

      {
        "status": "GONE",
        "timestamp": "2018-01-01 12:34:56.789",
        "message": "Order is canceled",
        "debugMessage": "Order is canceled"
      }
