Rails.application.routes.draw do

  root                     to: "static_pages#home"
  get "about",             to: "static_pages#about"

  devise_for :users

  get "users/:name",                  to: "users#show", as: :user
  get "todo-apps/connect",            to: "todo_apps#connect"
  get "todo-apps/connect/todoist",    to: "todo_apps#connect_todoist"
  get "todo-apps/disconnect",         to: "todo_apps#disconnect"
  get "todo-apps/disconnect/todoist", to: "todo_apps#disconnect_todoist"
  get "tasks",                        to: "tasks#index"

end
