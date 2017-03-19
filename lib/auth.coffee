# Super simple auth middleware for slack interaction
settings = require "../config/settings"

# slack token
TOKEN = settings.SLACK_VERIFICATION_TOKEN

module.exports = (req, res, next) ->
  unless req.body.token is TOKEN
    res.status(401).json status: "unauthorized"
  else
    next()
