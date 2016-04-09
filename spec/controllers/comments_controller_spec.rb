require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  describe "CREATE new comment" do

    before do
      user = FactoryGirl.create(:user)
      user.confirm
      sign_in user
      @post = create(:post, user: user)
    end

    context 'when new comment is valid' do
      it 'creates the comment' do
        expect {
          post :create, comment: FactoryGirl.attributes_for(:comment), post_id: @post
        }.to change(Comment, :count).by(1)

      end

      it 'redirects to posts index page' do
        post :create, comment: FactoryGirl.attributes_for(:comment), post_id: @post
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "DELETE comment" do
    before do
      user = FactoryGirl.create(:user)
      user.confirm
      sign_in user
      @post = create(:post, user: user)
      @comment = create(:comment, user: user)
    end

    it 'deletes the comment belonging to user' do
      expect {
        delete :destroy, id: @comment, post_id: @post
      }.to change(Comment,:count).by(-1)
    end
  end
end
