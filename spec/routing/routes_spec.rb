require 'rails_helper'

RSpec.describe 'routing', :type => :routing do

  describe 'backoffice questions routing' do
    context 'route is provided' do
      it 'should route /backoffice/questions to questions#index' do
        expect(get: '/backoffice/questions').to route_to(
          controller: 'backoffice/questions',
          action: 'index'
        )
      end

      it 'should route /backoffice/questions/new to questions#new' do
        expect(get: '/backoffice/questions/new').to route_to(
          controller: 'backoffice/questions',
          action: 'new'
          )
      end

      it 'should route /backoffice/questions to questions#create' do
        expect(post: '/backoffice/questions').to route_to(
          controller: 'backoffice/questions',
          action: 'create'
          )
      end

      it 'should route /backoffice/questions/1/edit to questions#edit' do
        expect(get: '/backoffice/questions/1/edit').to route_to(
          controller: 'backoffice/questions',
          action: 'edit',
          id: '1'
          )
      end

      it 'should route /backoffice/questions/1 to questions#update' do
        expect(put: '/backoffice/questions/1').to route_to(
          controller: 'backoffice/questions',
          action: 'update',
          id: '1'
          )
      end

      it 'should route /backoffice/questions/1 to questions#destroy' do
        expect(delete: '/backoffice/questions/1').to route_to(
          controller: 'backoffice/questions',
          action: 'destroy',
          id: '1'
          )
      end
    end

    context 'route is not provided' do
      it 'should not route to /backoffice/questions/1' do
        expect(get: 'backoffice/questions/1').not_to be_routable
      end

      it 'should not route to /backoffice/questions/1' do
        expect(patch: 'backoffice/questions/1').not_to be_routable
      end
    end
  end

end