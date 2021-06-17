# frozen_string_literal: true

# Please do not make direct changes to this file!
# This generator is maintained by the community around simple_form-bootstrap:
# https://github.com/heartcombo/simple_form-bootstrap
# All future development, tests, and organization should happen there.
# Background history: https://github.com/heartcombo/simple_form/issues/1561

# Uncomment this and change the path if necessary to include your own
# components.
# See https://github.com/heartcombo/simple_form#custom-components
# to know more about custom components.
# Dir[Rails.root.join('lib/components/**/*.rb')].each { |f| require f }

# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # Default class for buttons
  config.button_class = 'btn'

  # Define the default class of the input wrapper of the boolean input.
  config.boolean_label_class = 'form-check-label'

  # How the label text should be generated altogether with the required text.
  config.label_text = lambda { |label, required, explicit_label| "#{label} #{required}" }

  # Define the way to render check boxes / radio buttons with labels.
  config.boolean_style = :inline

  # You can wrap each item in a collection of radio/check boxes with a tag
  config.item_wrapper_tag = :div

  # Defines if the default input wrapper class should be included in radio
  # collection wrappers.
  config.include_default_input_wrapper_class = false

  # CSS class to add for error notification helper.
  config.error_notification_class = 'alert alert-danger'

  # Method used to tidy up errors. Specify any Rails Array method.
  # :first lists the first message for each field.
  # :to_sentence to list all errors for each field.
  config.error_method = :to_sentence

  # add validation classes to `input_field`
  config.input_field_error_class = 'is-invalid'
  config.input_field_valid_class = 'is-valid'


  # vertical forms
  #
  # vertical default_wrapper
  config.wrappers :vertical_form, tag: 'div', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label
    b.use :input, class: 'form-control', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # vertical input for boolean
  config.wrappers :vertical_boolean, tag: 'fieldset', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :form_check_wrapper, tag: 'div', class: 'form-check' do |bb|
      bb.use :input, class: 'form-check-input', error_class: 'is-invalid', valid_class: 'is-valid'
      bb.use :label, class: 'form-check-label'
      bb.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
      bb.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  # vertical input for radio buttons and check boxes
  config.wrappers :vertical_collection, item_wrapper_class: 'form-check', item_label_class: 'form-check-label', tag: 'fieldset', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :legend_tag, tag: 'legend', class: 'col-form-label pt-0' do |ba|
      ba.use :label_text
    end
    b.use :input, class: 'form-check-input', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # vertical input for inline radio buttons and check boxes
  config.wrappers :vertical_collection_inline, item_wrapper_class: 'form-check form-check-inline', item_label_class: 'form-check-label', tag: 'fieldset', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :legend_tag, tag: 'legend', class: 'col-form-label pt-0' do |ba|
      ba.use :label_text
    end
    b.use :input, class: 'form-check-input', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # vertical file input
  config.wrappers :vertical_file, tag: 'div', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label
    b.use :input, class: 'form-control-file', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # vertical multi select
  config.wrappers :vertical_multi_select, tag: 'div', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label
    b.wrapper tag: 'div', class: 'd-flex flex-row justify-content-between align-items-center' do |ba|
      ba.use :input, class: 'form-control mx-1', error_class: 'is-invalid', valid_class: 'is-valid'
    end
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # vertical range input
  config.wrappers :vertical_range, tag: 'div', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.optional :step
    b.use :label
    b.use :input, class: 'form-control-range', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end


  # horizontal forms
  #
  # horizontal default_wrapper
  config.wrappers :horizontal_form, tag: 'div', class: 'form-group row', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'col-sm-3 col-form-label'
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input, class: 'form-control', error_class: 'is-invalid', valid_class: 'is-valid'
      ba.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  # horizontal input for boolean
  config.wrappers :horizontal_boolean, tag: 'div', class: 'form-group row', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper tag: 'label', class: 'col-sm-3' do |ba|
      ba.use :label_text
    end
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |wr|
      wr.wrapper :form_check_wrapper, tag: 'div', class: 'form-check' do |bb|
        bb.use :input, class: 'form-check-input', error_class: 'is-invalid', valid_class: 'is-valid'
        bb.use :label, class: 'form-check-label'
        bb.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
        bb.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
      end
    end
  end

  # horizontal input for radio buttons and check boxes
  config.wrappers :horizontal_collection, item_wrapper_class: 'form-check', item_label_class: 'form-check-label', tag: 'div', class: 'form-group row', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'col-sm-3 col-form-label pt-0'
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input, class: 'form-check-input', error_class: 'is-invalid', valid_class: 'is-valid'
      ba.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  # horizontal input for inline radio buttons and check boxes
  config.wrappers :horizontal_collection_inline, item_wrapper_class: 'form-check form-check-inline', item_label_class: 'form-check-label', tag: 'div', class: 'form-group row', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'col-sm-3 col-form-label pt-0'
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input, class: 'form-check-input', error_class: 'is-invalid', valid_class: 'is-valid'
      ba.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  # horizontal file input
  config.wrappers :horizontal_file, tag: 'div', class: 'form-group row', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label, class: 'col-sm-3 col-form-label'
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input, error_class: 'is-invalid', valid_class: 'is-valid'
      ba.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  # horizontal multi select
  config.wrappers :horizontal_multi_select, tag: 'div', class: 'form-group row', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'col-sm-3 col-form-label'
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |ba|
      ba.wrapper tag: 'div', class: 'd-flex flex-row justify-content-between align-items-center' do |bb|
        bb.use :input, class: 'form-control mx-1', error_class: 'is-invalid', valid_class: 'is-valid'
      end
      ba.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  # horizontal range input
  config.wrappers :horizontal_range, tag: 'div', class: 'form-group row', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.optional :step
    b.use :label, class: 'col-sm-3 col-form-label'
    b.wrapper :grid_wrapper, tag: 'div', class: 'col-sm-9' do |ba|
      ba.use :input, class: 'form-control-range', error_class: 'is-invalid', valid_class: 'is-valid'
      ba.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
      ba.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end


  # inline forms
  #
  # inline default_wrapper
  config.wrappers :inline_form, tag: 'span', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'sr-only'

    b.use :input, class: 'form-control', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.optional :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # inline input for boolean
  config.wrappers :inline_boolean, tag: 'span', class: 'form-check mb-2 mr-sm-2', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :input, class: 'form-check-input', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :label, class: 'form-check-label'
    b.use :error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.optional :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end


  # bootstrap custom forms
  #
  # custom input for boolean
  config.wrappers :custom_boolean, tag: 'fieldset', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :form_check_wrapper, tag: 'div', class: 'custom-control custom-checkbox' do |bb|
      bb.use :input, class: 'custom-control-input', error_class: 'is-invalid', valid_class: 'is-valid'
      bb.use :label, class: 'custom-control-label'
      bb.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
      bb.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  # custom input switch for boolean
  config.wrappers :custom_boolean_switch, tag: 'fieldset', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :form_check_wrapper, tag: 'div', class: 'custom-control custom-switch' do |bb|
      bb.use :input, class: 'custom-control-input', error_class: 'is-invalid', valid_class: 'is-valid'
      bb.use :label, class: 'custom-control-label'
      bb.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
      bb.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
    end
  end

  # custom input for radio buttons and check boxes
  config.wrappers :custom_collection, item_wrapper_class: 'custom-control', item_label_class: 'custom-control-label', tag: 'fieldset', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :legend_tag, tag: 'legend', class: 'col-form-label pt-0' do |ba|
      ba.use :label_text
    end
    b.use :input, class: 'custom-control-input', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # custom input for inline radio buttons and check boxes
  config.wrappers :custom_collection_inline, item_wrapper_class: 'custom-control custom-control-inline', item_label_class: 'custom-control-label', tag: 'fieldset', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :legend_tag, tag: 'legend', class: 'col-form-label pt-0' do |ba|
      ba.use :label_text
    end
    b.use :input, class: 'custom-control-input', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # custom file input
  config.wrappers :custom_file, tag: 'div', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label
    b.wrapper :custom_file_wrapper, tag: 'div', class: 'custom-file' do |ba|
      ba.use :input, class: 'custom-file-input', error_class: 'is-invalid', valid_class: 'is-valid'
      ba.use :label, class: 'custom-file-label'
      ba.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    end
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # custom multi select
  config.wrappers :custom_multi_select, tag: 'div', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :label
    b.wrapper tag: 'div', class: 'd-flex flex-row justify-content-between align-items-center' do |ba|
      ba.use :input, class: 'custom-select mx-1', error_class: 'is-invalid', valid_class: 'is-valid'
    end
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # custom range input
  config.wrappers :custom_range, tag: 'div', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.optional :step
    b.use :label
    b.use :input, class: 'custom-range', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end


  # Input Group - custom component
  # see example app and config at https://github.com/heartcombo/simple_form-bootstrap
  # config.wrappers :input_group, tag: 'div', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
  #   b.use :html5
  #   b.use :placeholder
  #   b.optional :maxlength
  #   b.optional :minlength
  #   b.optional :pattern
  #   b.optional :min_max
  #   b.optional :readonly
  #   b.use :label
  #   b.wrapper :input_group_tag, tag: 'div', class: 'input-group' do |ba|
  #     ba.optional :prepend
  #     ba.use :input, class: 'form-control', error_class: 'is-invalid', valid_class: 'is-valid'
  #     ba.optional :append
  #   end
  #   b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback d-block' }
  #   b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  # end


  # Floating Labels form
  #
  # floating labels default_wrapper
  config.wrappers :floating_labels_form, tag: 'div', class: 'form-label-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :input, class: 'form-control', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :label
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  # custom multi select
  config.wrappers :floating_labels_select, tag: 'div', class: 'form-label-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.optional :readonly
    b.use :input, class: 'custom-select', error_class: 'is-invalid', valid_class: 'is-valid'
    b.use :label
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end

  config.wrappers :vertical_rich_text_area, tag: 'div', class: 'form-group', error_class: 'form-group-invalid', valid_class: 'form-group-valid' do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'form-control-label'
    b.wrapper tag: 'div', class: 'trix-frame' do |ba|
      ba.use :input, class: 'form-control', error_class: 'is-invalid', valid_class: 'is-valid'
    end
    b.use :full_error, wrap_with: { tag: 'div', class: 'invalid-feedback' }
    b.use :hint, wrap_with: { tag: 'small', class: 'form-text text-muted' }
  end


  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :vertical_form

  # Custom wrappers for input types. This should be a hash containing an input
  # type as key and the wrapper that will be used for all inputs with specified type.
  config.wrapper_mappings = {
    boolean:        :vertical_boolean,
    check_boxes:    :vertical_collection,
    date:           :vertical_multi_select,
    datetime:       :vertical_multi_select,
    file:           :vertical_file,
    radio_buttons:  :vertical_collection,
    range:          :vertical_range,
    time:           :vertical_multi_select,
    rich_text_area: :vertical_rich_text_area
  }

  # enable custom form wrappers
  # config.wrapper_mappings = {
  #   boolean:        :custom_boolean,
  #   check_boxes:    :custom_collection,
  #   date:           :custom_multi_select,
  #   datetime:       :custom_multi_select,
  #   file:           :custom_file,
  #   radio_buttons:  :custom_collection,
  #   range:          :custom_range,
  #   time:           :custom_multi_select,
  #   rich_text_area: :custom_rich_text_area
  # }
end
