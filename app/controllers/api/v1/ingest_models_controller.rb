# frozen_string_literal: true

module Api
  module V1

    class IngestModelsController < ApiController
      before_action :set_ingest_model, only: [:show, :update, :destroy]

      # GET /ingest_models
      def index
        @ingest_models = IngestModel.all

        render json: @ingest_models
      end

      # GET /ingest_models/1
      def show
        render json: @ingest_model
      end

      # POST /ingest_models
      def create
        @ingest_model = IngestModel.new(ingest_model_params)

        if @ingest_model.save
          render json: @ingest_model, status: :created, location: @ingest_model
        else
          render json: @ingest_model.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /ingest_models/1
      def update
        if @ingest_model.update(ingest_model_params)
          render json: @ingest_model
        else
          render json: @ingest_model.errors, status: :unprocessable_entity
        end
      end

      # DELETE /ingest_models/1
      def destroy
        @ingest_model.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_ingest_model
        @ingest_model = IngestModel.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def ingest_model_params
        params.require(:ingest_model).permit(:name, :description, :entity_type, :user_a, :user_b, :user_c, :identifier, :status)
      end
    end

  end
end
