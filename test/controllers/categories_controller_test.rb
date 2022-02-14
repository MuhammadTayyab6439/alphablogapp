#$ rails generate test_unit:scaffold category
#functional testing is for all controller actions
require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Sports")
    @admin_user = User.create(username: "johndoe", email: "johndoe@example.com",
    password: "password", admin: true)
  end
#get index request url and check response
  test "should get index" do
    get categories_url
    assert_response :success
  end
#get new request url and check response
  test "should get new" do
    #check if sign in as admin then go to new
    sign_in_as(@admin_user)
    get new_category_url
    assert_response :success
  end

   test "should create category" do
    #check sign in as admin then create
    sign_in_as(@admin_user)
    #check for count if obj created then count change to 2
     assert_difference('Category.count',1) do
      #post request to create category providing category name
      post categories_url, params: { category: {name:"travel" } }
     end
     #show the latest category created
     assert_redirected_to category_url(Category.last)
   end

   #test for admin if not then should'nt create category
   test "should not create category if not admin" do
    assert_no_difference('Category.count') do
      post categories_url, params: { category: { name: "Travel" } }
    end

    assert_redirected_to categories_url
  end

#get show request url and check for response
  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  # test "should get edit" do
  #   get edit_category_url(@category)
  #   assert_response :success
  # end

  # test "should update category" do
  #   patch category_url(@category), params: { category: {  } }
  #   assert_redirected_to category_url(@category)
  # end

  # test "should destroy category" do
  #   assert_difference('Category.count', -1) do
  #     delete category_url(@category)
  #   end

  #   assert_redirected_to categories_url
  # end
end

