require 'active_admin/views/index_as_table'

module ActiveAdmin
  module Views
    class IndexAsGroupedTabs < IndexAsTable

      def build(page_presenter, collection)
        if (group_by_attribute = page_presenter[:group_by_attribute])
          tabs do
            collection.group_by(&group_by_attribute).sort.each do |group_name, group_collection|
              tab group_name do
                super page_presenter, group_collection
              end
            end
          end
        else
          super
        end
      end

    end
  end
end