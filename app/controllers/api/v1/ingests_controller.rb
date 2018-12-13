# frozen_string_literal: true

module Api
  module V1

    class IngestsController < Controller
      before_action :set_ingest, only: [:show, :update, :destroy]

      # GET /ingests
      def index
        @ingests = Ingest.all

        render json: @ingests
      end

      # GET /ingests/1
      def show
        render json: @ingest
      end

      # POST /ingests
      def create
        @ingest = Ingest.new(ingest_params)

        if @ingest.save
          render json: @ingest, status: :created, location: @ingest
        else
          render json: @ingest.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /ingests/1
      def update
        if @ingest.update(ingest_params)
          render json: @ingest
        else
          render json: @ingest.errors, status: :unprocessable_entity
        end
      end

      # DELETE /ingests/1
      def destroy
        @ingest.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_ingest
        @ingest = Ingest.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def ingest_params
        params.require(:ingest).permit(:stage, :status, :name, :base_dir)
      end
    end

  end
end
