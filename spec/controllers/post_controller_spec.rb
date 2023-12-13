require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { User.create(name: 'John Doe', photo: 'https://jhon-doe-picture', bio: 'This is John Doe bio', posts_counter: 0) }
  let(:post) do
    Post.create(author: user, title: 'Post title', text: 'Post content', likes_counter: 0, comments_counter: 0)
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index, params: { user_id: user.id }
      expect(response).to be_successful
    end

    it 'assigns the requested user to @user' do
      get :index, params: { user_id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'assigns the user\'s posts to @posts' do
      get :index, params: { user_id: user.id }
      expect(assigns(:posts)).to eq(user.posts)
    end

    it 'renders the index template' do
      get :index, params: { user_id: user.id }
      expect(response).to render_template('index')
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { user_id: user.id, id: post.id }
      expect(response).to be_successful
    end

    it 'assigns the requested user to @user' do
      get :show, params: { user_id: user.id, id: post.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'assigns the requested post to @post' do
      get :show, params: { user_id: user.id, id: post.id }
      expect(assigns(:post)).to eq(post)
    end

    it 'renders the show template' do
      get :show, params: { user_id: user.id, id: post.id }
      expect(response).to render_template('show')
    end
  end
end
