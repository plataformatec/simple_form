module SimpleForm
  module Inputs
    class Base
      extend I18nCache

      # When action is create or update, we still should use new and edit
      ACTIONS = {
        :create => :new,
        :update => :edit
      }

      include SimpleForm::Components::Errors
      include SimpleForm::Components::Hints
      include SimpleForm::Components::LabelInput
      include SimpleForm::Components::Wrapper

      delegate :template, :object, :object_name, :attribute_name, :column,
               :reflection, :input_type, :options, :to => :@builder

      def initialize(builder)
        @builder = builder
      end

      def input
        raise NotImplementedError
      end

      def input_options
        options
      end

      def input_html_options
        html_options = html_options_for(:input, input_html_classes)
        html_options[:required] = true if attribute_required?
        html_options
      end

      def input_html_classes
        [input_type, required_class]
      end

      def render
        content = "".html_safe
        components_list.each do |component|
          next if options[component] == false
          content.safe_concat send(component).to_s
        end
        wrap(content)
      end

    protected

      def components_list
        options[:components] || SimpleForm.components
      end

      def attribute_required?
        if options.key?(:required)
          options[:required]
        elsif has_validators?
          (attribute_validators + reflection_validators).any? { |v| v.kind == :presence }
        else
          attribute_required_by_default?
        end
      end

      def has_validators?
        object.class.respond_to?(:validators_on)
      end

      def attribute_validators
        object.class.validators_on(attribute_name)
      end

      def reflection_validators
        reflection ? object.class.validators_on(reflection.name) : []
      end

      def attribute_required_by_default?
        SimpleForm.required_by_default
      end

      def required_class
        attribute_required? ? :required : :optional
      end

      # Find reflection name when available, otherwise use attribute
      def reflection_or_attribute_name
        reflection ? reflection.name : attribute_name
      end

      # Retrieve options for the given namespace from the options hash
      def html_options_for(namespace, extra)
        html_options = options[:"#{namespace}_html"] || {}
        html_options[:class] = (extra << html_options[:class]).join(' ').strip if extra.present?
        html_options
      end

      # Lookup translations for the given namespace using I18n, based on object name,
      # actual action and attribute name. Lookup priority as follows:
      #
      #   simple_form.{namespace}.{model}.{action}.{attribute}
      #   simple_form.{namespace}.{model}.{attribute}
      #   simple_form.{namespace}.{attribute}
      #
      #  Namespace is used for :labels and :hints.
      #
      #  Model is the actual object name, for a @user object you'll have :user.
      #  Action is the action being rendered, usually :new or :edit.
      #  And attribute is the attribute itself, :name for example.
      #
      #  Example:
      #
      #    simple_form:
      #      labels:
      #        user:
      #          new:
      #            email: 'E-mail para efetuar o sign in.'
      #          edit:
      #            email: 'E-mail.'
      #
      #  Take a look at our locale example file.
      def translate(namespace, default='')
        lookups = []
        lookups << :"#{object_name}.#{lookup_action}.#{reflection_or_attribute_name}"
        lookups << :"#{object_name}.#{reflection_or_attribute_name}"
        lookups << :"#{reflection_or_attribute_name}"
        lookups << default
        I18n.t(lookups.shift, :scope => :"simple_form.#{namespace}", :default => lookups)
      end

      # The action to be used in lookup.
      def lookup_action
        return unless template.controller.action_name

        action = template.controller.action_name.to_sym
        ACTIONS[action] || action
      end
    end
  end
end
