require 'roar/coercion'
require_relative 'resource_collection'
require_relative 'pagination'

require_relative 'const_unset'
Roar::JSON::JSONAPI::Options::Include.const_unset(:DEFAULT_INTERNAL_INCLUDES)
Roar::JSON::JSONAPI::Options::Include::DEFAULT_INTERNAL_INCLUDES = [:attributes, :relationships, :links].freeze

require 'roar/json/json_api'
require 'grape/roar/decorator'
require 'representable/debug'

module ApiRepresenter

  extend ActiveSupport::Concern

  def self_url(opts)
    self.class.self_url(opts)
  end

  module ClassMethods

    def self_url(opts)
      "#{opts[:base_url]}/#{self.type}]}"
    end

  end

  def self.included(klass)

    klass.class_eval do

      include Roar::JSON
      include Roar::Coercion
      include Representable::Hash
      include Representable::Hash::AllowSymbols
      include Roar::JSON::JSONAPI::Mixin

      extend Pagination

      property :id, writable: false, type: String, desc: 'Object\'s unique identifier'

      link(:self) do |opts|
        "#{self_url(opts)}/#{represented.id}"
      end

      link(self, toplevel: true) do |opts|
        opts[:this_url]
      end

    end

  end

end
