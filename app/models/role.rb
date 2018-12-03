# frozen_string_literal: true

class Role < ApplicationRecord
  def self.from_hash(hash)
    super(hash, [:code])
  end
end
