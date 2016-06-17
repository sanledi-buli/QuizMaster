This application for sample Quiz.

## Prerequisites

1. Ruby 2.3.1
2. MySQL
3. bundler

## TODO

- [x] Manage the questions.
- [x] Quiz mode.

## Setting up the project

1. git clone https://github.com/sanledi-buli/QuizMaster.git
2. cd QuizMaster
3. set up database.yml
4. bundle install
5. rake db:create
6. rake db:migrate
7. rake assets:precompile RAILS_ENV=development
8. rails s

## Backoffice

http://localhost:3000/backoffice/questions