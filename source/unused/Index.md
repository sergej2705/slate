## Übersicht
* [Konzepte](Konzepte)
* [Modell](Modell)
* [Ablauf](Ablauf)

### REST
* Order
  * [Segment](Order_Segment)
  * [Checkout](Order_Checkout)
  * [Finalize](Order_Finalize)
  * [Read](Order_Read)
  * [Cancel](Order_Delete)
  * [Acknowledge Status](Order_Acknowledge)

* Portal
  * [Unacknowledged Orders](Portal_Unacknowledged)
  * [Unacknowledged Orders with Status](Portal_UnacknowledgedByStatus)

### Standard Error Responses
#### Authentifizierung
Alle Aufrufe an die to.photo API müssen authorisiert sein.

Aufrufe ohne valide Zugangsdaten werden mit einem der folgenden Fehler beantwortet.

* **401 UNAUTHORIZED**
  Der Benutzer ist nicht eingeloggt

* **403 FORBIDDEN**
  Der Benutzer ist nicht berechtigt

#### Server Fehler
* **500 INTERNAL SERVER ERROR**
  Bei unerwarteten Fehlern zur Laufzeit antwortet der Server mit einem _Internal Server Error_ ohne weitere Details.

  _Der Fehler wird unverzüglich an den Adminstrator gemeldet!_

      {
          "status": "INTERNAL_SERVER_ERROR",
          "timestamp": "2018-01-01 12:34:56.789",
          "message": "Unexpected error",
          "debugMessage": null
      }
