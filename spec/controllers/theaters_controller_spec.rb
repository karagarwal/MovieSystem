require 'rails_helper'

RSpec.describe TheatersController, type: :controller do
  context 'GET index' do
    it 'should show all theater' do
      request.accept = 'application/json'
      get :index
      response.should have_http_status(:ok)
    end
  end

  context 'GET new' do
    it 'should get new theater successfully' do
      request.accept = 'application/json'
      get :new
      assigns(:theater).id.should eq nil
      assigns(:theater).theater_name.should eq nil
      assigns(:theater).address.should eq nil
      assigns(:theater).phone.should eq nil
      response.should have_http_status(:ok)
    end
  end

  context 'GET show' do
    it 'should show theater successfully' do
      request.accept = 'application/json'
      @theater = FactoryGirl.create(:theater)
      get :show, id: @theater.id
      response.should have_http_status(:ok)
    end

    it 'should show action unsuccessfully' do
      request.accept = 'application/json'
      get :show, id: ''
      response.should have_http_status(:not_found)
    end
  end

  context 'POST create' do
    it 'should create theater successfully' do
      request.accept = 'application/json'
      @theater = FactoryGirl.create(:theater)
      post :create, theater: { theater_name: @theater.theater_name, address: @theater.address, phone: @theater.phone }
      response.should have_http_status(:ok)
    end

    it 'should create theater unsuccessfully' do
      request.accept = 'application/json'
      post :create, theater: { theater_name: '', address: '', phone: '' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT update' do
    it 'should update theater successfully' do
      request.accept = 'application/json'
      @theater = FactoryGirl.create(:theater)
      put :update, id: @theater.id, theater: { theater_name: @theater.theater_name, address: @theater.address, phone: @theater.phone }
      response.should have_http_status(:ok)
    end

    it 'should update theater unsuccessfully' do
      request.accept = 'application/json'
      @theater = FactoryGirl.create(:theater)
      put :update, id: @theater.id, theater: { theater_name: '', address: '', phone: '' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do
    it 'should delete theater successfully' do
      request.accept = 'application/json'
      @theater = FactoryGirl.create(:theater)
      delete :destroy, id: @theater.id
      response.should have_http_status(:ok)
    end

    it 'should delete theater unsuccessfully' do
      request.accept = 'application/json'
      delete :destroy, id: ''
      response.should have_http_status(:not_found)
    end
  end
end
