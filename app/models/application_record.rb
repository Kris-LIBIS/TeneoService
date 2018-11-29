require 'libis/tools/extend/hash'

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def ApplicationRecord.from_hash(hash)
    self.create_from_hash(hash.cleanup, [:name])
  end

  def self.create_from_hash(hash, id_tags, &block)
    hash = hash.key_symbols_to_strings(recursive: true)
    id_tags = id_tags.map(&:to_s)
    return nil unless id_tags.empty? || id_tags.any? { |k| hash.include?(k) }
    tags = id_tags.inject({}) do |h, k|
      v = hash.delete(k)
      h[k] = v if v
      h
    end
    item = tags.empty? ? self.new : self.find_or_initialize_by(tags)
    block.call(item, hash) if block unless hash.empty?
    item.assign_attributes(hash)
    unless self.embedded?
      item.save!
    end
    item
  end

end
