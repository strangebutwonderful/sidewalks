require "test_helper"

class FaviconsTest < ActionDispatch::IntegrationTest
  test "Favicons are rendered with no suffix by default" do
    ClimateControl.modify FAVICON_FILE_NAME_SUFFIX: "" do
      visit root_path
      page.find "link[href=\"/favicon.ico\"]", visible: false
      page.find "link[href=\"/favicon-76x76.png\"]", visible: false
      page.find "link[href=\"/favicon-120x120.png\"]", visible: false
      page.find "link[href=\"/favicon-152x152.png\"]", visible: false
      page.find "link[href=\"/favicon-196x196.png\"]", visible: false
    end
  end

  test "Favicons are rendered with a suffix when specified" do
    ClimateControl.modify FAVICON_FILE_NAME_SUFFIX: "-test" do
      visit root_path
      page.find "link[href=\"/favicon-test.ico\"]", visible: false
      page.find "link[href=\"/favicon-test-76x76.png\"]", visible: false
      page.find "link[href=\"/favicon-test-120x120.png\"]", visible: false
      page.find "link[href=\"/favicon-test-152x152.png\"]", visible: false
      page.find "link[href=\"/favicon-test-196x196.png\"]", visible: false
    end
  end
end
