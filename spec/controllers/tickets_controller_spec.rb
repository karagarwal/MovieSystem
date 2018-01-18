require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  context 'GET index' do
    it 'should show ticket successfully' do
      request.accept = 'application/json'
      get :index
      response.should have_http_status(:ok)
    end
  end

  context 'GET new' do
    it 'should get new ticket successfully' do
      request.accept = 'application/json'
      get :new
      assigns(:ticket).id.should eq nil
      assigns(:ticket).seat_number.should eq nil
      assigns(:ticket).showtime_id.should eq nil
      assigns(:ticket).audi_id.should eq nil
      assigns(:ticket).movie_id.should eq nil
      assigns(:ticket).seat_type_id.should eq nil
      assigns(:ticket).user_id.should eq nil
      response.should have_http_status(:ok)
    end
  end

  context 'GET show' do
    it 'should show ticket successfully' do
      request.accept = 'application/json'
      ticket = FactoryGirl.create(:ticket)
      get :show, id: ticket.id
      response.should have_http_status(:ok)
    end

    it 'should show action unsuccessfully' do
      request.accept = 'application/json'
      get :show, id: ''
      response.should have_http_status(:not_found)
    end
  end

  context 'POST create' do
    it 'should create ticket successfully' do
      request.accept = 'application/json'
      ticket = FactoryGirl.create(:ticket)
      post :create, ticket: { showtime_id: ticket.showtime_id, movie_id: ticket.movie_id, user_id: ticket.user_id, audi_id: ticket.audi_id, seat_type_id: ticket.seat_type_id, seat_number: ticket.seat_number, price: ticket.price }
      response.should have_http_status(:ok)
    end

    it 'should create ticket unsuccessfully' do
      request.accept = 'application/json'
      post :create,  ticket: { showtime_id: '', movie_id: '', user_id: '', audi_id: '', seat_type_id: '', seat_number: '', price: '' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create ticket with invalid movie' do
      request.accept = 'application/json'
      ticket = FactoryGirl.create(:ticket)
      post :create, ticket: { seat_number: '12', price: '120', showtime_id: ticket.showtime_id, audi_id: ticket.audi_id, movie_id: '12', seat_type_id: ticket.seat_type_id, user_id: ticket.user_id }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create ticket with invalid showtime' do
      request.accept = 'application/json'
      ticket = FactoryGirl.create(:ticket)
      post :create, ticket: { seat_number: '12', price: '120', showtime_id: '11', audi_id: ticket.audi_id, movie_id: ticket.movie_id, seat_type_id: ticket.seat_type_id, user_id: ticket.user_id }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create ticket with invalid audi' do
      request.accept = 'application/json'
      ticket = FactoryGirl.create(:ticket)
      post :create, ticket: { seat_number: '12', price: '120', showtime_id: ticket.showtime_id, audi_id: '11', movie_id: ticket.movie_id, seat_type_id: ticket.seat_type_id, user_id: ticket.user_id }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create ticket with invalid user' do
      request.accept = 'application/json'
      ticket = FactoryGirl.create(:ticket)
      post :create, ticket: { seat_number: '12', price: '120', showtime_id: ticket.showtime_id, audi_id: ticket.audi_id, movie_id: ticket.movie_id, seat_type_id: ticket.seat_type_id, user_id: '11' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not create ticket with invalid seat_type' do
      request.accept = 'application/json'
      ticket = FactoryGirl.create(:ticket)
      post :create, ticket: { seat_number: '12', price: '120', showtime_id: ticket.showtime_id, audi_id: ticket.audi_id, movie_id: ticket.movie_id, seat_type_id: '22', user_id: ticket.user_id }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'PUT update' do
    it 'should update ticket successfully' do
      request.accept = 'application/json'
      ticket = FactoryGirl.create(:ticket)
      put :update, id: ticket.id, ticket: { showtime_id: ticket.showtime_id, movie_id: ticket.movie_id, user_id: ticket.user_id, audi_id: ticket.audi_id, seat_type_id: ticket.seat_type_id, seat_number: ticket.seat_number, price: ticket.price }
      response.should have_http_status(:ok)
    end

    it 'should update ticket unsuccessfully' do
      request.accept = 'application/json'
      ticket = FactoryGirl.create(:ticket)
      put :update, id: ticket.id, ticket: { showtime_id: '', movie_id: '', user_id: '', audi_id: '', seat_type_id: '', seat_number: '', price: '' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update ticket with invalid Audi' do
      request.accept = 'application/json'
      ticket = FactoryGirl.create(:ticket)
      post :update, id: ticket.id, ticket: { seat_number: '12', price: '120', showtime_id: ticket.showtime_id, audi_id: '11', movie_id: ticket.movie_id, seat_type_id: ticket.seat_type_id, user_id: ticket.user_id }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update ticket with invalid Movie' do
      request.accept = 'application/json'
      ticket = FactoryGirl.create(:ticket)
      post :update, id: ticket.id, ticket: { seat_number: '12', price: '120', showtime_id: ticket.showtime_id, audi_id: ticket.movie_id, movie_id: '111', seat_type_id: ticket.seat_type_id, user_id: ticket.user_id }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update ticket with invalid User' do
      request.accept = 'application/json'
      ticket = FactoryGirl.create(:ticket)
      post :update, id: ticket.id, ticket: { seat_number: '12', price: '120', showtime_id: ticket.showtime_id, audi_id: ticket.movie_id, movie_id: ticket.movie_id, seat_type_id: ticket.seat_type_id, user_id: '222' }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update ticket with invalid SeatType' do
      request.accept = 'application/json'
      ticket = FactoryGirl.create(:ticket)
      post :update, id: ticket.id, ticket: { seat_number: '12', price: '120', showtime_id: ticket.showtime_id, audi_id: ticket.movie_id, movie_id: ticket.movie_id, seat_type_id: '', user_id: ticket.user_id }
      response.should have_http_status(:unprocessable_entity)
    end

    it 'should not update ticket with invalid ShowTime' do
      request.accept = 'application/json'
      ticket = FactoryGirl.create(:ticket)
      post :update, id: ticket.id, ticket: { seat_number: '12', price: '120', showtime_id: '22', audi_id: ticket.movie_id, movie_id: ticket.movie_id, seat_type_id: ticket.seat_type_id, user_id: ticket.user_id }
      response.should have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do
    it 'should delete action successfully' do
      request.accept = 'application/json'
      ticket = FactoryGirl.create(:ticket)
      delete :destroy, id: ticket.id
      response.should have_http_status(:ok)
    end

    it 'should delete action unsuccessfully' do
      request.accept = 'application/json'
      delete :destroy, id: ''
      response.should have_http_status(:not_found)
    end
  end
end
