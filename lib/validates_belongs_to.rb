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
      association       = record.class.reflect_on_association(attribute)
      association_type  = association.macro
      method            = "validate_by_#{association_type}"

      send(method, record, attribute, owner) if respond_to?(method)
    end

    protected

      def validate_by_belongs_to(record, attribute, owner)
        record_value  = get_id_by_association(record, options[:with])
        owner_value   = get_id_by_association(owner, options[:with])

        unless record_value == owner_value || owner_value.nil?
          record.errors.add(attribute, :belongs_to, options.merge(:value => options[:with]))
        end
      end

      def validate_by_has_and_belongs_to_many(record, attribute, owner)
        record_value  = get_id_by_association(record, options[:with])
        owner_values  = owner.map { |o| get_id_by_association(o, options[:with]) }.compact.uniq

        unless owner_values == [record_value] || owner_values.empty?
          record.errors.add(attribute, :belongs_to_habtm, options.merge(:value => options[:with]))
        end
      end

      def get_id_by_association(record, association_name)
        return nil if record.nil?

        association = record.class.reflect_on_association(association_name)

        if association.try(:macro) == :belongs_to
          record.send(association.foreign_key)
        else
          association_resource = record.send(association_name)
          association_resource.try(association_resource.class.primary_key)
        end
      end

  end
end

ActiveRecord::Base.send(:include, ValidatesBelongsTo)
I18n.load_path << File.dirname(__FILE__) + '/validates_belongs_to/locale/en.yml'