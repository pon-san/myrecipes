class SessionsController < ApplicationController
  
  def new    
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      cookies.signed[:user_id] = user.id
      flash[:success] = "You have successfully logged in"
      redirect_to user
    else
      unless @email.present? && @email.include?('@') && !@email.end_with?('@gmail.con', '@gmai.com', '@gnai.com', '@gnail.con', '@gnai.co', '@gmail.co', '.me.jp')
        @email_error =
          if @email.present?
            'email should be present'
          else
            'email is invalid'
          end
        return render 'new'  
      end
      flash.now[:danger] = "There was something wrong with your login information"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:success] = 'You have successfully logged out'
    redirect_to root_path
  end
end