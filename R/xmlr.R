#' xmlr
#' @description A package for creating and reading and manipulating XML
#' inspired by JDOM (http://www.jdom.org/), implemented with Reference Classes.
#' @import methods
#' @docType package
#' @name xmlr
#' @examples
#' library("xmlr")
#' doc <- Document$new()
#' root <- Element$new("table")
#' root$setAttribute("xmlns", "http://www.w3.org/TR/html4/")
#' doc$setRootElement(root)
#'
#' root$addContent(
#'   Element$new("tr")
#'     $addContent(Element$new("td")$setText("Apples"))
#'     $addContent(Element$new("td")$setText("Bananas"))
#' )
#' table <- doc$getRootElement()
#' stopifnot(table$getName() == "table")
#' stopifnot(table$getAttribute("xmlns") == "http://www.w3.org/TR/html4/")
#'
#' children <- table$getChild("tr")$getChildren()
#' stopifnot(length(children) == 2)
#' stopifnot(children[[1]]$getText() == "Apples")
#' stopifnot(children[[2]]$getText() == "Bananas")
#'
#' # you can also parse character strings (or parse a file using parse.xmlfile(fileName))
#' doc <- parse.xmlstring("<foo><bar><baz val='the baz attribute'/></bar></foo>")

NULL