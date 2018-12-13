=begin
module Api
  module V1
    class UserResource < ApiResource

      type :users

      model User

      # Customize your resource here. Some common examples:
      #
      # === Allow ?filter[name] query parameter ===
      # allow_filter :name
      #
      # === Enable total count, when requested ===
      # allow_stat total: [:count]
      #
      # === Allow sideloading/sideposting of relationships ===
      # belongs_to :foo,
      #   foreign_key: :foo_id,
      #   resource: FooResource,
      #   scope: -> { Foo.all }
      #
      # === Custom sorting logic ===
      # sort do |scope, att, dir|
      #   ... code ...
      # end
      #
      # === Change default sort ===
      # default_sort([{ title: :asc }])
      #
      # === Custom pagination logic ===
      # paginate do |scope, current_page, per_page|
      #   ... code ...
      # end
      #
      # === Change default page size ===
      # default_page_size(10)
      #
      # === Change how we resolve the scope ===
      # def resolve(scope)
      #   ... code ...
      # end

    end
  end
end
=end
