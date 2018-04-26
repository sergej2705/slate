## Unacklowdged Orders

Lade alle Orders, die unbestätigte Status haben

### URL
`/v1/portals/:portalid/orders/unacknowledged`

### Method
`GET`

### Content-Type
`application/json`

### URL Params
`portalId=[integer]`

### Data Params
_keine_

### Success Response
#### Code
`200`

#### Content

    [{
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
      	{
          "date": 1518806466415,
          "status": "Shipped",
          "acknowledged": false
        }
      ]
    }]

### Error Response
_keine speziellen Fehlermeldungen_
