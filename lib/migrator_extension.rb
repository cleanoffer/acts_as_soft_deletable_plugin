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
      ActiveRecord::Acts::SoftDeletable::Live::InstanceMethods.included_in_classes.each do |klass|
        klass::Deleted.update_columns
        puts "Updating columns of #{klass.name}::Deleted"
      end
    end
  end
end

class ActiveRecord::Migrator; include MigratorExtension; end