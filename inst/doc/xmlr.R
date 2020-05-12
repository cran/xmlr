## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(xmlr)


## -----------------------------------------------------------------------------
doc <- parse.xmlstring("
<table xmlns='http://www.w3.org/TR/html4/'>
    <tr>
        <td class='fruit'>Apples</td>
        <td class='fruit'>Bananas</td>
    </tr>
</table>")

## ---- eval = FALSE------------------------------------------------------------
#  doc <- parse.xmlfile("pom.xml")

## -----------------------------------------------------------------------------
doc <- Document$new()
root <- Element$new("table")
root$setAttribute("xmlns", "http://www.w3.org/TR/html4/")
doc$setRootElement(root)

root$addContent(
Element$new("tr")
  $addContent(
    Element$new("td")$setAttribute("class", "fruit")$setText("Apples")
  )
  $addContent(
    Element$new("td")$setAttribute("class", "fruit")$setText("Bananas")
  )
)
# print it out just to show the content
print(doc)

## -----------------------------------------------------------------------------
doc$getRootElement()$getChild("tr")$getChildren()[[2]]$getText()

## -----------------------------------------------------------------------------
groceriesDf <- NULL
for ( child in doc$getRootElement()$getChild("tr")$getChildren() ) {
  row <- list()
  row[["class"]] <- child$getAttribute("class")
  row[["item"]] <- child$getText()
  if (is.null(groceriesDf)) {
    groceriesDf <- data.frame(row, stringsAsFactors = FALSE)
  } else {
    groceriesDf <- rbind(groceriesDf, row)
  }
}
groceriesDf

## -----------------------------------------------------------------------------
# print the contents of the tr element 
root$getChild("tr")

## -----------------------------------------------------------------------------
paste("The root element is", root)

## -----------------------------------------------------------------------------
e <- Element$new()
e$setName("foo")

## -----------------------------------------------------------------------------
e <- Element$new("foo")$addContent(
  Element$new("Bar")$setAttribute("note", "Some text")
)$addContent(
  Element$new("Baz")$setAttribute("note", "More stuff")
)
e

## -----------------------------------------------------------------------------
e <- Element$new("car")$setText("Volvo")

## -----------------------------------------------------------------------------
  xml <- "<car>Volvo<value sek='200000'></value></car>"
  e <- Element$new("car")
  e$addContent(Text$new("Volvo"))
  e$addContent(Element$new("value")$setAttribute("sek", "200000"))
  stopifnot(e$toString() == xml)

## -----------------------------------------------------------------------------
parent <- Element$new("parent")
parent <- Element$new("parent")$setAttribute("xmlns:env", "http://some.namespace.com")
parent$addContent(Element$new("env:child"))
parent

## -----------------------------------------------------------------------------
xml <- "
<groceries>
  <item type='fruit' number='4'>Apples</item>
  <item type='fruit' number='2'>Bananas</item>
  <item type='vegetables'number='6'>Tomatoes</item>
</groceries>
"
doc <- parse.xmlstring(xml)
xmldf <- xmlrToDataFrame(doc$getRootElement())
xmldf

## -----------------------------------------------------------------------------
isRc(Element$new("Hello"), "Element")
isRc(Text$new("Hello"), "Element")


