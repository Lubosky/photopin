require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe 'GET #index' do
    context 'when user is logged in' do
      before do
        sign_in_user
        get :index
      end
      it { is_expected.to respond_with :ok }
      it { is_expected.to render_with_layout :application }
      it { is_expected.to render_template :index }
    end

    context 'when user is logged out' do
      before do
        get :index
      end
      it { is_expected.to redirect_to new_user_session_path }
    end
  end

  describe "GET #show" do

    before :each do
      user = FactoryGirl.create(:user)
      user.confirm
      sign_in user
      @post = create(:post, user: user)
      get :show, id: @post
    end

    it { expect(assigns(:post)).to eq(@post) }
    it { is_expected.to render_template :show }
  end

  describe "CREATE new post" do

    before :each do
      sign_in_user
    end

    context 'when new post is invalid' do
      it 'renders the page with error' do
        post :create, post: { image: '', content: 'Always pass on what you have learned.' }
        expect(response).to render_template(:new)
        expect(flash[:alert]).to match(/^Ooops! We are having trouble creating your post. Please check your form./)

      end
    end

    context 'when new post is valid' do
      it 'creates the post' do
        expect {
          post :create, post: FactoryGirl.attributes_for(:post)
        }.to change(Post, :count).by(1)

      end

      it 'redirects to posts index page' do
        post :create, post: FactoryGirl.attributes_for(:post)
        expect(response).to redirect_to '/posts'
        expect(flash[:success]).to match(/^Your post has been successfully created!/)

      end
    end
  end

  describe "UPDATE post" do

    before :each do
      user = FactoryGirl.create(:user)
      user.confirm
      sign_in user
      @post = create(:post, user: user)
    end

    context 'when updated post is invalid' do
      it 'renders the page with error' do
        put :update, id: @post,
          post: attributes_for(:post, caption: 'Awesome Post', image: '')
        @post.reload
        expect(response).to render_template(:edit)
        expect(flash[:alert]).to match(/^Sorry! We are having trouble updating your post./)

      end
    end

    context 'when updated post is valid' do
      it 'updates the post' do
        put :update, id: @post,
          post: attributes_for(:post, caption: 'Awesome Post')
        @post.reload
        expect(@post.caption).to eq('Awesome Post')
      end

      it 'redirects to posts#index' do
        put :update, id: @post,
          post: attributes_for(:post, caption: 'Awesome Post')
        expect(response).to redirect_to '/posts'
        expect(flash[:success]).to match(/^Your post has been successfully updated!/)

      end
    end
  end

  describe "DELETE post" do
    before :each do
      user = FactoryGirl.create(:user)
      user.confirm
      sign_in user
      @post = create(:post, user: user)
    end

    it 'deletes the contact' do
      expect {
        delete :destroy, id: @post
      }.to change(Post,:count).by(-1)

    end

    context 'it redirects to posts#index' do
      it 'updates the post and redirects to posts index page' do
        delete :destroy, id: @post
        expect(response).to redirect_to root_path

      end
    end
  end

end
