require 'rails_helper'

RSpec.describe SeatTypesController, type: :controller do
  context 'GET index' do
    it 'should show all seat_type successfully' do
      request.accept = 'application/json'
      get :index
      response.should have_http_status(:ok)
    end
  end

  context 'GET new' do
    it 'should get new seat_type successfully' do
      request.accept = 'application/json'
      get :new
      assigns(:seat_type).id.should eq nil
      assigns(:seat_type).category.should eq nil
      assigns(:seat_type).audi_id.should eq nil
      response.should have_http_status(:ok)
    end
  end

  context 'GET show' do
    it 'should show seat_type successfully' do
      request.accept = 'application/json'
      @seat_type = FactoryGirl.create(:seat_type)
      get :show, id: @seat_type.id
      response.should have_http_status(:ok)
    end

    it 'should show seat_type unsuccessfully' do
      request.accept = 'application/json'
      get :show, id: ''
      response.should have_http_status(:not_found)
    end
  end

  context 'POST update' do
    it 'should create seat_type successfully' do
      request.accept = 'application/json'
      @seat_type = FactoryGirl.create(:seat_type)
      post :create, seat_type: { audi_id: @seat_type.audi_id, category: @seat_type.category }
      response.should have_http_status(:ok)
    end

    it 'should create seat_type unsuccessfully' do
      request.accept = 'application/json'
      post :create, seat_type: { audi_id: '', category: '' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create seat_type with invalid Audi' do
      request.accept = 'application/json'
      post :create, seat_type: { category: 'Silver', audi_id: '1234567' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT update' do
    it 'should update seat_type successfully' do
      request.accept = 'application/json'
      @seat_type = FactoryGirl.create(:seat_type)
      put :update, id: @seat_type.id, seat_type: { audi_id: @seat_type.audi_id, category: @seat_type.category }
      response.should have_http_status(:ok)
    end

    it 'should update seat_type unsuccessfully' do
      request.accept = 'application/json'
      @seat_type = FactoryGirl.create(:seat_type)
      put :update, id: @seat_type.id, seat_type: { audi_id: '', category: '' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update seat_type with invalid Audi' do
      request.accept = 'application/json'
      seat_type = FactoryGirl.create(:seat_type)
      post :update, id: seat_type.id, seat_type: { audi_id: '1234567', category: 'Silver' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do
    it 'should delete seat_type successfully' do
      request.accept = 'application/json'
      @seat_type = FactoryGirl.create(:seat_type)
      delete :destroy, id: @seat_type.id
      response.should have_http_status(:ok)
    end

    it 'should delete seat_type unsuccessfully' do
      request.accept = 'application/json'
      delete :destroy, id: ''
      response.should have_http_status(:not_found)
    end
  end
end
