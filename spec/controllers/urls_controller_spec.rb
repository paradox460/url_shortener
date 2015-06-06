require 'rails_helper'
RSpec.describe UrlsController, type: :controller do
  let(:valid_attributes) { { url: Faker::Internet.url } }

  let(:invalid_attributes) { { url: 'this is not a url' } }

  let(:valid_session) { {} }

  describe 'GET #show' do
    it 'assigns the requested url as @url' do
      url = Url.create! valid_attributes
      get :show, { id: url.to_param }, valid_session
      expect(assigns(:url)).to eq(url)
    end
  end

  describe 'GET #new' do
    it 'assigns a new url as @url' do
      get :new, {}, valid_session
      expect(assigns(:url)).to be_a_new(Url)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Url' do
        expect { post :create, { url: valid_attributes }, valid_session }.to change(Url, :count).by(1)
      end

      it 'assigns a newly created url as @url' do
        post :create, { url: valid_attributes }, valid_session
        expect(assigns(:url)).to be_a(Url)
        expect(assigns(:url)).to be_persisted
      end

      it 'redirects to the created url' do
        post :create, { url:  valid_attributes }, valid_session
        expect(response).to redirect_to(Url.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved url as @url' do
        post :create, { url: invalid_attributes }, valid_session
        expect(assigns(:url)).to be_a_new(Url)
      end

      it "re-renders the 'new' template" do
        post :create, { url: invalid_attributes }, valid_session
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET #goto' do
    context 'with valid params' do
      it 'assigns the requested url as @url' do
        url = Url.create! valid_attributes
        get :goto, { id: url.to_param }, valid_session
        expect(assigns(:url)).to eq(url)
      end

      it 'redirects to the long url' do
        url = Url.create! valid_attributes
        get :goto, { id: url.to_param }, valid_session
        expect(response).to redirect_to(url.url)
      end
    end

    context 'with invalid params' do
      it 'returns an error' do
        expect { get :goto, { id: 'not a url' }, valid_session }.to raise_error(ActiveRecord::RecordNotFound)

      end
    end
  end
end
