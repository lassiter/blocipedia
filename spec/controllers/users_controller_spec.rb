require 'rails_helper'

RSpec.describe UsersController, type: :controller do

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
end
