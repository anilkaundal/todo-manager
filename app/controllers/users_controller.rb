class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render plain: User.all.map { |todo| todo.to_pleasant_string }.join("\n")
  end
end