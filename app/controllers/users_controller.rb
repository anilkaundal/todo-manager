class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render plain: User.all.map { |todo| todo.to_pleasant_string }.join("\n")
  end

  def create
    name = params[:name]
    email = params[:email]
    password = params[:password]
    input = (name == nil || email == nil || password == nil) ? nil : User.create!(name: name, email: email, password: password)
    response_text = input == nil ? "Input can't be empty!! " : "Hey, your account is created with id #{input.id}"
    render plain: response_text
  end
end
