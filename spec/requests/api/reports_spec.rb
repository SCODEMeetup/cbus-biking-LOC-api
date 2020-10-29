# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe '/api/reports_controller', type: :request do
  let!(:incident_type) { create(:incident_type) }
  let!(:incident_severity) { create(:incident_severity) }

  let!(:report) do
    create(:report, incident_type_id: incident_type.id,
    incident_severity_id: incident_severity.id)
  end

  path '/api/reports' do
    post('create report') do
      tags 'Reports'
      consumes 'application/json'
      parameter name: :report, in: :body, schema: {
        type: :object,
        properties: {
          lat: { type: :number, format: 'float', minimum: '-90.0',
                 maximum: '90.0' },
          long: { type: :number, format: 'float', minimum: '-180.0',
                  maximum: '180.0' },
          incident_datetime: { type: :string, format: 'date-time' },
          incident_text: { type: :string, maximum: 64_000 },
          incident_type_id: { type: :integer, minimum: 1, maximum: 4 },
          incident_severity_id: { type: :integer, minimum: 1, maximum: 5 }
        },
        required: %w[lat long incident_datetime incident_type_id
                     incident_severity_id]
      }

      response(201, 'report created') do
        let(:report) do
          { lat: 39.8846, long: -82.9192, incident_datetime: '2020-09-23',
          incident_text: 'scary ride', incident_type_id: incident_type.id,
          incident_severity_id: incident_severity.id }
        end

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:report) do
          { lat: 39.8846, long: -82.9192, incident_datetime: '',
           incident_text: 'welcome to rswag!', incident_type_id: 4,
           incident_severity_id: 3 }
        end

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end

      response(400, 'bad request') do
        let(:report) { {} }

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end
    end

    get('list reports') do
      tags 'Reports'

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

  path '/api/reports/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show report') do
      tags 'Reports'
      response(200, 'successful') do
        let(:id) { report.id }

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

    delete('delete report') do
      tags 'Reports'
      response(204, 'no content') do
        let(:id) { report.id }

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
  end
end
