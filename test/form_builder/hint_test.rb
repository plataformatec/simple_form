require 'test_helper'

# Tests for f.hint
class HintTest < ActionView::TestCase
  def with_hint_for(object, *args)
    with_concat_form_for(object) do |f|
      f.hint(*args)
    end
  end

  test 'hint should not be generated by default' do
    with_hint_for @user, :name
    assert_no_select 'span.hint'
  end

  test 'hint should be generated with optional text' do
    with_hint_for @user, :name, :hint => 'Use with care...'
    assert_select 'span.hint', 'Use with care...'
  end

  test 'hint should not modify the options hash' do
    options = { :hint => 'Use with care...' }
    with_hint_for @user, :name, options
    assert_select 'span.hint', 'Use with care...'
    assert_equal({ :hint => 'Use with care...' }, options)
  end

  test 'hint should be generated cleanly with optional text' do
    with_hint_for @user, :name, :hint => 'Use with care...', :hint_tag => :span
    assert_no_select 'span.hint[hint]'
    assert_no_select 'span.hint[hint_tag]'
    assert_no_select 'span.hint[hint_html]'
  end

  test 'hint uses the current component tag set' do
    with_hint_for @user, :name, :hint => 'Use with care...', :hint_tag => :p
    assert_select 'p.hint', 'Use with care...'
  end

  test 'hint should be able to pass html options' do
    with_hint_for @user, :name, :hint => 'Yay!', :id => 'hint', :class => 'yay'
    assert_select 'span#hint.hint.yay'
  end

  test 'hint should be output as html_safe' do
    with_hint_for @user, :name, :hint => '<b>Bold</b> and not...'.html_safe
    assert_select 'span.hint', 'Bold and not...'
    assert_select 'span.hint b', 'Bold'
  end

  test 'builder should escape hint text' do
    with_hint_for @user, :name, :hint => '<script>alert(1337)</script>'
    assert_select 'span.hint', "&lt;script&gt;alert(1337)&lt;/script&gt;"
  end

  # Without attribute name

  test 'hint without attribute name' do
    with_hint_for @validating_user, 'Hello World!'
    assert_select 'span.hint', 'Hello World!'
  end

  test 'hint without attribute name should generate component tag with a clean HTML' do
    with_hint_for @validating_user, 'Hello World!'
    assert_no_select 'span.hint[hint]'
    assert_no_select 'span.hint[hint_html]'
  end

  test 'hint without attribute name uses the current component tag set' do
    with_hint_for @user, 'Hello World!', :hint_tag => :p
    assert_no_select 'p.hint[hint]'
    assert_no_select 'p.hint[hint_html]'
    assert_no_select 'p.hint[hint_tag]'
  end

  test 'hint without attribute name should be able to pass html options' do
    with_hint_for @user, 'Yay', :id => 'hint', :class => 'yay'
    assert_select 'span#hint.hint.yay', 'Yay'
  end

  # I18n

  test 'hint should use i18n based on model, action, and attribute to lookup translation' do
    store_translations(:en, :simple_form => { :hints => { :user => {
      :edit => { :name => 'Content of this input will be truncated...' }
    } } }) do
      with_hint_for @user, :name
      assert_select 'span.hint', 'Content of this input will be truncated...'
    end
  end

  test 'hint should use i18n with model and attribute to lookup translation' do
    store_translations(:en, :simple_form => { :hints => { :user => {
      :name => 'Content of this input will be capitalized...'
    } } }) do
      with_hint_for @user, :name
      assert_select 'span.hint', 'Content of this input will be capitalized...'
    end
  end

  test 'hint should use i18n under defaults namespace to lookup translation' do
    store_translations(:en, :simple_form => {
      :hints => {:defaults => {:name => 'Content of this input will be downcased...' } }
    }) do
      with_hint_for @user, :name
      assert_select 'span.hint', 'Content of this input will be downcased...'
    end
  end

  test 'hint should use i18n with lookup for association name' do
    store_translations(:en, :simple_form => { :hints => {
      :user => { :company => 'My company!' }
    } } ) do
      with_hint_for @user, :company_id, :as => :string, :reflection => Association.new(Company, :company, {})
      assert_select 'span.hint', /My company!/
    end
  end

  test 'hint should output translations as html_safe' do
    store_translations(:en, :simple_form => { :hints => { :user => {
      :edit => { :name => '<b>This is bold</b> and this is not...' }
    } } }) do
      with_hint_for @user, :name
      assert_select 'span.hint', 'This is bold and this is not...'
    end
  end


  # No object

  test 'hint should generate properly when object is not present' do
    with_hint_for :project, :name, :hint => 'Test without object'
    assert_select 'span.hint', 'Test without object'
  end

  # Custom wrappers

  test 'hint with custom wrappers works' do
    swap_wrapper do
      with_hint_for @user, :name, :hint => "can't be blank"
      assert_select 'div.omg_hint', "can&#x27;t be blank"
    end
  end

  test 'optional hint displays when given' do
    swap_wrapper :default, self.custom_wrapper_with_optional_div do
      with_form_for @user, :name, hint: "can't be blank"
      assert_select 'section.custom_wrapper div.no_output_wrapper p.omg_hint', "can&#39;t be blank"
      assert_select 'p.omg_hint'
    end
  end

  test 'optional hint displays empty wrapper when no hint given' do
    swap_wrapper :default, self.custom_wrapper_with_optional_div do
      with_form_for @user, :name
      assert_select 'section.custom_wrapper div.no_output_wrapper'
      assert_no_select 'p.omg_hint'
    end
  end

  test 'optional hint displays no wrapper or hint when no hint and override is given' do
    swap_wrapper :default, self.custom_wrapper_with_optional_div_and_override do
      with_form_for @user, :name
      assert_no_select 'section.custom_wrapper div.no_output_wrapper'
      assert_no_select 'div.no_output_wrapper'
      assert_no_select 'p.omg_hint'
    end
  end
end
