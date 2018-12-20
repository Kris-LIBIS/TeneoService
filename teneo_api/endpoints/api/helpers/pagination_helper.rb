require "kaminari/grape"
require "grape/kaminari/max_value_validator"

module Api::Helpers::PaginationHelper
  extend Grape::API::Helpers

  def paginate(collection)
    collection.page(params.page.number).per(params.page.size).padding(params.page.offset)
  end

end
