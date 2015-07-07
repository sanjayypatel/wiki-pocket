class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    authorized_wikis = policy_scope(Wiki)
    @wikis = authorized_wikis.select { |w| @user.is_owner_of?(w) }
    @shared_wikis = authorized_wikis.select { |w| w.is_owned_by?(@user) }
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated"
    else
      flash[:error] = "Invalid user information"
    end
    redirect_to edit_user_registration_path
  end

  def downgrade
    current_user.downgrade
    redirect_to user_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end


end
