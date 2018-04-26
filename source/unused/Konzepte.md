# Payload, Project und Bunch

In einem API-Auftrag (Order) sind die Begriffe Payload, Project und Bunch charakteristisch:

## Payload

Unter Payload verstehen sich die verfügbaren Bilder oder andere Binärdaten, die von den Processoren für das Rendering verwendet werden. Sie liegen im finalen Auftrag innerhalb des Zips und werden über ihren Dateinamen referenziert. Zusätzlich enthält ein Payload-Eintrag den Mimetype und es existieren optionale Metadaten, wie bspw. die Bildgröße.
 
## Project

Ein Project beschreibt einen semantischen Eintrag im Warenkorb. Für die Series-App bedeutet dies bspw. eine Polaroid-Fotobox für eine bestimmte Serie. Als essentielle Angaben sind am Project die gewünschte Anzahl, der zu verwendende Processor und der Identifier (bspw. eine UUID).

## Bunch

Die Eingabedaten für die Segmentierung und das Layouting im Processor sind die Bunches. Ein Bunch ist bspw. die Assoziation eines Payloads mit einem Project. Es kann aber auch noch bspw. einen zusätzlich zu verwendenden Text beschreiben. Der Bunch ist somit die semantische Klammer für ein domainspezifisches "Ding". 

Im Series-App-Beispiel kann das ein einzelnes Polaroid oder eine Seite in einem Fotobuch sein. Der Processor entscheidet anhand der Bunches, wie viele Produkte oder Seiten er generieren kann. In der Segmentierungsphase dient dazu das bloße Wissen um die Existenz der BunchItems zzgl. Infos über die Bildgröße (s. Payload).

# Processor, Carts und Output

## Implementierungen

Das Herzstück von ToPhoto sind die Processoren. Diese sind immer domainspezifisch oder zumindest domainspezifisch parametrisiert. Für jeden Produkttyp gibt es eine Klassenhierarchie, die von einer generellen Oberklasse immer spezifischer bis hin zur Domainimplementierung führt und auf dem Weg immer weitere Funktionen und Parameter hinzufügt. 

Am Beispiel hier die Klassenhierarchie für ein [Wer ist König](https://app.nuclino.com/t/b/4d365a5e-449d-436b-a555-b14548fe0443) 10x10 RuckZuck-Fotobuch:

![](https://files.nuclino.com/files/2ac3773e-b19c-4e91-a742-612758172c26/weristkoenig10x10rzhiearchie.png)

## SubcartItem und Output

Ein Processor bestimmt aufgrund der verfügbaren Bunches und deren BunchItems zu einem Project die SubcartItems. Diese beziehen sich immer auf eine spezielle SKU. Wenn ein Processor bspw. errechnet, dass 8 Fotoabzüge aus einem Projekt entstehen sollen, werden 8 SubcartItems erstellt. Die Items haben dabei sog. ProcessorIndices von 0 bis 7. Die vom Processor/Renderer erstellten Outputs haben wiederum einen ProcessorIndex von 0 bis 7. Über die Kombination von Project + ProcessorIndex erfolgt die Zuordnung beim Export zwischen SubcartItem und Output.

Weil manche Produkte aus mehreren Dateien bestehen, enthält ein Output eine Liste von Dateien.

## Cart und Subcart

Aufgrund der bereits beschriebenen SubcartItems ermittelt das System, welche Produzenten für diese Produkte zur Verfügung stehen. Dies ist das erste Segmentierungsmerkmal. Innerhalb der Produzentenimplementierungen werden diese Segmente bei Bedarf noch einmal ausgeteilt. Dies kann bspw. aufgrund unterschiedlicher Produktionsstandorte oder Versandmodalitäten geschehen.

# Renderer

Das Renderer-Framework ermöglicht es über High-Level-Methoden Grafiken zu erstellen. Bei den meisten Processoren wird über eine Zwischendatei im SVG-Format gearbeitet. SVGs ermöglichen dabei insbesondere die Verwendung von Schatten und Gruppierungen. Aus den SVGs werden anschließend die Pixelformate und oder PDFs erzeugt.

Neben den reinen "Malfunktionen" ist zusätzlich ein  Szenengraph implementiert, der insbesondere einen Transformationsstack ermöglicht, um strukturiert Grafikbefehle einer kumulierten Transformation zu unterziehen.

## Methoden

* drawImage(Image img, int x, int y, int width, int height)
* drawImage(Image img, int x, int y) 
* drawString(String s, Color color, Font f, int x, int y) 
* drawRoundedRect(Color color, int radius, float linewidth, int x, int y, int width, int height) 
* drawImage(File img, int x, int y, int width, int height) 
* fillRect(Color color, int x, int y, int width, int height) 
* fillCircle(Color color, int x, int y, int diameter) 
* fillRoundedRect(Color c, int radius, int x, int y, int width, int height)
* addShadowDefinition(String name, int size, int offsetX, int offsetY, double opacity)
* activateShadow(String name) deactivateShadow()
* transform(Point2D p)
* pushTransform(AffineTransform at) 
* popTransform() 
* pushRotation(double x, double y, double angle) 
* pushRotation(double angle) 
* pushTranslation(double x, double y) 
* pushScale(double sx, double sy) 
* pushClip(int x, int y, int width, int height) 
* popClip()