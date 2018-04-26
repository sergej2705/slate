# Errors

<aside class="notice">
Most ressources have own Error Responses, see also the corresponding sections for futher details.
</aside>

## Error Response

> an example Error Object

```json
{
  "status": "GONE",
  "timestamp": "2018-01-01 12:34:56.789",
  "message": "Order is canceled",
  "debugMessage": "Order is canceled"
}
```

An Error Response consists of an HTTP status code and an Error Object.

The HTTP status codes are used to categorize the Errors in the "standard" manner, so 4xx for clientside/request Errors and 5xx for serverside Errors. For further information see the [List of HTTP status codes on Wikipedia](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes#4xx_Client_errors).

The additional Error Object gives you more information about the Error. Usually the message field (and if applicable the debug message filed) will tell you more about the Errors cause.

## Standard Error Responses
HTTP Status | Description | Meaning
---------- | ----------- | -------
400 | Bad Request | Your request is invalid.
401 | Unauthorized | Your API key is wrong.
403 | Forbidden | You tried to access a ressource which wasn't made for your eyes, sorry NSA!
404 | Not Found | The specified ressource could not be found.
405 | Method Not Allowed | You tried to access a ressource with an invalid method.
406 | Not Acceptable | You requested a format that isn't json.
410 | Gone | The ressource requested has been removed from our servers.
500 | Internal Server Error | We had an unexpected problem with our server. Try again later. _The problem is reported to an Administrator immediately._
503 | Service Unavailable | We're temporarily offline for maintenance. Please try again later.
