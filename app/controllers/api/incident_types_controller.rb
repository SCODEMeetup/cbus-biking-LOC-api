# frozen_string_literal: true

module Api
  # CRUD operations on the IncidentTypes endpoint
  class IncidentTypesController < ApplicationController
    before_action :set_incident_type, only: %i[show destroy update]
    before_action :set_headers

    # GET incident_types/:id
    def show
      render json: @incident_type
    end

    def index
      render json: IncidentType.all
    end

    # POST /incident_types
    def create
      @incident_type = IncidentType.new(incident_type_params)
      if @incident_type.save
        render json: @incident_type, status: :created,
               location: api_report_url(@incident_type)
      else
        render json: @incident_type.errors, status: :unprocessable_entity
      end
    end

    # DELETE incident_types/:id
    def destroy
      return unless @incident_type

      @incident_type.destroy
    end

    # PATCH/PUT incident_types/:id
    def update
      return unless @incident_type

      @incident_type.update(incident_type_params)
      return if @incident_type.valid?

      render json: @incident_type.errors, status: :unprocessable_entity
    end

    def set_incident_type
      @incident_type = IncidentType.find(params[:id])
    end

    def set_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, DELETE, GET'
      headers['Access-Control-Request-Method'] = '*'
    end

    def incident_type_params
      params.require(:incident_type).permit(:description)
    end
  end
end
