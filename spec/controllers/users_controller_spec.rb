require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'GET index' do
    it 'should show all users successfully' do
      request.accept = 'application/json'
      get :index
      response.should have_http_status(:ok)
    end
  end

  context 'GET new' do
    it 'should get new user successfully' do
      request.accept = 'application/json'
      get :new
      assigns(:user).id.should eq nil
      assigns(:user).name.should eq nil
      assigns(:user).address.should eq nil
      assigns(:user).phone.should eq nil
      assigns(:user).payment_mode.should eq nil
      response.should have_http_status(:ok)
    end
  end

  context 'GET show' do
    it 'should show user successfully' do
      request.accept = 'application/json'
      @user = FactoryGirl.create(:user)
      get :show, id: @user.id
      response.should have_http_status(:ok)
    end

    it 'should show user unsuccessfully' do
      request.accept = 'application/json'
      get :show, id: ''
      response.should have_http_status(:not_found)
    end
  end

  context 'POST create' do
    it 'should create user successfully' do
      request.accept = 'application/json'
      @user = FactoryGirl.create(:user)
      post :create, user: { name: @user.name, address: @user.address, phone: @user.phone, payment_mode: @user.payment_mode }
      response.should have_http_status(:ok)
    end

    it 'should create user unsuccessfully' do
      request.accept = 'application/json'
      post :create,  user: { name: '', address: '', phone: '', payment_mode: '' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT update' do
    it 'should update user successfully' do
      request.accept = 'application/json'
      @user = FactoryGirl.create(:user)
      put :update, id: @user.id, user: { name: @user.name, address: @user.address, phone: @user.phone, payment_mode: @user.payment_mode }
      response.should have_http_status(:ok)
    end

    it 'should update user unsuccessfully' do
      request.accept = 'application/json'
      @user = FactoryGirl.create(:user)
      put :update, id: @user.id, user: { name: '', address: '', phone: '', payment_mode: '', showtime: '' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do
    it 'should delete user successfully' do
      request.accept = 'application/json'
      @user = FactoryGirl.create(:user)
      delete :destroy, id: @user.id
      response.should have_http_status(:ok)
    end

    it 'should delete user unsuccessfully' do
      request.accept = 'application/json'
      delete :destroy, id: ''
      response.should have_http_status(:not_found)
    end
  end
end
