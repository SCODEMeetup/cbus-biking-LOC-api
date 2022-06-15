# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'api/incident_subjects', type: :request do
  let!(:incident_subject) { create(:incident_subject) }

  let!(:incident_subject_other) { create(:incident_subject) }
  let!(:incident_type) { create(:incident_type) }
  let!(:incident_severity) { create(:incident_severity) }
  let!(:report) do
    create(:report, incident_subject_id: incident_subject_other.id,
    incident_type_id: incident_type.id,
    incident_severity_id: incident_severity.id)
  end

  path '/api/incident_subjects' do
    post('create incident_subject') do
      tags 'Incident Subjects'
      consumes 'application/json'
      parameter name: :incident_subject, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string }
        },
        required: ['description']
      }

      response(201, 'incident subject created') do
        let(:incident_subject) { { description: 'critical' } }

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:incident_subject) { { description: '' } }

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end

      response(400, 'bad request') do
        let(:incident_subject) { {} }

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end
    end

    get('list incident subjects') do
      tags 'Incident Subjects'
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

  path '/api/incident_subjects/{id}' do
    # You'll want to customize the parameter severitys...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show incident subject') do
      tags 'Incident Subjects'
      response(200, 'successful') do
        let(:incident_subject) { create(:incident_subject) }
        let(:id) { incident_subject.id }

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

    delete('delete incident subject') do
      tags 'Incident Subjects'
      response(204, 'no content') do
        let(:id) { incident_subject.id }

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
        let(:id) { incident_subject_other.id }

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end
    end

    put('update incident_subject') do
      tags 'Incident Subjects'
      consumes 'application/json'
      parameter name: :incident_subject, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string }
        },
        required: ['description']
      }

      response(204, 'successful') do
        let(:id) { incident_subject_other.id }

        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:incident_subject) { { description: '' } }
        let(:id) { incident_subject_other.id }

        after do |example|
          example.metadata[:response][:examples] =
            { 'application/json' => JSON.parse(response.body,
                                               symbolize_names: true) }
        end
        run_test!
      end

      response(400, 'bad request') do
        let(:incident_subject) { {} }
        let(:id) { incident_subject_other.id }

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
