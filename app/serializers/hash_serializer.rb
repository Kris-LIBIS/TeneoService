# frozen_string_literal: true

require 'json'

class HashSerializer
  def self.dump(hash)
    hash.to_json
  end

  def self.load(hash)
    JSON.parse(hash || '{}').with_indifferent_access
  end
end
