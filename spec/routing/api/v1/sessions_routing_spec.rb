require 'rails_helper'

describe 'routes for Sessions' do

  it 'routes POST /api/login to sessions#create' do
    expect({post: '/api/login'}).to route_to(controller: 'api/v1/sessions', action: 'create', format: :json)
  end

  it 'routes DELETE /api/logout to sessions#destroy' do
    expect({delete: '/api/logout'}).to route_to(controller: 'api/v1/sessions', action: 'destroy', format: :json)
  end
end
