express = require "express"
router = express.Router()
githubApi = require "../lib/github"

# heart beat
router.get "/", (req, res, next) ->
  res.json status: "success"

router.post "/slack/ticket", (req, res, next) ->
  issueNum = Number req.body.text or null

  githubApi.getIssue issueNum
  .then (issue) ->
    res.json text: issue, response_type: "in_channel"
  .catch (err) ->
    console.error err
    if err.statusCode is 404
      res.json text: "Sorry, ticket not found"
    else
      res.json text: "Sorry, internal error"

module.exports = router