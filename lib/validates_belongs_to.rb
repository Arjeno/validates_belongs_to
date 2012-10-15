require 'active_record'
require 'validates_belongs_to/version'

module ValidatesBelongsTo

  extend ActiveSupport::Concern

  module ClassMethods

    def validates_belongs_to(assocation, owner)
      validates assocation, :belongs_to => owner
    end

  end

  class BelongsToValidator < ActiveModel::EachValidator

    def validate_each(record, attribute, owner)
      record_value  = get_id_by_association(record)
      owner_value   = get_id_by_association(owner)

      unless record_value == owner_value
        record.errors.add(attribute, :belongs_to, options.merge(:value => options[:with]))
      end
    end

    protected

      def get_id_by_association(record)
        association = record.class.reflect_on_association(options[:with])

        if association.try(:macro) == :belongs_to
          record.send(association.foreign_key)
        else
          association_resource = record.send(options[:with])
          association_resource.try(association_resource.class.primary_key)
        end
      end

  end
end

ActiveRecord::Base.send(:include, ValidatesBelongsTo)
I18n.load_path << File.dirname(__FILE__) + '/validates_belongs_to/locale/en.yml'