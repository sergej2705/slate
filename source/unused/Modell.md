## Address

Eine simple Adresse.

## Bunch

Ein semantisches Bündel an Nutzdaten. Kann aus Bildern, Texten oder sonstigen Daten bestehen. Gehört semantisch zu einem Project.

## BunchItem

Ein Inhalt in einem Bunch. Hat einen Identifier und einen Mimetype. Korrespondiert in der Regel zu einem Payload. Für einfache Texte oder auch URLs sind die BunchItems alleinstehend.

## Cart

Container für verschiedene Unterwarenkörbe (Subcarts) und einen Gutschein. Es wird perse davon ausgegangen, das Bestelltrennung vorgeht. Oftmals liegt allerdings eine 1:1-Beziehung vor.

## Client/Device/Type

Beschreibt hauptsächlich zu Statistikzwecken den Client des Endkunden.

## Customer

Beschreibt den Kunden mit Rechnungs- und Lieferadresse, sowie Telefon, Fax und E-Mail

## Order

Ein kompletten Bestellvorgang bzw. das durchgängige Toplevel Domainobjekt.

## Output

Beschreibt den Output eines Processors/Renderers, der zu einem SubcartItem gehört. In einem Output können 1 oder mehrere Dateien verlinkt sein.

## OutputFormat

Enum für die verschiedenen Ausgabeformate (JPG, PNG, SVG, PDF)

## Payload

Binärartefakt, welches im geposteten Zip zur API enthalten ist. Referenziert immer einen BunchItem.

## Payment

Container für Zahlungsdaten. Für PayPal bspw. die Token zum Capturing etc.

## Processor

Anweisungen zur Instanziierung eines Processors. Besteht aus Identifier (full qualified Classname) und Metadaten.

## Project

Beschreibt eine semantische EInheit. Bspw. eine Fotoserie oder eine Collage.

## Subcart

Beschreibt einen spezifischen Cart mitsamt Produzentenmapping und Produzentenbestellnummer. Subcarts werden im Segmentierungsschritt bestimmt, indem zunächst alle SKUs gesammelt und diese anschließend auf Produzenten aufgeteilt werden. Die Produzenten können wiederum selber noch einem splitten.

## SubcartItem

Ein Eintrag im Subcart. Beschreibt Menge, Preis und SKU.

## Voucher

Ein Gutschein, Behandlung obliegt dem Mandanten, nicht der API.