require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  def setup
    Doi.create(id: 1, name: "doi-name-ph")
    @url = Url.new(url: "url-ph", doi_id: 1)
  end

  test "save valid url" do
    assert @url.save, "didn't save"
  end

  test "save url with no existing doi" do
    @url.doi_id = 0
    assert_not @url.save, "saved"
  end
end
