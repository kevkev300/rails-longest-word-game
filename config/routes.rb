# frozen_string_literal: true

# top-level documentation class comment
Rails.application.routes.draw do
  # page to display game settings and get user input
  get '/new', to: 'games#new', as: :new_game

  # page to recieve form, comupte the score and display it
  post '/score', to: 'games#score'
end
