require "grape"
require "grape/kaminari/version"
require "grape/kaminari/max_value_validator"
require "kaminari/grape"

module Api
  module Endpoint
    include ActiveSupport::Concern

    module ClassMethods

      DEFAULT_PAGE_NUMBER = 1
      DEFAULT_PAGE_SIZE = 10
      MAX_PAGE_SIZE = 100
      DEFAULT_PAGE_OFFSET = 0

      def paginate(options = {})

        options.reverse_merge!(
            per_page: DEFAULT_PAGE_SIZE,
            max_per_page: MAX_PAGE_SIZE,
            offset: DEFAULT_PAGE_OFFSET
        )

        params :paginate do
          optional :page, type: Hash, desc: 'Paginatation parameters' do
            optional :number,
                     type: Integer,
                     default: DEFAULT_PAGE_NUMBER,
                     desc: 'Page number to retrieve (1 to x)'
            optional :size,
                     type: Integer,
                     default: options[:per_page],
                     max_value: options[:max_per_page],
                     desc: 'Number of items per page'
            optional :offset,
                     type: Integer,
                     default: options[:offset],
                     desc: 'Number of items to skip'
          end
        end

        helpers do
        end

      end

    end

  end
end

