<?php echo '<?xml version="1.0"?>'; ?>
<!DOCTYPE rdf:RDF PUBLIC "-//DUBLIN CORE//DCMES DTD 2002/07/31//EN"
"https://dublincore.org/documents/2002/07/31/dcmes-xml/dcmes-xml-dtd.dtd">
<rdf:RDF xmlns:rdf="https://www.w3.org/1999/02/22-rdf-syntax-ns#"
xmlns:dc="https://purl.org/dc/elements/1.1/">
<?php 
$convert = new Output_ItemDcmesXml;
echo $convert->recordToDcmesXml($item); ?>
</rdf:RDF>
