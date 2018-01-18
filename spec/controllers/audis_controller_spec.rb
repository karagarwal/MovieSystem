require 'rails_helper'

RSpec.describe AudisController, type: :controller do
  context 'GET index' do
    it 'should show all Audis successfully' do
      request.accept = 'application/json'
      get :index
      response.should have_http_status(:ok)
    end
  end

  context 'GET new'
    it 'should get new audi successfully' do
      request.accept = 'application/json'
      get :new
      assigns(:audi).id.should eq nil
      assigns(:audi).theater_id.should eq nil
      assigns(:audi).code.should eq nil
      assigns(:audi).number_of_seats.should eq nil
      response.should have_http_status(:ok)
    end
  end

  context 'GET show' do
    it 'should show audi successfully' do
      request.accept = 'application/json'
      @audi = FactoryGirl.create(:audi)
      get :show, id: @audi.id
      response.should have_http_status(:ok)
    end

    it 'should show audi unsuccessfully' do
      request.accept = 'application/json'
      get :show, id: ''
      response.should have_http_status(:not_found)
    end
  end

  context 'POST create' do
    it 'should create audi successfully' do
      request.accept = 'application/json'
      @audi = FactoryGirl.create(:audi)
      post :create, audi: { theater_id: @audi.theater_id, code: @audi.code, number_of_seats: @audi.number_of_seats }
      response.should have_http_status(:ok)
    end

    it 'should create audi unsuccessfully' do
      request.accept = 'application/json'
      post :create, audi: { theater_id: '', code: '', number_of_seats: '' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create audi with invalid theater' do
      request.accept = 'application/json'
      post :create, audi: { code: '4', number_of_seats: '90', theater_id: '1234567' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT update' do
    it 'should update audi successfully' do
      request.accept = 'application/json'
      @audi = FactoryGirl.create(:audi)
      put :update, id: @audi.id, audi: { theater_id: @audi.theater_id, code: @audi.code, number_of_seats: @audi.number_of_seats }
      response.should have_http_status(:ok)
    end

    it 'should update audi unsuccessfully' do
      request.accept = 'application/json'
      @audi = FactoryGirl.create(:audi)
      put :update, id: @audi.id, audi: { theater_id: '', code: '', number_of_seats: '' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update audi with invalid theater' do
      request.accept = 'application/json'
      audi1 = FactoryGirl.create(:audi)
      audi2 = FactoryGirl.create(:audi)
      post :update, id: audi1.id, audi: { theater_id: '1234567', code: '3', number_of_seats: '90' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do
    it 'should delete audi successfully' do
      request.accept = 'application/json'
      @audi = FactoryGirl.create(:audi)
      delete :destroy, id: @audi.id
      response.should have_http_status(:ok)
    end

    it 'should delete audi unsuccessfully' do
      request.accept = 'application/json'
      delete :destroy, id: ''
      response.should have_http_status(:not_found)
    end
  end
end
