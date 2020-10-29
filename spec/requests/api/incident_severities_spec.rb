# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/incident_severities', type: :request do
  let!(:incident_severity) { create(:incident_severity) }

  let!(:incident_severity_other) { create(:incident_severity) }
  let!(:incident_type) { create(:incident_type) }
  let!(:report) do
    create(:report, incident_severity_id: incident_severity_other.id,
    incident_type_id: incident_type.id)
  end

  path '/api/incident_severities' do
    post('create incident_severity') do
      tags 'Incident Severities'
      consumes 'application/json'
      parameter name: :incident_severity, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string }
        },
        required: ['description']
      }

      response(201, 'incident severity created') do
        let(:incident_severity) { { description: 'critical' } }

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:incident_severity) { { description: '' } }

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end

      response(400, 'bad request') do
        let(:incident_severity) { {} }

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end
    end

    get('list incident severities') do
      tags 'Incident Severities'
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

  path '/api/incident_severities/{id}' do
    # You'll want to customize the parameter severitys...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show incident severity') do
      tags 'Incident Severities'
      response(200, 'successful') do
        let(:incident_severity) { create(:incident_severity) }
        let(:id) { incident_severity.id }

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

    delete('delete incident severity') do
      tags 'Incident Severities'
      response(204, 'no content') do
        let(:id) { incident_severity.id }

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
        let(:id) { incident_severity_other.id }

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end
    end

    put('update incident_severity') do
      tags 'Incident Severities'
      consumes 'application/json'
      parameter name: :incident_severity, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string }
        },
        required: ['description']
      }

      response(204, 'successful') do
        let(:id) { incident_severity_other.id }

        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:incident_severity) { { description: '' } }
        let(:id) { incident_severity_other.id }

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end

      response(400, 'bad request') do
        let(:incident_severity) { {} }
        let(:id) { incident_severity_other.id }

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
