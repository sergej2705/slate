# Orders

## Resource

The `order` resource is the central resource of to.photo. It's parameters are listed in the following table.

| Parameter | Mandatory | Description                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| --------- | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| locale    | true      | Locale for the checkout. Determines the language that is used within the checkout website. Accepted values follow the POSIX locale schema and use [ISO 639](https://en.wikipedia.org/wiki/ISO_639) language codes and optionally [ISO 3166-1 ALPHA-2](https://en.wikipedia.org/wiki/ISO_3166-1) country codes, for example `de` or `fr_FR`. The global default, if no matching language is found, is German. Locale definitions are not case-sensitive. |
| id        | false     | A UUID identifying this checkout. The UUID will be generated on the checkout server side. If one is contained in a crate request, it will be ignored.                                                                                                                                                                                                                                                                                                        |
| order_url | true      | Callback URL to report a successful order. The body of this call with contain a complete [order](#orders) resource. This URL will be called after a user finishes the checkout. The API will try to get through to this URL for up to 12 hours. If no successful request can be performed within this time range, the order will be canceled.                                                                                                            |
| cart      | true      | See [cart](#cart) for more details.                                                                                                                                                                                                                                                                                                                                                                                                                     |
| customer  | false     | See [customer](#customer) for more details.



## Create Order

Use the `order` resource to initialise a new order. Upon initialization it is not necessary to provide all details of an order. All of the details are added during an `order`s lifecycle.

> Request

```yaml
Path:   POST /v1/orders
Headers: Accept: application/json
Headers: Content-Type: application/json
```
> Response

```yaml
Headers: Content-Type: application/json
```

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

* **422 UNPROCESSABLE ENTITY**
Die Order führt zu mehr als 9 Subcarts.


> Error Response

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


