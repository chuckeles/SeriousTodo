# Overview

This is a documentation for the DBS class. The application itself is also for VOS class. It enables it's users to connect to their Todoist account, sync their tasks and then pledge money to complete them.

The application is written in Ruby on Rails. It uses Postgresql database. The frontend is plain HTML and CSS (well, actually Slim and SASS).

### Links

There are the most important links:

- [Github repository](https://github.com/chuckeles/serious-todo)
- [Trello board](https://trello.com/b/LywuGdtf/serious-todo)
- [Travis](https://travis-ci.org/chuckeles/serious-todo)
- [Heroku hosted version](https://serious-todo.herokuapp.com)

## Functionality

The functionality implemented so far is as follows. The user can create an account. The email address has to be confirmed. The app uses [Devise](http://devise.plataformatec.com.br/) for user management and [Gravatar](http://www.gravatar.com/) for profile images. Then the user can connect his Todoist account. After that the app can fetch Todoist tasks and display them.

## Database Model

It is very simple. `users` for users and `todo_apps` for Todoist connections (tokens). Check the [`db/schema.rb` file](https://github.com/chuckeles/serious-todo/blob/master/db/schema.rb) for the current database schema.

## Tests

I use [RSpec](http://rspec.info/) and [Capybara](https://github.com/jnicklas/capybara) for testing. See the [`spec` folder](https://github.com/chuckeles/serious-todo/tree/master/spec).

## Where is your SQL?

It is in the [model TodoApp](https://github.com/chuckeles/serious-todo/blob/master/app/models/todo_app.rb#L6) and [here are the specs](https://github.com/chuckeles/serious-todo/blob/master/spec/models/todo_app_spec.rb#L22).

## Where is the database dump?

I don't think there's any need for that. The database config is set up to use the defaults. Just load the schema with `rake db:schema:load`. Then create an account and connect Todoist.
