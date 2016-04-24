require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:post_object) { FactoryGirl.create(:post) }
  describe '#new' do
    before { get :new }
    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
    it 'assigns a post object' do
      # byebug
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe '#create' do
    context 'with valid attributes' do
      def valid_post
        post :create, post: { title: 'valid title', body: 'valid body' }
      end
      it 'saves a post to the database' do
        expect { valid_post }.to change { Post.count }.by(1)
      end
      it 'redirects to the post show page' do
        valid_post
        expect(response).to redirect_to(post_path(Post.last))
      end
      it 'sets a flash message' do
        valid_post
        expect(flash[:notice]).to be
      end
    end
    context 'without valid attributes' do
      def invalid_post
        post :create, post: { title: 'abc' }
      end
      it 'renders the new template' do
        invalid_post
        expect(response).to render_template(:new)
      end
      it 'sets an alert notice' do
        invalid_post
        expect(flash[:alert]).to be
      end
      it 'does not save a product to the database' do
        expect { invalid_post }.to change { Post.count }.by(0)
      end
    end
  end

  describe '#show' do
    before do
      get :show, id: post_object.id
    end
    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
    it 'sets a post instance variable' do
      expect(assigns(:post)).to eq(post_object)
    end
  end

  describe '#index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
    it 'assigns an instance variable to all posts in the DB' do
      p1 = FactoryGirl.create(:post)
      p2 = FactoryGirl.create(:post)

      get :index

      expect(assigns(:posts)).to eq([p1, p2])
    end
  end

  describe '#edit' do
    before do
      get :edit, id: post_object.id
    end
    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end
    it 'sets an instance variable with the passed id' do
      expect(assigns(:post)).to eq(post_object)
    end
  end

  describe '#update' do
    context 'with valid attributes' do
      let(:valid_body) { Faker::Hipster.paragraph }
      before do
        patch :update, id: post_object.id, post: { body: valid_body }
      end
      it 'updates the record whose id is passed' do
        expect(post_object.reload.body).to eq(valid_body)
      end
      it 'redirects to the show page' do
        expect(response).to redirect_to(post_path(post_object))
      end
      it 'sets a flash notice message' do
        expect(flash[:notice]).to be
      end
    end
    context 'without valid attributes' do
      before do
        patch :update, id: post_object.id, post: { title: '' }
      end
      it 'does not update the record whose id is passed' do
        expect(post_object.title).to eq(post_object.reload.title)
      end
      it 'renders the edit template' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe '#destroy' do
    def delete_post
      delete :destroy, id: post_object.id
    end
    it 'removes the post from the database' do
      post_object
      expect { delete_post }.to change { Post.count }.by(-1)
    end
    it 'redirects to the index' do
      delete_post
      expect(response).to redirect_to(posts_path)
    end
    it 'sets a flash message' do
      delete_post
      expect(flash[:notice]).to be
    end
  end
end
