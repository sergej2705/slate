## Create Order

Initialisiere eine neue Order

### URL
`/v1/orders`

### Method
`POST`

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
* **422 UNPROCESSABLE ENTITY**
  Die Order führt zu mehr als 9 Subcarts.

      {
        "status": "UNPROCESSABLE_ENTITY",
        "timestamp": "2018-01-01 12:34:56.789",
        "message": "More than 9 Subcarts are not allowed",
        "debugMessage": "More than 9 Subcarts are not allowed"
      }
