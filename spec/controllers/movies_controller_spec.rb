require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
  context 'GET index' do
    it 'should show all movies successfully' do
      request.accept = 'application/json'
      get :index
      response.should have_http_status(:ok)
    end
  end

  context 'GET new'
    it 'should get new movie successfully' do
      request.accept = 'application/json'
      get :new
      assigns(:movie).id.should eq nil
      assigns(:movie).name.should eq nil
      assigns(:movie).rating.should eq nil
      assigns(:movie).duration.should eq nil
      assigns(:movie).language.should eq nil
      assigns(:movie).theater_id.should eq nil
      assigns(:movie).audi_id.should eq nil
      response.should have_http_status(:ok)
    end
  end

  context 'GET show' do
    it 'should show movie successfully' do
      request.accept = 'application/json'
      @movie = FactoryGirl.create(:movie)
      get :show, id: @movie.id
      response.should have_http_status(:ok)
    end

    it 'should show movie unsuccessfully' do
      request.accept = 'application/json'
      get :show, id: ''
      response.should have_http_status(:not_found)
    end
  end

  context 'POST create' do
    it 'should create movie successfully' do
      request.accept = 'application/json'
      movie = FactoryGirl.create(:movie)
      post :create, movie: { theater_id: movie.theater_id, name: movie.name, rating: movie.rating, duration: movie.duration, language: movie.language }
      response.should have_http_status(:ok)
    end

    it 'should create movie unsuccessfully' do
      request.accept = 'application/json'
      post :create,  movie: { theater_id: '', name: '', rating: '', duration: '', language: '' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create movie with invalid Audi' do
      request.accept = 'application/json'
      movie = FactoryGirl.create(:movie)
      post :create, movie: { name: 'ABC', rating: '2', duration: '3', language: 'Hindi', audi_id: '123', theater_id: movie.theater_id }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create movie with invalid Theater' do
      request.accept = 'application/json'
      movie = FactoryGirl.create(:movie)
      post :create, movie: { name: 'ABC', rating: '2', duration: '3', language: 'Hindi', audi_id: movie.audi_id, theater_id: '22' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT update' do
    it 'should update movie successfully' do
      request.accept = 'application/json'
      movie = FactoryGirl.create(:movie)
      put :update, id: movie.id, movie: { theater_id: movie.theater_id, name: movie.name, rating: movie.rating, duration: movie.duration, language: movie.language }
      response.should have_http_status(:ok)
    end

    it 'should update movie unsuccessfully' do
      request.accept = 'application/json'
      movie = FactoryGirl.create(:movie)
      put :update, id: movie.id, movie: { theater_id: '', name: '', rating: '', duration: '', language: '' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update movie with invalid Audi' do
      request.accept = 'application/json'
      movie = FactoryGirl.create(:movie)
      post :update, id: movie.id, movie: { name: 'ABC', rating: '2', duration: '3', language: 'Hindi', audi_id: '123', theater_id: movie.theater_id }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update movie with invalid Theater' do
      request.accept = 'application/json'
      movie = FactoryGirl.create(:movie)
      post :update, id: movie.id, movie: { name: 'ABC', rating: '2', duration: '3', language: 'Hindi', audi_id: movie.audi_id, theater_id: '22' }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do
    it 'should delete movie successfully' do
      request.accept = 'application/json'
      @movie = FactoryGirl.create(:movie)
      delete :destroy, id: @movie.id
      response.should have_http_status(:ok)
    end

    it 'should delete movie unsuccessfully' do
      request.accept = 'application/json'
      delete :destroy, id: ''
      response.should have_http_status(:not_found)
    end
  end
end
