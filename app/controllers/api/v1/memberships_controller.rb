# frozen_string_literal: true

module Api
  module V1

    class MembershipsController < ApplicationController
      before_action :set_membership, only: [:show, :update, :destroy]

      # GET /memberships
      def index
        @memberships = Membership.where(user_id: current_user.id)

        render json: @memberships
      end

      # GET /memberships/1
      def show
        if @membership.user == current_user && current_user
          render json: @membership
        end
      end

      # POST /memberships
      def create
        @membership = Membership.new(membership_params)

        if @membership.save
          render json: @membership, status: :created, location: @membership
        else
          render json: @membership.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /memberships/1
      def update
        if @membership.update(membership_params)
          render json: @membership
        else
          render json: @membership.errors, status: :unprocessable_entity
        end
      end

      # DELETE /memberships/1
      def destroy
        @membership.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_membership
        @membership = Membership.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def membership_params
        params.require(:membership).permit(:user_id, :organization_id, :role_id)
      end
    end

  end
end
