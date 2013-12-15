class Api::V1::PushersController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def push
    articleid = params[:id]
    project = Article.find_by(id: articleid).manager
    push_module(project)
  end




  
  def push_module(manager)
    @users = Manager.find_by(id: manager.id).users
    @users.each do |user|
      token = new_token(manager, user)
      token = JSON.parse(token)
      access_token = token['access_token']
      binding.pry
    end
  end



  def new_token(manager, user)
    RestClient.post "https://accounts.google.com/o/oauth2/token", {
      client_id: manager.client_id,
      client_secret: manager.client_secret,
      refresh_token: user.refresh_token,
      grant_type: 'refresh_token'
      }
  end




end
