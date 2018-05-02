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

Use the `order` resource to initialise a new order. Upon initialization it is not necessary to provide all details of an order. All of the details are added during an `order`s lifecycle.

### Error Response

* **422 UNPROCESSABLE ENTITY**

    The order would lead to more then 9 Subcarts.

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

> Request

```yaml
Path:   POST /v1/orders/:orderid/checkout
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

After initialization you will need to enrich the order with checkout data. This contains all data collected in the checkout process.

### URL Params
`orderId=[long]`

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

    _or:_

    The carts are different, please get the actual cart from [order get](#read-order).

```json
{
  "status": "CONFLICT",
  "timestamp": "2018-01-01 12:34:56.789",
  "message": "Only temporary orders can receive checkout data",
  "debugMessage": "Only temporary orders can receive checkout data"
}
```

```json
{
  "status": "CONFLICT",
  "timestamp": "2018-01-01 12:34:56.789",
  "message": "Carts are different",
  "debugMessage": "Carts are different"
}
```



## Finalize Order

> Request

```yaml
Path:   POST /v1/orders/:orderid/data
Headers: Accept: application/zip
Headers: Content-Type: application/json
```

> Response

```yaml
Headers: Content-Type: application/json
```

### URL Params
`orderId=[long]`

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

After all you need to finalize the order and send it to production.

Therefore you send all the payload image data, packaged as a ZIP archive, to the server. The successful upload will trigger the production process, no further call is needed.

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
  "message": "Only temporary orders can receive data",
  "debugMessage": "Only temporary orders can receive data"
}
```



## Order Status Acknowledge

> Request

```yaml
Path:   PUT /v1/orders/:orderid/status
Headers: Accept: application/json
Headers: Content-Type: application/json
```
> Response

```yaml
Headers: Content-Type: application/json
```

Acknowledge an order status as processed

### URL Params
Parameter | Type | Description
--------- | -----|------------
orderid | long | The ID of the order which status to acknowledge

### Error Response
```json
{
  "status": "NOT_FOUND",
  "timestamp": "2018-01-01 12:34:56.789",
  "message": "Order not found",
  "debugMessage": "Order not found"
}
```

* **404 NOT FOUND**

    No order found


```json
{
  "status": "CONFLICT",
  "timestamp": "2018-01-01 12:34:56.789",
  "message": "Entry can not be acknowledged",
  "debugMessage": "Entry can not be acknowledged"
}
```

* **409 CONFLICT**

    The status entry can not be acknowledged



## Read Order

> Request

```yaml
Path:   GET /v1/orders/:orderid
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

Load an order

### URL Params
`orderId=[long]`

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

* **410 GONE**

    The order is canceled

```json
{
  "status": "GONE",
  "timestamp": "2018-01-01 12:34:56.789",
  "message": "Order is canceled",
  "debugMessage": "Order is canceled"
}
```
