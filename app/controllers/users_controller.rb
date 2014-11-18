class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  require 'will_paginate/array'
  def index
    @user = User.new
    @users = User.all.paginate(:order =>"name ASC" ,:page => params[:page], :per_page => 5)
    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.js
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        #@users = User.all.paginate(:order =>"name ASC" ,:page => params[:page], :per_page => 5)
        #format.js 
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_url, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def login_new
    @user = User.new
  end

  def login
    @user=User.where("email=? AND password=?",params[:email],params[:password]).last
    session[:user] = @user
     respond_to do |format|
     if @user
        format.html { redirect_to users_url, notice: 'User was successfully login.' }
        format.json { head :no_content }
      else
        format.html { render action: "login" }
        format.json { render json: @users.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

 def logout
    reset_session
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
end


