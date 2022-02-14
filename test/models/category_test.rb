#unit_testing is for models
require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  #this runs before every test case
    def setup
        @category = Category.new(name: "Sports")
      end
    #assert check for true
      test "category should be valid" do
        assert @category.valid?
      end
    #assert_not check for false
      test "name should be present" do
        @category.name = " "
        assert_not @category.valid?
      end
      #to check uniqueness first object should present at db so we save it
      test "name should be unique" do
        @category.save
        @category2 = Category.new(name: "Sports")
        assert_not @category2.valid?
      end
    
      test "name should not be too long" do
        @category.name = "a" * 26
        assert_not @category.valid?
      end
    
      test "name should not be too short" do
        @category.name = "aa"
        assert_not @category.valid?
      end
    
    end 

end 