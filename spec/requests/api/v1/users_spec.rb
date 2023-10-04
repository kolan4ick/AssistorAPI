require 'swagger_helper'

require 'swagger_helper'

RSpec.describe 'Users', type: :request do

  path '/api/v1/users/tokens/sign_in' do
    post('User sign in') do
      tags 'Users'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
        },
        required: %w[login password]
      }

      consumes 'application/json'
      produces 'application/json'

      # return the user's token
      response '201', 'User signed in successfully' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 surname: { type: :string },
                 username: { type: :string },
                 email: { type: :string },
                 token: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[id type attributes]
        run_test!
      end
    end
  end

  path '/api/v1/users/tokens/sign_up' do
    post('User sign up') do
      tags 'Users'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          surname: { type: :string },
          username: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string },
        },
        required: %w[name surname username email password password_confirmation]
      }

      consumes 'application/json'
      produces 'application/json'

      # return the user's token
      response '201', 'User signed up successfully' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 surname: { type: :string },
                 username: { type: :string },
                 email: { type: :string },
                 token: { type: :string },
                 created_at: { type: :string },
                 updated_at: { type: :string }
               },
               required: %w[id type attributes]
        run_test!
      end
    end
  end
end
