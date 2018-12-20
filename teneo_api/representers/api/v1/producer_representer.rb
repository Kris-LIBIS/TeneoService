require 'roar/decorator'
require 'roar/json'

module Api
  module V1
    class ProducerRepresenter < ApiRepresenter['producers']

      attributes do
        property :name
        property :description
      end

    end
  end
end