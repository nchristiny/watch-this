require 'rails_helper'

describe 'routes for Recommendations' do
  it 'routes GET /api/recommendations to recommendations#index' do
    expect({get: '/api/recommendations'}).to route_to(controller: 'api/v1/recommendations', action: 'index', format: :json)
  end

  it 'routes GET /api/recommendations/:id to recommendations#show' do
    expect({get: '/api/recommendations/1'}).to route_to(controller: 'api/v1/recommendations', action: 'show', id: '1', format: :json)
  end

  it 'routes POST /api/recommendations/:id to recommendations#create' do
    expect(post: "/api/recommendations").to route_to(controller: 'api/v1/recommendations', action: 'create', format: :json)
  end

  it 'does not route PUT /api/recommendations/:id to recommendations#update' do
    expect(put: "/api/recommendations/1").not_to be_routable
  end

  it 'routes DELETE /api/recommendations/:id to recommendations#destroy' do
    expect(delete: "/api/recommendations/1").to route_to(controller: 'api/v1/recommendations', action: 'destroy', id: '1', format: :json)
  end
end
