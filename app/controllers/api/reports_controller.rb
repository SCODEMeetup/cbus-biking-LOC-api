# frozen_string_literal: true

module Api
  # CRUD operations on the Reports endpoint
  class ReportsController < ApplicationController
    before_action :set_report, only: %i[show destroy]
    before_action :set_headers
    before_action :permit_params
    before_action :set_reports, only: [:index]

    # GET reports/:id
    def show
      # render json: @report
      render json: @report, serializer: DetailedReportSerializer
    end

    def index
      if @reports == Report.none
        # default incident_subject_id is 1 (bicycle related)
        # for backward compatibility
        @reports = Report.distinct.by_incident_subject_id('1')
                         .by_current_and_last_incident_year
      end

      by_incident_year

      by_incident_subject_id

      by_incident_severity_id

      if @reports.blank?
        render json: {}
      else
        render json: @reports
      end
    end

    # POST /reports
    def create
      @report = Report.new(report_params)
      if @report.save
        render json: @report, status: :created,
               location: api_report_url(@report)
      else
        render json: @report.errors, status: :unprocessable_entity
      end
    end

    # DELETE reports/:id
    def destroy
      return unless @report

      @report.destroy
    end

    def set_report
      @report = Report.find(params[:id])
    end

    def set_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, DELETE, GET'
      headers['Access-Control-Request-Method'] = '*'
    end

    def set_reports
      @reports =
        if !@incident_year && !@incident_subject_id && !@incident_severity_id
          Report.none
        else
          Report.distinct
        end
    end

    def permit_params
      params.permit(:incident_year, :incident_subject_id,
                    :incident_severity_id).tap do |param|
        @incident_year = param[:incident_year]
        @incident_subject_id = param[:incident_subject_id]
        @incident_severity_id = param[:incident_severity_id]
      end
    end

    def report_params
      params.require(:report)
            .permit(:lat, :long, :incident_type_id, :incident_severity_id,
                    :incident_year, :incident_datetime, :incident_text,
                    :incident_subject_id)
            # defaults added for backward compatibility for bike_safety web-ui
            .with_defaults(incident_year: '2022', incident_subject_id: '1')
    end

    def by_incident_year
      return unless @incident_year

      @reports = @reports.by_incident_year(@incident_year)
    end

    def by_incident_subject_id
      return unless @incident_subject_id

      @reports = @reports.by_incident_subject_id(@incident_subject_id)
    end

    def by_incident_severity_id
      return unless @incident_severity_id

      @reports = @reports.by_incident_severity_id(@incident_severity_id)
    end

    def serialized_reports
      ActiveModelSerializers::SerializableResource.new(@reports)
                                                  .as_json
    end
  end
end
