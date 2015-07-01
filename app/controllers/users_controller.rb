class UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated"
    else
      flash[:error] = "Invalid user information"
    end
    redirect_to edit_user_registration_path
  end

  def upgrade
    @user = current_user
    @user.update_attribute(:role, 'premium')
    redirect_to edit_user_registration_path(current_user)
  end

  def downgrade
    @user = current_user
    @user.update_attribute(:role, 'standard')
    redirect_to edit_user_registration_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end


end
