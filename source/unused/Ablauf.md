## Zusammenfassung

Zunächst steht ein Endprodukt mit bereits gesammelten Informationen und Bildern. Zur Veranschaulichung nehmen wir an dieser Stelle die Series-App, welche zur Erstellung von deckungsgenauen Serienbildern über einen langen Zeitraum verwendet wird. Wir unterscheiden im Weiteren zwischen Series-App und Series-Server.

![902d5168-6a3d-40de-b48c-00f43d678e4d.png](https://files.nuclino.com/files/fe69edf9-d761-4e02-b203-3e4f8a376844/902d5168-6a3d-40de-b48c-00f43d678e4d.png)

Zu einem gegebenen Zeitpunkt wird im Endprodukt der Checkout-Prozess / Warenkorb begonnen. Es gilt nun zunächst die entstehenden domainspezifischen (hier Series-App-spezifische) Einzelprodukte zu ermitteln, um daraus die anzuzeigenden Preise zu bestimmen. 

Die App gibt somit über den Series-Server einen "Segment"-Auftrag an die ToPhoto-API. In diesem Auftrag sind Informationen über die verfügbaren Bilder samt ihrer Größen und Metainformationen (welches Design, welche Text, etc.). Zusätzlich bestimmt der Auftrag mit welchem "Processor" und damit auch für welches Endprodukt segmentiert werden soll. Ein Processor ist eine domainspezifische Implementierung eines Produkts (in diesem Beispiel eine Polaroid-Fotobox für die Series-App). Die API vergibt eine OrderID und bestimmt mit dem Processor, wie viele Bilder entstehen werden und, ob bspw. noch Deckblätter o.ä. hinzukommen. Der Warenkorb besteht somit aus n Polaroid-Fotos.

Der Series-Server bestimmt nun den Warenkorb-Wert anhand der Produktanzahl(en) anhand seiner eigenen Preistabelle und gibt diese Informationen zurück an die App. Diese zeigt den Warenkorb und initiiert auf Wunsch den Checkout. Hier werden Adressen gesammelt und ggf. die Zahlung abgewickelt oder initiiert. Diese Daten werden ebenfalls der API übergeben. Final wird über den Series-Server ein "Finalize"-Auftrag an die API gegeben (Upload eines großen Zips mit Bild- und sonstigen Nutzdaten). Diese entpackt das Zip, prüft den Auftrag und speichert ihn in der Datenbank und im Arbeitsverzeichnis ab. Zusätzlich werden bereits bei der Annahme produktionsspezifische OrderIDs vergeben. Zuletzt wird ein Auftrag in eine Export-Queue eingestellt, um die Bestellung asynchron abarbeiten und rendern zu können.

Die API liefert die erstellte Order zurück. Die App quittiert nun die erfolgreiche Bestellannahme, der Server bucht die Zahlung, und der Bestellvorgang ist abgeschlossen.

Aus der Export-Queue heraus wird im ToPhoto-Worker ein Vorgang angestoßen. Dieser lädt die Bestellung und layoutet und rendert mit dem Processor die produktionsfähigen Produktbilder. Theoretisch wird hier die Segmentierung dann noch einmal durchlaufen und es werden genauso viele Produktbilder erzeugt, wie zuvor für die Preisberechnung als Grundlage gedient haben. Nach der Erzeugung werden die Bilder mit den spezifischen Producern zur Produktion weitergegeben. Hier werden dann Auftragsbegleitdaten, wie XMLs oder API-Aufrufe, erzeugt und bspw. in einen FTP-Hotfolder gespeichert.

## Warenkorbsplitting und Subcarts

Es kann vorkommen, dass mehrere Produkte aus unterschiedlichen "Produktionsstandorten" oder Linien bestellt werden, welche nicht in einer Sendung ausgeliefert oder im schlimmsten Fall sogar von unterschiedlichen Produzenten erstellt werden. Für diesen Fall gibt es im Segmentierungsschritt die Einrichtung der Subcarts. Werden zunächst nur die zu erstellenden Einzelprodukte ermittelt (bestückt mit SKUs), werden diese im nächsten Schritt auf Produzenten und so genannte Subcarts aufgeteilt. Für jeden dieser Subcarts müssen dann ggf. Versandkosten berechnet werden. Im Standardfall gibt es jedoch nur einen Subcart pro Bestellung.

![0da2c754-46e6-4505-9d16-d9fdea566ff6.png](https://files.nuclino.com/files/e46366ae-9e82-4464-93c8-7e0f78dfcd66/0da2c754-46e6-4505-9d16-d9fdea566ff6.png)