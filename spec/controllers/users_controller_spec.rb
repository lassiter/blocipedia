require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:fake_stripe_card) {card_num: "4242424242424242", card_exp: "11/23", cvc: "111" }
  context 'Rendering for Users' do
    describe 'GET index' do
    let(:user) { FactoryBot.create(:user) }
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
    before :each do
      User.make(email: 'user@example.com', password: 'password')
    end
    it "and can sign in" do #fix
      visit '/sessions/new'
      within("#session") do
        fill_in 'Email', with: 'user@example.com'
        fill_in 'Password', with: 'password'
      end
      click_button 'Sign in'
      expect(page).to have_content 'Success'
    end

    scenario 'and allows them to upgrade their account' do
      within("#show") do
        click_button 'Pay with Card'
        it "can add a payment method", js: true do
          find_field('email').send_keys(current_user.email)
          find_field('cardnumber').send_keys(fake_stripe_card.card_num)
          find_field('exp-date').send_keys(fake_stripe_card.card_exp)
          find_field('cvc').send_keys(fake_stripe_card.cvc)
          click_button "Section-button"
        end
        expect(page).to redirect_to new_charge_path
      end
    end
    scenario 'and allows them to downgrade their account' do
      within("#show") do
        click_button 'Downgrade'
        page.accept_confirm do
          click_link 'Ok'
        end
        expect(page).to redirect_back
        expect(page).to have_content 'Upgrade my account'
      end
    end
    scenario 'and delete their account' do
      click_link 'My Account'
      within("#edit") do
        click_button 'Cancel my account'
        page.accept_confirm do
          click_link 'Ok'
        end
      expect(page).to have_content 'Bye! Your account has been successfully cancelled. We hope to see you again soon.'
      end
    end
    
  end
end
