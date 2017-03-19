# github service
rq = require "request-promise"
Promise = require "bluebird"
settings = require "../config/settings"

HOST = settings.GH_API_HOST
ISSUE_URI = settings.GH_ISSUE_URI
AUTH_TOKEN = settings.GH_OAUTH_TOKEN
ENDPOINT = HOST + ISSUE_URI

# Get GH issue
getIssue = (issueNum) ->
  if not issueNum
    Promise.reject new Error "Invalid Issue Number"
  options=
    headers:
      'User-Agent': 'ticket-bot'
      'Authorization': "token #{AUTH_TOKEN}"
    uri: "#{ENDPOINT}/#{issueNum}"
    json: true

  rq options
  .then (issue) ->
    _formatMessage issue

# Format message
_formatMessage = (issue) ->
  assignees = if issue.assignees then issue.assignees.map((user) -> user.login).join ', ' else "None"
  creator = if issue.user then issue.user.login else "None"
  lables = if issue.labels and issue.labels.length then issue.labels.map((label) -> label.name).join ', ' else "N/A"
  state = if issue.state then issue.state else "N/A"

  "#{issue.number} - #{issue.title} \n #{issue.html_url} \n
  Assignees: #{assignees} - Creator: #{creator} \n Labels: #{lables} - State: #{state}"

module.exports =
  getIssue: getIssue
