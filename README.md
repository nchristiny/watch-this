# WATCH THIS!
## Jellyvision Developer Apprentice project
## Nick Christiny
---

`watch-this` is a JSON API-only backend built on Rails using Mongoid ODM framework for MongoDB in Ruby.
It is consumed by `ui-watch-this`, a front-end React app.

### Dependencies
* rails
* anemone
* nokogiri
* mongoid
* quiet_assets
* rspec-rails
* factory_girl_rails
* database_cleaner
* shoulda-matchers
* faker

### Instructions
1. `bundle install`
2. `be rake db:mongoid:create_indexes`
3. `be rake db:create`
4. `be rake db:seed`
5. `rails s`

### Tests
`be rspec`

### TODO
* ~~Implement user query page as defaul landing page~~ Moved to front-end
* ~~Ask user's preferences and present best choice~~ Moved to front-end
* ~~Find missing genre fields and update those documents with accurate data~~
* ~~Separate UI and JSON-only API into two stand-alone apps.~~
* Implement a type of 'weighted' score for each recommendation field.
