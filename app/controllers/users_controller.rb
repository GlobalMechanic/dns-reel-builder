class UsersController < ApplicationController
  before_filter :authenticate_user!

  # GET /admin/users
  # GET /admin/users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /clips/new
  # GET /clips/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /admin/users/1/edit
  def edit
    @user = User.find(params[:id])
  end

end

# Might need for update, from: https://github.com/plataformatec/devise/wiki/How-To:-Manage-users-through-a-CRUD-interface
# if params[:user][:password].blank?
#   params[:user].delete(:password)
#   params[:user].delete(:password_confirmation)
# end
