require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe "GET #index" do
    it "assigns @posts" do
      post = create(:post)
      get :index
      assigns(:posts).should eq([post])
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested post to @post" do
      post = create(:post)
      get :show, id: post
      assigns(:post).should eq(post)
    end

    it "renders the #show view" do
      get :show, id: create(:post)
      response.should render_template :show
    end
  end

  describe "CREATE new post" do
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
      @post = create(:post)
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
        @post.caption.should eq('Awesome Post')
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
      @post = create(:post)
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
