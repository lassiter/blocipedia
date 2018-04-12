require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  context 'Rendering for Users' do
    describe 'GET index' do
    before do
      # user.confirm
      sign_in user
    end
      it 'renders the index template' do
        get :index, :format => "html"
        expect(response).to render_template("index")
      end
      it "has a 200 status code" do
        get :index
        expect(response.status).to eq(200)
      end
    end
  end
  feature 'current_user can control their account' do #todo
    it "and can sign in" do #fix
      visit new_user_session_path
      within("#new_user") do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
      end
      click_button 'Login'
      expect(response.status).to eq(200)
      expect(page).to have_content 'Signed in successfully.'
    end

    # scenario 'and allows them to upgrade their account and can add a payment method' do
    #     user.role = 'premium'
    #     sign_in user
    #     visit user_path(id: user.id)
    #     click_button('.stripe-button-el', 30)
    #       # optionally ensure the iframe was opened
    #     sleep(0.7)
    #       expect(page).to have_css('iframe[name="stripe_checkout_app"]')
    #       # post the form
    #       token = Stripe::Token.create(
    #         :card => {
    #           :number => "4242424242424242",
    #           :exp_month => 7,
    #           :exp_year => 2019,
    #           :cvc => "314",
    #           address_line1: Faker::Address.street_address,
    #           address_city: Faker::Address.city,
    #           address_zip: Faker::Address.postcode,
    #           address_country: 'United Kingdom'
    #         },
    #       )
    #       page.execute_script("$('#payment_token').val('#{token.id}');")
    #       page.execute_script("$('#our-stripe-payment-form').submit();")
    #     expect(page).to redirect_to new_charge_path

    # end
  #   scenario 'and allows them to downgrade their account' do
  #       login_as(user, :scope => :user)
  #       visit user_path(id: user.id)
  #       print page.html
  #       click_link '#downgrade'
  #       page.accept_confirm do
  #         click_link 'Ok'
  #       end
  #       expect(page).to redirect_back
  #       expect(page).to have_content 'Upgrade my account'

  #   end
  #   scenario 'and delete their account' do
  #     click_link 'My Account'
  #     within("#edit") do
  #       click_button 'Cancel my account'
  #       page.accept_confirm do
  #         click_link 'Ok'
  #       end
  #     expect(page).to have_content 'Bye! Your account has been successfully cancelled. We hope to see you again soon.'
  #     end
  #   end
  end
end
