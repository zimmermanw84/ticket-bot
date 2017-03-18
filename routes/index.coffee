express = require "express"
router = express.Router()

# heart beat
router.get "/", (req, res, next) ->
  res.json status: "success"

module.exports = router