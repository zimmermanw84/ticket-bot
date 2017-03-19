# app settings
SLACK_VERIFICATION_TOKEN = process.env.SLACK_VERIFICATION_TOKEN or null
GH_OAUTH_TOKEN = process.env.GH_OAUTH_TOKEN or null

ORG = process.env.ORGANIZATION or "soxhub"
REPO = process.env.REPO or "qa"

GH_API_HOST = "https://api.github.com"
GH_ISSUE_URI = "/repos/#{ORG}/#{REPO}/issues"

# simple validations
unless SLACK_VERIFICATION_TOKEN
  throw new Error "Please Set VERIFICATION_TOKEN in the ENV"

unless GH_OAUTH_TOKEN
  throw new Error "Please Set GH_OAUTH_TOKEN in the ENV"


module.exports =
  SLACK_VERIFICATION_TOKEN: SLACK_VERIFICATION_TOKEN
  GH_OAUTH_TOKEN: GH_OAUTH_TOKEN
  GH_API_HOST: GH_API_HOST
  GH_ISSUE_URI: GH_ISSUE_URI