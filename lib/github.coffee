# github service
rq = require "request-promise"
settings = require "../config/settings"

HOST = settings.GH_API_HOST
ORG = settings.ORG
AUTH_TOKEN = settings.GH_OAUTH_TOKEN

# Get GH data
getData = (args) ->
  ENDPOINT = HOST + "/repos/#{ORG}/#{args.repo}/#{args.type}"

  options=
    headers:
      'User-Agent': 'ticket-bot'
      'Authorization': "token #{AUTH_TOKEN}"
    uri: "#{ENDPOINT}/#{args.targetNum}"
    json: true

  rq options
  .then (data) ->
    _formatMessage data

# Format message
_formatMessage = (item) ->
  assignees = if item.assignees then item.assignees.map((user) -> user.login).join ', ' else "None"
  creator = if item.user then item.user.login else "None"
  lables = if item.labels and item.labels.length then item.labels.map((label) -> label.name).join ', ' else "N/A"
  state = if item.state then item.state else "N/A"

  "#{item.number} - #{item.title} \n #{item.html_url} \n
  Assignees: #{assignees} - Creator: #{creator} \n Labels: #{lables} - State: #{state}"

module.exports =
  getData: getData
