require File.dirname(__FILE__) + '/../test_helper'

class DefaultPagePartsExtensionTest < Test::Unit::TestCase
  
  # Replace this with your real tests.
  def test_this_extension
    flunk
  end
  
  def test_initialization
    assert_equal File.join(File.expand_path(RAILS_ROOT), 'vendor', 'extensions', 'default_page_parts'), DefaultPagePartsExtension.root
    assert_equal 'Default Page Parts', DefaultPagePartsExtension.extension_name
  end
  
end
