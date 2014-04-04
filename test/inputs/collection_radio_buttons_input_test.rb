# encoding: UTF-8
require 'test_helper'

class CollectionRadioButtonsInputTest < ActionView::TestCase
  setup do
    SimpleForm::Inputs::CollectionRadioButtonsInput.reset_i18n_cache :boolean_collection
  end

  test 'input should generate boolean radio buttons by default for radio types' do
    with_input_for @user, :active, :radio_buttons
    assert_select 'input[type=radio][value=true].radio_buttons#user_active_true'
    assert_select 'input[type=radio][value=false].radio_buttons#user_active_false'
  end

  test 'input as radio should generate internal labels by default' do
    with_input_for @user, :active, :radio_buttons
    assert_select 'label[for=user_active_true]', 'Yes'
    assert_select 'label[for=user_active_false]', 'No'
  end

  test 'input as radio should generate internal labels with accurate `for` values with nested boolean style' do
    swap SimpleForm, boolean_style: :nested do
      with_input_for @user, :active, :radio_buttons
      assert_select 'label[for=user_active_true]', 'Yes'
      assert_select 'label[for=user_active_false]', 'No'
    end
  end

  test 'nested label should not duplicate input id' do
    swap SimpleForm, boolean_style: :nested do
      with_input_for @user, :active, :radio_buttons, id: 'nested_id'
      assert_select 'input#user_active_true'
      assert_no_select 'label#user_active_true'
    end
  end

  test 'input as radio should use i18n to translate internal labels' do
    store_translations(:en, simple_form: { yes: 'Sim', no: 'Não' }) do
      with_input_for @user, :active, :radio_buttons
      assert_select 'label[for=user_active_true]', 'Sim'
      assert_select 'label[for=user_active_false]', 'Não'
    end
  end

  test 'input as radio should allow overidding i18n for boolean labels' do
    translations = {
      simple_form: {
        options: {
          user: {
            active: {
              true: 'Sim!',
              false: 'Não!'
            }
          }
        }
      }
    }
    store_translations(:en, translations) do
      with_input_for @user, :active, :radio_buttons
      assert_select 'label[for=user_active_true]', 'Sim!'
      assert_select 'label[for=user_active_false]', 'Não!'
    end
  end

  test 'input radio should not include for attribute by default' do
    with_input_for @user, :gender, :radio_buttons, collection: [:male, :female]
    assert_select 'label'
    assert_no_select 'label[for=user_gender]'
  end

  test 'input radio should include for attribute when giving as html option' do
    with_input_for @user, :gender, :radio_buttons, collection: [:male, :female], label_html: { for: 'gender' }
    assert_select 'label[for=gender]'
  end

  test 'input should mark the checked value when using boolean and radios' do
    @user.active = false
    with_input_for @user, :active, :radio_buttons
    assert_no_select 'input[type=radio][value=true][checked]'
    assert_select 'input[type=radio][value=false][checked]'
  end

  test 'input should allow overriding collection for radio types' do
    with_input_for @user, :name, :radio_buttons, collection: ['Jose', 'Carlos']
    assert_select 'input[type=radio][value=Jose]'
    assert_select 'input[type=radio][value=Carlos]'
    assert_select 'label.collection_radio_buttons[for=user_name_jose]', 'Jose'
    assert_select 'label.collection_radio_buttons[for=user_name_carlos]', 'Carlos'
  end

  test 'input should do automatic collection translation for radio types using defaults key' do
    store_translations(:en, simple_form: { options: { defaults: {
      gender: { male: 'Male', female: 'Female'}
    } } } ) do
      with_input_for @user, :gender, :radio_buttons, collection: [:male, :female]
      assert_select 'input[type=radio][value=male]'
      assert_select 'input[type=radio][value=female]'
      assert_select 'label.collection_radio_buttons[for=user_gender_male]', 'Male'
      assert_select 'label.collection_radio_buttons[for=user_gender_female]', 'Female'
    end
  end

  test 'input should do automatic collection translation for radio types using specific object key' do
    store_translations(:en, simple_form: { options: { user: {
      gender: { male: 'Male', female: 'Female'}
    } } } ) do
      with_input_for @user, :gender, :radio_buttons, collection: [:male, :female]
      assert_select 'input[type=radio][value=male]'
      assert_select 'input[type=radio][value=female]'
      assert_select 'label.collection_radio_buttons[for=user_gender_male]', 'Male'
      assert_select 'label.collection_radio_buttons[for=user_gender_female]', 'Female'
    end
  end

  test 'input should do automatic collection translation and preserve html markup' do
    swap SimpleForm, boolean_style: :nested do
      store_translations(:en, simple_form: { options: { user: {
        gender: { male_html: '<strong>Male</strong>', female_html: '<strong>Female</strong>' }
      } } } ) do
        with_input_for @user, :gender, :radio_buttons, collection: [:male, :female]
        assert_select 'input[type=radio][value=male]'
        assert_select 'input[type=radio][value=female]'
        assert_select 'label[for=user_gender_male]', 'Male'
        assert_select 'label[for=user_gender_female]', 'Female'
      end
    end
  end

  test 'input should do automatic collection translation with keys prefixed with _html and a string value' do
    swap SimpleForm, boolean_style: :nested do
      store_translations(:en, simple_form: { options: { user: {
        gender: { male_html: 'Male', female_html: 'Female' }
      } } } ) do
        with_input_for @user, :gender, :radio_buttons, collection: [:male, :female]
        assert_select 'input[type=radio][value=male]'
        assert_select 'input[type=radio][value=female]'
        assert_select 'label[for=user_gender_male]', 'Male'
        assert_select 'label[for=user_gender_female]', 'Female'
      end
    end
  end

  test 'input should mark the current radio value by default' do
    @user.name = "Carlos"
    with_input_for @user, :name, :radio_buttons, collection: ['Jose', 'Carlos']
    assert_select 'input[type=radio][value=Carlos][checked=checked]'
  end

  test 'input should accept html options as the last element of collection' do
    with_input_for @user, :name, :radio_buttons, collection: [['Jose', 'jose', class: 'foo']]
    assert_select 'input.foo[type=radio][value=jose]'
  end

  test 'input should allow using a collection with text/value arrays' do
    with_input_for @user, :name, :radio_buttons, collection: [['Jose', 'jose'], ['Carlos', 'carlos']]
    assert_select 'input[type=radio][value=jose]'
    assert_select 'input[type=radio][value=carlos]'
    assert_select 'label.collection_radio_buttons', 'Jose'
    assert_select 'label.collection_radio_buttons', 'Carlos'
  end

  test 'input should allow using a collection with a Proc' do
    with_input_for @user, :name, :radio_buttons, collection: Proc.new { ['Jose', 'Carlos' ] }
    assert_select 'label.collection_radio_buttons', 'Jose'
    assert_select 'label.collection_radio_buttons', 'Carlos'
  end

  test 'input should allow overriding only label method for collections' do
    with_input_for @user, :name, :radio_buttons,
                          collection: ['Jose', 'Carlos'],
                          label_method: :upcase
    assert_select 'label.collection_radio_buttons', 'JOSE'
    assert_select 'label.collection_radio_buttons', 'CARLOS'
  end

  test 'input should allow overriding only value method for collections' do
    with_input_for @user, :name, :radio_buttons,
                          collection: ['Jose', 'Carlos'],
                          value_method: :upcase
    assert_select 'input[type=radio][value=JOSE]'
    assert_select 'input[type=radio][value=CARLOS]'
  end

  test 'input should allow overriding label and value method for collections' do
    with_input_for @user, :name, :radio_buttons,
                          collection: ['Jose', 'Carlos'],
                          label_method: :upcase,
                          value_method: :downcase
    assert_select 'input[type=radio][value=jose]'
    assert_select 'input[type=radio][value=carlos]'
    assert_select 'label.collection_radio_buttons', 'JOSE'
    assert_select 'label.collection_radio_buttons', 'CARLOS'
  end

  test 'input should allow overriding label and value method using a lambda for collections' do
    with_input_for @user, :name, :radio_buttons,
                          collection: ['Jose', 'Carlos'],
                          label_method: lambda { |i| i.upcase },
                          value_method: lambda { |i| i.downcase }
    assert_select 'input[type=radio][value=jose]'
    assert_select 'input[type=radio][value=carlos]'
    assert_select 'label.collection_radio_buttons', 'JOSE'
    assert_select 'label.collection_radio_buttons', 'CARLOS'
  end

  test 'collection input with radio type should generate required html attribute' do
    with_input_for @user, :name, :radio_buttons, collection: ['Jose', 'Carlos']
    assert_select 'input[type=radio].required'
    assert_select 'input[type=radio][required]'
  end

  test 'collection input with radio type should generate aria-required html attribute' do
    with_input_for @user, :name, :radio_buttons, collection: ['Jose', 'Carlos']
    assert_select 'input[type=radio].required'
    assert_select 'input[type=radio][aria-required=true]'
  end

  test 'input radio does not wrap the collection by default' do
    with_input_for @user, :active, :radio_buttons

    assert_select 'form input[type=radio]', count: 2
    assert_no_select 'form ul'
  end

  test 'input radio wraps the collection in the configured collection wrapper tag' do
    swap SimpleForm, collection_wrapper_tag: :ul do
      with_input_for @user, :active, :radio_buttons

      assert_select 'form ul input[type=radio]', count: 2
    end
  end

  test 'input radio does not wrap the collection when configured with falsy values' do
    swap SimpleForm, collection_wrapper_tag: false do
      with_input_for @user, :active, :radio_buttons

      assert_select 'form input[type=radio]', count: 2
      assert_no_select 'form ul'
    end
  end

  test 'input radio allows overriding the collection wrapper tag at input level' do
    swap SimpleForm, collection_wrapper_tag: :ul do
      with_input_for @user, :active, :radio_buttons, collection_wrapper_tag: :section

      assert_select 'form section input[type=radio]', count: 2
      assert_no_select 'form ul'
    end
  end

  test 'input radio allows disabling the collection wrapper tag at input level' do
    swap SimpleForm, collection_wrapper_tag: :ul do
      with_input_for @user, :active, :radio_buttons, collection_wrapper_tag: false

      assert_select 'form input[type=radio]', count: 2
      assert_no_select 'form ul'
    end
  end

  test 'input radio renders the wrapper tag with the configured wrapper class' do
    swap SimpleForm, collection_wrapper_tag: :ul, collection_wrapper_class: 'inputs-list' do
      with_input_for @user, :active, :radio_buttons

      assert_select 'form ul.inputs-list input[type=radio]', count: 2
    end
  end

  test 'input radio allows giving wrapper class at input level only' do
    swap SimpleForm, collection_wrapper_tag: :ul do
      with_input_for @user, :active, :radio_buttons, collection_wrapper_class: 'items-list'

      assert_select 'form ul.items-list input[type=radio]', count: 2
    end
  end

  test 'input radio uses both configured and given wrapper classes for wrapper tag' do
    swap SimpleForm, collection_wrapper_tag: :ul, collection_wrapper_class: 'inputs-list' do
      with_input_for @user, :active, :radio_buttons, collection_wrapper_class: 'items-list'

      assert_select 'form ul.inputs-list.items-list input[type=radio]', count: 2
    end
  end

  test 'input radio wraps each item in the configured item wrapper tag' do
    swap SimpleForm, item_wrapper_tag: :li do
      with_input_for @user, :active, :radio_buttons

      assert_select 'form li input[type=radio]', count: 2
    end
  end

  test 'input radio does not wrap items when configured with falsy values' do
    swap SimpleForm, item_wrapper_tag: false do
      with_input_for @user, :active, :radio_buttons

      assert_select 'form input[type=radio]', count: 2
      assert_no_select 'form li'
    end
  end

  test 'input radio allows overriding the item wrapper tag at input level' do
    swap SimpleForm, item_wrapper_tag: :li do
      with_input_for @user, :active, :radio_buttons, item_wrapper_tag: :dl

      assert_select 'form dl input[type=radio]', count: 2
      assert_no_select 'form li'
    end
  end

  test 'input radio allows disabling the item wrapper tag at input level' do
    swap SimpleForm, item_wrapper_tag: :ul do
      with_input_for @user, :active, :radio_buttons, item_wrapper_tag: false

      assert_select 'form input[type=radio]', count: 2
      assert_no_select 'form li'
    end
  end

  test 'input radio wraps items in a span tag by default' do
    with_input_for @user, :active, :radio_buttons

    assert_select 'form span input[type=radio]', count: 2
  end

  test 'input radio renders the item wrapper tag with a default class "radio"' do
    with_input_for @user, :active, :radio_buttons, item_wrapper_tag: :li

    assert_select 'form li.radio input[type=radio]', count: 2
  end

  test 'input radio renders the item wrapper tag with the configured item wrapper class' do
    swap SimpleForm, item_wrapper_tag: :li, item_wrapper_class: 'item' do
      with_input_for @user, :active, :radio_buttons

      assert_select 'form li.radio.item input[type=radio]', count: 2
    end
  end

  test 'input radio allows giving item wrapper class at input level only' do
    swap SimpleForm, item_wrapper_tag: :li do
      with_input_for @user, :active, :radio_buttons, item_wrapper_class: 'item'

      assert_select 'form li.radio.item input[type=radio]', count: 2
    end
  end

  test 'input radio uses both configured and given item wrapper classes for item wrapper tag' do
    swap SimpleForm, item_wrapper_tag: :li, item_wrapper_class: 'item' do
      with_input_for @user, :active, :radio_buttons, item_wrapper_class: 'inline'

      assert_select 'form li.radio.item.inline input[type=radio]', count: 2
    end
  end

  test 'input radio respects the nested boolean style config, generating nested label > input' do
    swap SimpleForm, boolean_style: :nested do
      with_input_for @user, :active, :radio_buttons

      assert_select 'span.radio > label > input#user_active_true[type=radio]'
      assert_select 'span.radio > label', 'Yes'
      assert_select 'span.radio > label > input#user_active_false[type=radio]'
      assert_select 'span.radio > label', 'No'
      assert_no_select 'label.collection_radio_buttons'
    end
  end

  test 'input radio with nested style does not overrides configured item wrapper tag' do
    swap SimpleForm, boolean_style: :nested, item_wrapper_tag: :li do
      with_input_for @user, :active, :radio_buttons

      assert_select 'li.radio > label > input'
    end
  end

  test 'input radio with nested style does not overrides given item wrapper tag' do
    swap SimpleForm, boolean_style: :nested do
      with_input_for @user, :active, :radio_buttons, item_wrapper_tag: :li

      assert_select 'li.radio > label > input'
    end
  end

  test 'input radio with nested style accepts giving extra wrapper classes' do
    swap SimpleForm, boolean_style: :nested do
      with_input_for @user, :active, :radio_buttons, item_wrapper_class: "inline"

      assert_select 'span.radio.inline > label > input'
    end
  end

  test 'input radio wrapper class are not included when set to falsey' do
    swap SimpleForm, include_default_input_wrapper_class: false, boolean_style: :nested do
      with_input_for @user, :gender, :radio_buttons, collection: [:male, :female]

      assert_no_select 'label.radio'
    end
  end

  test 'input check boxes custom wrapper class is included when include input wrapper class is falsey' do
    swap SimpleForm, include_default_input_wrapper_class: false, boolean_style: :nested do
      with_input_for @user, :gender, :radio_buttons, collection: [:male, :female], item_wrapper_class: 'custom'

      assert_no_select 'label.radio'
      assert_select 'span.custom'
    end
  end
end
