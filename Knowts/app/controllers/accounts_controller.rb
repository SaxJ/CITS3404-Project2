class AccountsController < ApplicationController
  def signed_in
    if not user_signed_in?
      redirect_to login_path
    end

  end

  def sign_in
    if user_signed_in?
      redirect_to loggedin_path
    end
  end

  def sign_out
  end

  def register
  end



end
