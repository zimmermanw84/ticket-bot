express = require "express"
router = express.Router()
githubApi = require "../lib/github"
commandParser = require "../lib/command"

# heart beat
router.get "/", (req, res, next) ->
  res.json status: "success"

router.post "/slack/test", (req, res, next) ->
  response = commandParser.parse req.body.text
  res.json text: response

router.post "/slack/ticket", (req, res, next) ->
  textArgs = commandParser.parse req.body.text
  issueNum = textArgs.issueNum
  repo = textArgs.repo

  githubApi.getIssue issueNum, repo
  .then (issue) ->
    res.json text: issue, response_type: "in_channel"
  .catch (err) ->
    console.error err
    if err.statusCode is 404
      res.json text: "Sorry, ticket not found"
    else
      res.json text: "Sorry, internal error"

module.exports = router