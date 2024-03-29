#' Get all Questionnaires
#'
#'  Get all Questionnaires in the workspace or only a selected one/versions.
#'
#' @param endpoint GraphQL endpoint of your server
#' @param workspace Server Workspace, if NULL uses default
#' @param user your API username
#' @param password API password
#' @param token If Survey Solutions server token is provided \emph{apiUser} and \emph{apiPass} will be ignored
#' @param id Questionnaire ID
#' @param version Questionnaire version
#' @param take take the specified integer numeber of questionnaires
#' @param skip skip the first integer number of questionnaires
#'
#' @return if successfull, returns a list with the responses
#'
#' @examplesIf suso_gql_pwcheck()==200
#' ## Requires Survey Solutions Server and API credentials
#'
#' # Get all questionnaires in workspace ws
#'
#' suso_gql_questionnaires(endpoint = ep, user = usr,
#' password = pass, workspace = ws)
#'
#' @export






suso_gql_questionnaires <- function(endpoint = NULL,
                                    workspace = NULL,
                                    user = NULL,
                                    password = NULL,
                                    token = NULL,
                                    id = NULL,
                                    version = NULL,
                                    take = NULL,
                                    skip = NULL) {
  # workspace default
  workspace<-.ws_default(ws = workspace)

  # Check for essential variables
  .check_basics(token, endpoint, user, password)

  # define your query
  query <- sprintf('
          query($workspace: String $id: UUID $version: Long $take: Int $skip: Int){
            questionnaires(workspace: $workspace id: $id version: $version take: $take skip: $skip){
              totalCount
              filteredCount
              nodes {
                variable
                questionnaireId
                version
                id
                title
                defaultLanguageName
                translations {
                  name
                  id
                }
              }
            }
          }
  ')
  ################################
  # create the variables list
  # 1. Top level
  variables <- list()
  if (!is.null(workspace)) {
    variables$workspace <- workspace
  }

  if (!is.null(id)) {
    variables$id <- id
  }

  if (!is.null(version)) {
    variables$version <- version
  }

  if (!is.null(take)) {
    stopifnot(
      (take%%1==0)
    )
    variables$take <- take
  }

  if (!is.null(skip)) {
    stopifnot(
      (skip%%1==0)
    )
    variables$skip <- skip
  }


  # create the body of the request
  body <- list(query = query)
  if (!is.null(variables)) {
    body$variables <- variables
  }

  # build the url
  url<-.baseurl_baseauth(endpoint, body, user, password, retry = 3)

  # perform the request
  result<-.perform_request(url)
  return(result$data)
}
