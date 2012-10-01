require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "fail to create without name" do
    p = Profile.create
    assert !p.save
  end

  test "fail to create without globe FK" do
    p = Profile.create(:name => "Test")
    assert !p.save
  end

  test "create with globe FK and name" do
    g = Globe.create(:name => "Test", :globe_reference => "test")
    p = Profile.create(:name => "Test", :globe_id => g.id)
    assert p.save
  end

end
