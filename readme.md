# Ticket Bot

## Mission
Create a Slack Bot that returns Github issue data. It's currently in slash command form, but could be extended for more functionality.

## Setup
Go through your normal Slack `/ command` setup.  
Required ENV variables:
```
  ORGANIZATION
  REPO
  SLACK_VERIFICATION_TOKEN
  GH_OAUTH_TOKEN
```

## Requirements
- Node.js & Coffee-Script & Npm
- (optional) PM2

## Start
```
// The first time
$ npm install -g pm2 coffee-script
$ pm2 install coffeescript
$ npm install
// start app
$ npm start