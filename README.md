# README

## Installation

### Install ruby
Using your favorite ruby version manager:

- [rvm](https://rvm.io/rvm/install)
- [rbenv](https://github.com/rbenv/rbenv)

### Install PostgreSQL and run PostgreSQL server
[Installation Guide](https://www.postgresqltutorial.com/postgresql-getting-started/)

### Clone repo
>$ git clone git@github.com:snp4uk/bank_test.git

### Change directory
>$ cd bank_test

### Install bundler
>$ gem install bundler -v $(cat Gemfile.lock | grep -A1 BUNDLED | grep "  ")

### Run bundle install
>$  bundle install

## Running tests
To run all test execute 
>$ bundle exec rspec spec

To run specific test execute
>$ bundle exec rspec <path_to_spec_file>

## Running application on local machine
### Create database
>$ bundle exec rake db:create
### Run migrations
>$ bundle exec rake db:migrate
### Run seeds
>$ bundle exec rake db:seed

This will create two users:
1. john.smith@example.com / P@ssword1!
2. jame.smith@example.com / P@ssword1!

### Launch server
>$ bundle exec rails server

Open your browser and go to `http://localhost:3000/`

## Supporting tasks
### Create new user
>$ bundle exec rake "users:create[user_email,user_password]"

`user_email` - required, string, valid email address
`user_password` - required, string, 6 or more characters 
### Add funds to user's bank account
>$ bundle exec rake "users:refill_account[user_email,amount]"

`user_email` - required, string, email address of existing user
`amount` - require, float, greater than 0

