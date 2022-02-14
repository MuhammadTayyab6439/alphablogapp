require 'test_helper'

class IndexCategoryTest < ActionDispatch::IntegrationTest
  #first setup for creation of 2 category objects to display
   #(create) is use to hit db
  def setup
    @category = Category.create(name: "Sports")
    @category2 = Category.create(name: "Travel")
  end

  test "should show categories listing" do
    #get path
    get '/categories'
    #check category name and namelink for show page
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end
end
