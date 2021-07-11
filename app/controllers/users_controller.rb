class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    render "users/new"
  end

  def index
    render plain: User.all.map { |todo| todo.to_pleasant_string }.join("\n")
  end

  def create
    User.create!(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
    )
    redirect_to "/"
  end

  def login
    user = User.find_by("email = ?  and password = ?", params[:email], params[:password])
    output = user ? "Welcome #{user.name}" : "The e-mail address and/or password you specified are not correct."
    render plain: output
  end
end
