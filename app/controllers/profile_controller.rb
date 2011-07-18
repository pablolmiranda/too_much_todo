class ProfileController < ApplicationController
  def show
    @user = User.find(params[:id]) rescue nil
    redirect_to root_path unless @user
  end

end
