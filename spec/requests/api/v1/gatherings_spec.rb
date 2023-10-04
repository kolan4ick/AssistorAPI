require 'swagger_helper'

RSpec.describe 'Gatherings', type: :request do
  path '/api/v1/gatherings/{gathering_id}/create_view' do
    parameter name: 'gathering_id', in: :path, type: :string, description: 'gathering_id'

    post('create_view gathering') do
      security [bearerAuth: []]

      description 'Create a gathering view'

      tags 'Gatherings'
      response(200, 'successful') do
        let(:gathering_id) { '123' }

        after do | example |
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end
  end

  path '/api/v1/gatherings/viewed' do

    get('viewed gathering') do
      security [bearerAuth: []]
      tags 'Gatherings'
      description 'List viewed gatherings of current user'

      response(200, 'successful') do
        let(:auth_token) { 'your_auth_token' } # replace with an actual auth token for testing

        after do | example |
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/gatherings/created_by_volunteer/{volunteer_id}' do
    # You'll want to customize the parameter types...
    parameter name: 'volunteer_id', in: :path, type: :string, description: 'Volunteer id'

    get('created_by_volunteer gathering') do
      security [bearerAuth: []]
      tags 'Gatherings'
      description 'List gatherings created by specific volunteer'

      response(200, 'successful') do
        let(:volunteer_id) { '123' }
        let(:auth_token) { 'your_auth_token' }

        after do | example |
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/gatherings/search' do

    get('search gathering') do
      description 'Search gatherings by query, sort and filter'

      parameter name: :query, in: :query, type: :string, description: 'Search query'
      parameter name: :sort, in: :query, description: 'Sort query', schema: {
        type: :string,
        enum: %w[created_at_asc gathered_sum_asc gathered_sum_desc]
      }
      parameter name: :filter, in: :query, description: 'Filter query', type: :object, style: :deepObject, explode: true, schema: {
        type: :object,
        properties: {
          new: { type: :boolean },
          active: { type: :boolean },
          not_active: { type: :boolean },
          categories: { type: :string }
        }
      }
      security [bearerAuth: []]
      tags 'Gatherings'

      response(200, 'successful') do
        let(:query) { 'query' }
        let(:sort) { 'sort' }
        let(:filter) { 'filter' }

        after do | example |
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/gatherings' do
    get('list gatherings') do
      security [bearerAuth: []]
      tags 'Gatherings'

      response(200, 'successful') do

        after do | example |
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/gatherings/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show gathering') do
      security [bearerAuth: []]
      tags 'Gatherings'

      response(200, 'successful') do
        let(:id) { '123' }

        after do | example |
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    # patch('update gathering') do
    #   tags 'Gatherings'
    #
    #   response(200, 'successful') do
    #     let(:id) { '123' }
    #     let(:auth_token) { 'your_auth_token' }
    #
    #     after do | example |
    #       example.metadata[:response][:content] = {
    #         'application/json' => {
    #           example: JSON.parse(response.body, symbolize_names: true)
    #         }
    #       }
    #     end
    #     run_test!
    #   end
    # end

    # put('update gathering') do
    #   tags 'Gatherings'
    #
    #   response(200, 'successful') do
    #     let(:id) { '123' }
    #     let(:auth_token) { 'your_auth_token' }
    #
    #     after do | example |
    #       example.metadata[:response][:content] = {
    #         'application/json' => {
    #           example: JSON.parse(response.body, symbolize_names: true)
    #         }
    #       }
    #     end
    #     run_test!
    #   end
    # end

    # delete('delete gathering') do
    #   tags 'Gatherings'
    #
    #   response(200, 'successful') do
    #     let(:id) { '123' }
    #     let(:auth_token) { 'your_auth_token' }
    #
    #     after do | example |
    #       example.metadata[:response][:content] = {
    #         'application/json' => {
    #           example: JSON.parse(response.body, symbolize_names: true)
    #         }
    #       }
    #     end
    #     run_test!
    #   end
    # end
  end
end