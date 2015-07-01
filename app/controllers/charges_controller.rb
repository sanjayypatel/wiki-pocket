class ChargesController < ApplicationController

  def new
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "Wiki Pocket Premium Account Upgrade - #{current_user.username}",
      amount: Amount.default,
      email: current_user.email
    }
  end

  def create

    # Create Stripe Customer object
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    #Create a Stripe Charge object
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: Amount.default,
      description: "Wiki Pocket Premium Account Upgrade - #{current_user.email}",
      currency: 'usd'
    )

    flash[:success] = "Thanks for your payment, #{current_user.email}!"
    #### How do I trigger the UsersController#upgrade method? ####

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path
  end

  def upgrade_user(user)

  end

  class Amount
    def self.default
      return 15_00
    end
  end



end