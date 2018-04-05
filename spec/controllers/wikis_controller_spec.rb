require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:wiki) { create(:wiki) }
  let(:wikis) { Wiki.all }
  let(:user) {wiki.user}
  let(:editing_user) {create(:user, role: :member)}
  let(:admin_user) {create(:user, role: :admin)}

  describe 'GET index' do
    context 'when the is a user is a guest role' do
      it 'returns http sucess' do
        get :index
        expect(response).to have_http_status(:success)
      end
      it 'returns all Wikis' do
        get :index
        expect(assigns(:wikis)).to eq([wiki])
      end
    end
    context 'when the is a user is a member role' do
      before do
        sign_in user
      end
      it 'returns http sucess' do
        get :index
        expect(response).to have_http_status(:success)
      end
      it 'returns all Wikis' do
        get :index
        expect(assigns(:wikis)).to eq([wiki])
      end
    end
  end
  describe 'POST create' do
    context 'when the is a user is a guest role' do
      it 'redirects guest user to signin' do
        post :create, params: { id: wiki.id }
        expect(flash[:alert]).to match("You need to sign in or sign up before continuing.")
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context 'when the is a user is a member role' do
      before do
        sign_in user
      end
      it 'returns the created post' do
        post :create, params: { wiki: { title: wiki.title, body: wiki.body, private: false } }
        expect(response).to redirect_to(wiki_path(Wiki.last))
      end
    end
  end
  describe 'GET edit' do
    context 'when the is a user is a guest role' do
      it 'redirects guest user to signin' do
        get :edit, params: { id: wiki.id }
        expect(flash[:alert]).to match("You need to sign in or sign up before continuing.")
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context 'when the is a user is a member role' do
      before do
        sign_in user
      end
      it 'updates wiki and redirects to wiki#edit' do
        get :edit, params: { id: wiki.id }  
        post_instance = assigns(:wiki)

        expect(post_instance.id).to eq(wiki.id)
        expect(post_instance.title).to eq(wiki.title)
        expect(post_instance.body).to eq(wiki.body)
      end
      # it 'should allow another user to edit another user\'s public post' do
      #   create(:wiki, user: user)
      #   get :edit, params: { id: wiki.id }
      #   sign_in editing_user
      #   expect {click_button 'Save'}.to change_multiple { editing_user.reload }.with_expectations(
      #     name:       {from: wiki.title, to: 'example post'},
      #     updated_at: {from: wiki.body, to: 'example body text that must be atleast 100 characters long example body text that must be atleast 100 characters long'})
      # end
    end
  end
  describe 'GET show' do
    context 'when the is a user is a guest role' do
      it "returns http success" do
        get :show, params: { id: wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { id: wiki.id }
        expect(response).to render_template(:show)
      end

      it "assigns wiki to @wiki" do
        get :show, params: { id: wiki.id }
        expect(assigns(:wiki)).to eq(wiki)
      end
    end
    context 'when the is a user is a member role' do
      before do
        sign_in user
      end
      it "returns http success" do
        get :show, params: { id: wiki.id }
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, params: { id: wiki.id }
        expect(response).to render_template(:show)
      end

      it "assigns wiki to @wiki" do
        get :show, params: { id: wiki.id }
        expect(assigns(:wiki)).to eq(wiki)
      end
    end
  end
  # describe 'PATCH update' do
  #   context 'when there is a summary' do
  #     it 'returns the summary' do
  #       # ...
  #     end
  #   end
  # end
  describe 'PUT update' do
    context 'when the is a user is a guest role' do
      it 'redirects guest user to signin' do
        put :update, params: { id: wiki.id }
        expect(flash[:alert]).to match("You need to sign in or sign up before continuing.")
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context 'when the is a user is a member role' do
      before do
        sign_in user
      end
      it 'updates wiki and redirects to wiki#show' do
        put :update, params: { id: wiki.id, wiki: { title: wiki.title, body: wiki.body, private: false } }
        expect(response).to redirect_to(wiki_path)
      end
    end
  end
  describe 'DELETE destroy' do
    context 'when the is a user is a guest role' do
      it 'redirects guest user to signin' do
        delete :destroy, params: { id: wiki.id }
        expect(flash[:alert]).to match("You need to sign in or sign up before continuing.")
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    context 'when the is a user is a member role' do
      before do
        sign_in user
      end
      it 'deletes wiki and redirects to wiki#index' do
        delete :destroy, params: { id: wiki.id }
        expect(response).to redirect_to(wikis_path)
      end
    end
  end

end
