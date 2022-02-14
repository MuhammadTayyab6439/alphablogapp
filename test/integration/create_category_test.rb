# integration testing is for testing the whole feature for example in creation of category first we need
# to get new page then post request to create action then redirect it to category show page
#also check for admin
require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest


  setup do
    @admin_user = User.create(username: "johndoe", email: "johndoe@example.com",
                              password: "password", admin: true)
    sign_in_as(@admin_user)
  end



  test "get new category form and create category" do

    #get request of new 
    get "/categories/new"
    assert_response :success
    #to check category count is changed if category is created
    assert_difference 'Category.count', 1 do
      #for post action
      post categories_path, params: { category: { name: "Sports"} }
      assert_response :redirect
    end
    #to check the show page
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body

    #test for errors
  test "get new category form and reject invalid category submission" do
    #firt get new form 
    get "/categories/new"
    assert_response :success
    #check for empty name
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: " "} }
    end
    #match the errors
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  
  end
end
