require 'rails_helper'

RSpec.describe ShowtimesController, type: :controller do
  context 'GET index' do
    it 'should show showtime successfully' do
      request.accept = 'application/json'
      get :index
      response.should have_http_status(:ok)
    end
  end

  context 'GET new' do
    it 'should get new showtime successfully' do
      request.accept = 'application/json'
      get :new
      assigns(:showtime).id.should eq nil
      assigns(:showtime).timing.should eq nil
      assigns(:showtime).movie_id.should eq nil
      response.should have_http_status(:ok)
    end
  end

  context 'GET show' do
    it 'should show showtime successfully' do
      request.accept = 'application/json'
      @showtime = FactoryGirl.create(:showtime)
      get :show,  id: @showtime.id
      response.should have_http_status(:ok)
    end

    it 'should show showtime unsuccessfully' do
      request.accept = 'application/json'
      get :show, id: ''
      response.should have_http_status(:not_found)
    end
  end

  context 'POST create' do
    it 'should create showtime successfully' do
      request.accept = 'application/json'
      @showtime = FactoryGirl.create(:showtime)
      post :create, showtime: { movie_id: @showtime.movie_id, timing: @showtime.timing }
      response.should have_http_status(:ok)
    end

    it 'should create showtime unsuccessfully' do
      request.accept = 'application/json'
      post :create,  showtime: { movie_id: '', timing: '' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create showtime with invalid movie' do
      request.accept = 'application/json'
      showtime = FactoryGirl.create(:showtime)
      post :create, showtime: { timing: showtime.timing, movie_id: '90' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT update' do
    it 'should update showtime successfully' do
      request.accept = 'application/json'
      showtime = FactoryGirl.create(:showtime)
      put :update, id: showtime.id, showtime: { movie_id: showtime.movie_id, timing: showtime.timing }
      response.should have_http_status(:ok)
    end

    it 'should update showtime unsuccessfully' do
      request.accept = 'application/json'
      showtime = FactoryGirl.create(:showtime)
      put :update, id: showtime.id, showtime: { movie_id: '', timing: '' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update showtime with invalid movie' do
      request.accept = 'application/json'
      showtime1 = FactoryGirl.create(:showtime)
      showtime2 = FactoryGirl.create(:showtime)
      post :update, id: showtime1.id, showtime: { movie_id: '1267', time: showtime1.timing }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do
    it 'should delete action successfully' do
      request.accept = 'application/json'
      @showtime = FactoryGirl.create(:showtime)
      delete :destroy, id: @showtime.id
      response.should have_http_status(:ok)
    end

    it 'should delete action unsuccessfully' do
      request.accept = 'application/json'
      delete :destroy, id: ''
      response.should have_http_status(:not_found)
    end
  end
end
