require 'rails_helper'

RSpec.describe UrlsController, type: :routing do
  describe 'routing' do
    it 'routes to #new' do
      expect(get: '/urls/new').to route_to('urls#new')
    end

    it 'routes to #show' do
      expect(get: '/urls/short').to route_to('urls#show', id: 'short')
    end

    it 'routes to #create' do
      expect(post: '/urls').to route_to('urls#create')
    end

    it 'routes to #goto' do
      expect(get: '/short').to route_to('urls#goto', id: 'short')
    end
  end
end
