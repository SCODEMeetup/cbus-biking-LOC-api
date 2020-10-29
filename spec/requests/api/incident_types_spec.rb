# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/incident_types', type: :request do
  let!(:incident_type) { create(:incident_type) }

  let!(:incident_type_other) { create(:incident_type) }
  let!(:incident_severity) { create(:incident_severity) }
  let!(:report) do
    create(:report, incident_type_id: incident_type_other.id,
    incident_severity_id: incident_severity.id)
  end

  path '/api/incident_types' do
    post('create incident_type') do
      tags 'Incident Types'
      consumes 'application/json'
      parameter name: :incident_type, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string }
        },
        required: ['description']
      }

      response(201, 'incident type created') do
        let(:incident_type) { { description: 'rock slide' } }

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:incident_type) { { description: '' } }

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end

      response(400, 'bad request') do
        let(:incident_type) { {} }

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end
    end

    get('list incident types') do
      tags 'Incident Types'
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end
    end
  end

  path '/api/incident_types/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show incident type') do
      tags 'Incident Types'
      response(200, 'successful') do
        let(:incident_type) { create(:incident_type) }
        let(:id) { incident_type.id }

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end

      response(404, 'not found') do
        let(:id) { '-404' }

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end
    end

    delete('delete incident type') do
      tags 'Incident Types'
      response(204, 'no content') do
        let(:id) { incident_type.id }

        run_test!
      end

      response(404, 'not found') do
        let(:id) { '-404' }

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end

      response(409, 'conflict') do
        let(:id) { incident_type_other.id }

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end
    end

    put('update incident_type') do
      tags 'Incident Types'
      consumes 'application/json'
      parameter name: :incident_type, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string }
        },
        required: ['description']
      }

      response(204, 'successful') do
        let(:id) { incident_type_other.id }

        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:incident_type) { { description: '' } }
        let(:id) { incident_type_other.id }

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end

      response(400, 'bad request') do
        let(:incident_type) { {} }
        let(:id) { incident_type_other.id }

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end
    end
  end
end
