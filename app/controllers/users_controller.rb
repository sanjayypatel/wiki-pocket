class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show

  def show
    @user = User.friendly.find(params[:id])
    authorized_wikis = policy_scope(Wiki)
    @wikis = authorized_wikis.select{ |w| @user.is_owner_of?(w) }.paginate(page: params[:page], per_page: 5)
    @shared_wikis = authorized_wikis.select { |w| w.is_owned_by?(@user) }.paginate(page: params[:page], per_page: 5)
    @links = @user.links.paginate(page: params[:page], per_page: 5)
    @active_tab = params[:tab] || "my-wikis"
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
