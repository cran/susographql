#' Utility function to check if credentials are correct
#'
#' This function returns a 200 status code if credentials are correct and a 400 code otherwise.
#'
#' @param endpoint Survey Solutions GraphQl
#' @param user API user
#' @param password API password
#' @param workspace endpoint workspace Name, if nothing provided, defaults to primary
#' @param token If Survey Solutions endpoint token is provided \emph{user} and \emph{password} will be ignored
#'
#' @return 200 code if correct, 400 if incorrect.
#'
#'
#' @examples
#'
#'
#' # With default credentials returns 400
#' suso_gql_pwcheck()
#'
#'
#'
#' @export
suso_gql_pwcheck<-function(endpoint=NULL,
                       user=NULL,
                       password=NULL,
                       workspace = NULL,
                       token = NULL) {
  if(is.null(endpoint) | is.null(user) | is.null(password)) {
    # return 400 if any is missing
    return(400)
  }

  # also skip when empty string
  if((endpoint=="") | (user=="") | (password=="")) {
    # return 400 if any is missing
    return(400)
  }
  ## workspace default
  workspace<-.ws_default(ws = workspace)
  # check (.helpers.R)
  .check_basics(token, endpoint, user, password)

  query <- sprintf('
      query($workspace: String $where: InterviewsFilter $order: [InterviewSort!] $take: Int $skip: Int){
          interviews(workspace: $workspace where: $where order: $order take: $take skip: $skip) {
                            totalCount
                            filteredCount
          }
      }
  ')

  variables <- list()
  if (!is.null(workspace)) {
    variables$workspace <- workspace
  }
  # 2. Filter
  # 2.1 Filter default is NULL
  variables$where<-NULL

  variables$take<-1

  # create the body of the request
  body <- list(query = query)
  if (!is.null(variables)) {
    body$variables <- variables
  }

  # Build the URL, first for token, then for base auth
  if(!is.null(token)){
    #url<-.baseurl_token(endpoint, body, token, retry = 3)
  } else {
    url<-.baseurl_baseauth(endpoint, body, user, password, retry = 3)
  }

  # perform the request
  result<-tryCatch(
    {checker<-function(url) {
      rq<-.perform_request(url)
      if(is.numeric(rq$data$interviews$totalCount)) {
        return(200)
      } else {
        return(400)
      }
      }
    checker(url)},
    error = function(e) return(400)
    )
  return(result)
}





