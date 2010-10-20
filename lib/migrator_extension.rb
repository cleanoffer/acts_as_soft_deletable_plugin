module MigratorExtension
  def self.included(base)
    base.class_eval do
      include InstanceMethods    
      alias_method_chain :migrate, :deleted_table_update
    end
  end
  module InstanceMethods
    def migrate_with_deleted_table_update(*args)
      migrate_without_deleted_table_update(*args)
      # reloading column definitions, was having issues with Post.columns not reflecting changes
      ActiveRecord::Base.reset_column_information_and_inheritable_attributes_for_all_subclasses
      ActiveRecord::Acts::SoftDeletable::Live::InstanceMethods.included_in_classes.each do |klass|
        klass::Deleted.update_columns
        puts "Updated columns of #{klass.name}::Deleted"
      end
    end
  end
end

class ActiveRecord::Migrator; include MigratorExtension; end