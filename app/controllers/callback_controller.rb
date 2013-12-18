#ending utf-8
class CallbackController < ApplicationController
  def authentication
    user_info = Manager.find_by(project_name: params[:project_name]).get_token(params[:code])
    user_info = JSON.parse( user_info )
    user = Manager.find_by(project_name: params[:project_name]).users.create(
      uid: user_info['id_token'], 
      token: user_info['access_token'], 
      refresh_token: user_info['refresh_token']
      )
    if user.save
      render json: {message: "授权成功"}
    else
      render json: {message: "授权失败"}
    end
  end
end
