# README

A Ruby application that indexs the packages in a CRAN server

The application is built over Ruby on Rails. I've built 2 scraper classes that scrap the Cran server to get all the data about the packages. The data is then stored in mysql server so that they can be displayed on the portal.

#Challenges

1-Parsing author names appears as a challenge because the way of presentation is not consistent.


# Technologies

* Ruby on Rails
* MySql

# Building Instructions

1- `bundle install`

2- `rake db:setup`

3- `whenever -s` to set cron job to run at 12pm everyday

# Running Tests
run command `rspec` in root directory

# Scrap for the first time
`rails r "CranScraper.new"`
