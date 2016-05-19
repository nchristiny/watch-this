require 'rails_helper'

describe 'routes for Films' do
  it 'routes GET /api/films to films#index' do
    expect({get: '/api/films'}).to route_to(controller: 'api/v1/films', action: 'index', format: :json)
  end

  it 'routes GET /api/films/:id to films#show' do
    expect({get: '/api/films/1'}).to route_to(controller: 'api/v1/films', action: 'show', id: '1', format: :json)
  end

  it 'does not route POST /api/films/:id to films#create' do
    expect(post: "/api/films").not_to be_routable
  end

  it 'does not route PUT /api/films/:id to films#update' do
    expect(put: "/api/films/1").not_to be_routable
  end

  it 'does not route DELETE /api/films/:id to films#destroy' do
    expect(delete: "/api/films/1").not_to be_routable
  end
end
