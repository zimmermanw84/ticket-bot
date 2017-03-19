# app settings
SLACK_VERIFICATION_TOKEN = process.env.SLACK_VERIFICATION_TOKEN or null
GH_OAUTH_TOKEN = process.env.GH_OAUTH_TOKEN or null

ORG = process.env.ORGANIZATION
REPO = process.env.REPO

GH_API_HOST = "https://api.github.com"
GH_ISSUE_URI = "/repos/#{ORG}/#{REPO}/issues"

# simple validations
unless SLACK_VERIFICATION_TOKEN and GH_OAUTH_TOKEN and ORG and REPO
  throw new Error "Please make sure your ENV is set correctly."

module.exports =
  SLACK_VERIFICATION_TOKEN: SLACK_VERIFICATION_TOKEN
  GH_OAUTH_TOKEN: GH_OAUTH_TOKEN
  GH_API_HOST: GH_API_HOST
  GH_ISSUE_URI: GH_ISSUE_URI