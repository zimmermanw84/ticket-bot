# simple comand parsing module
settings = require "../config/settings"

# hack to support aliases for repos
REPO_ALIASES =
  site: "soxhub-site"
  api: "soxhub-api"
  client: "soxhub-client"

# request to github type
TYPES =
  ISSUE: 'issues'
  PR: 'pulls'

###
  @private
  deconstruct the string text and return an command obj
  cases
    - if single num then it's an issue number and makes the default issue request to default repo
    - if we have to check to see if it's a pr or issue pr:<somenum> if no pr: then it's assumed to be an issue
###
_buildCmdObj = (text) ->
  # split on space to get our args filter out #
  args = text.split(" ").map (arg) -> arg.replace "#", ""
  # result object default type is issue
  result = repo: null, targetNum: null, type: TYPES.ISSUE
  # provided a repo case
  if args.length > 1
    result.repo = args[0]
    result.targetNum = args[1]
  else
    result.repo = settings.REPO
    result.targetNum = args[0]

  flagAndId = result.targetNum.split(":")
  # check for repo flag
  if flagAndId[0] is "pr"
    result.type = TYPES.PR
    # second position will be the number
    result.targetNum = flagAndId[1]

  result

###
  @public
  simple error check and build command obj
###
parse = (text) ->
  commandObj = _buildCmdObj text
  # Check for aliases (I think I am going a little crazy with coffee script lol)
  commandObj.repo = if REPO_ALIASES.hasOwnProperty(commandObj.repo) then REPO_ALIASES[commandObj.repo] else commandObj.repo
  # check for int values
  if isNaN Number commandObj.targetNum
    throw new Error "Single inputs must be an issue number!"
  else
    commandObj

module.exports =
  parse: parse