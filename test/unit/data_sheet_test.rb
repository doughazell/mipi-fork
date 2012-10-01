require 'test_helper'

class DataSheetTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "fail to create without name" do
    ds = DataSheet.create
    assert !ds.save
  end

  test "fail to create without Profile FK" do
    g = Globe.create(:name => "Test", :globe_reference => "test")
    p = Profile.create(:name => "Test", :globe_id => g.id)
    ds = DataSheet.create(:profile_id => p.id)
    assert !ds.save
  end

end
