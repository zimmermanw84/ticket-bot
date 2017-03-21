# simple comand parsing module
settings = require "../config/settings"

_buildCmdObj = (text) ->
  # split on space to get our args filter out #
  args = text.split(" ").map (arg) -> arg.replace "#", ""
  # result object
  result = repo: null, issueNum: null
  # provided a repo case
  if args.length > 1
    result.repo = args[0]
    result.issueNum = args[1]
  else
    result.repo = settings.REPO
    result.issueNum = args[0]

  result

# public api
###
  first argument is a repo string and if it's not provided then we expect it to be a number
###
parse = (text) ->
  commandObj = _buildCmdObj text
  # check for int values
  if isNaN Number commandObj.issueNum
    throw new Error "Single inputs must be an issue number!"
  else
    commandObj

module.exports =
  parse: parse