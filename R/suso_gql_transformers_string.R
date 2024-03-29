#' @title Utility Functions for string operator selection
#'
#' @name transformers.string
#'
#' @description Can be used in filters ("where") for operator selection. If none is selected, operator always defaults to `eq()`. The functions bellow are
#' valid for the corresponding inputs ComparableInt64OperationFilterInput and ComparableNullableOfInt32OperationFilterInput.
#'
#' @details Also see the \link{susoop_str} selector list, which allows you, to just select the function from
#' a named list.
#'
#' @param value_set the parameter set for the operator
#'
#' @examples
#'
#' # set filter so that the string contains "area"
#' contains("area")
#'
#' # set filter to string ending with .shp
#' endsWith(".shp")
#'
#' @return a list with a single named element (operator name) to be handed over to the filter.
#'
NULL


#' @describeIn transformers.string contains
#' @export

contains<-function(value_set) {list(contains = value_set)}

#' @describeIn transformers.string ends with
#' @export

endsWith<-function(value_set) {list(endsWith = value_set)}

#' @describeIn transformers.string not contains
#' @export

ncontains<-function(value_set) {list(ncontains = value_set)}


#' @describeIn transformers.string not ends with
#' @export
#'
nendsWith<-function(value_set) {list(nendsWith = value_set)}

#' @describeIn transformers.string not starts with
#' @export
#'
nstartsWith<-function(value_set) {list(nstartsWith = value_set)}

#' @describeIn transformers.string starts with
#' @export
#'
startsWith<-function(value_set) {list(startsWith = value_set)}

#' @describeIn transformers.string in
#' @export
#'
inclu<-function(value_set) {list(`in` = value_set)}

#' @describeIn transformers.string not in
#' @export
#'
ninclu<-function(value_set) {list(nin = value_set)}

