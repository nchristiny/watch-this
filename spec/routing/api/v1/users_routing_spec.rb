require 'rails_helper'

describe 'routes for Users' do
  it 'routes GET /api/users to users#index' do
    expect({get: '/api/users'}).to route_to(controller: 'api/v1/users', action: 'index', format: :json)
  end

  it 'routes GET /api/users/:id to users#show' do
    expect({get: '/api/users/1'}).to route_to(controller: 'api/v1/users', action: 'show', id: '1', format: :json)
  end

  it 'routes POST /api/users to users#create' do
    expect(post: '/api/users').to route_to(controller: 'api/v1/users', action: 'create', format: :json)
  end

  it 'routes PUT /api/users/:id to users#update' do
    expect(put: '/api/users/1').to route_to(controller: 'api/v1/users', action: 'update', id: '1', format: :json)
  end

  it 'routes DELETE /api/users/:id to users#destroy' do
    expect(delete: '/api/users/1').to route_to(controller: 'api/v1/users', action: 'destroy', id: '1', format: :json)
  end
end
