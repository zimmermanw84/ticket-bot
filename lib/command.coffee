# simple comand parsing module
settings = require "../config/settings"

# hack to support aliases for repos
REPO_ALIASES =
  site: "soxhub-site"

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
  # Check for aliases (I think I am going a little crazy with coffee script lol)
  commandObj.repo = if REPO_ALIASES.hasOwnProperty(commandObj.repo) then REPO_ALIASES[commandObj.repo] else commandObj.repo
  # check for int values
  if isNaN Number commandObj.issueNum
    throw new Error "Single inputs must be an issue number!"
  else
    commandObj

module.exports =
  parse: parse