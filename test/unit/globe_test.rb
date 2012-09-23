require 'test_helper'

class GlobeTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "fail to create without name" do
    g = Globe.create
    assert !g.save
  end

  test "fail to create without globe reference" do
    g = Globe.create
    g.name = "test"
    assert !g.save
  end

  test "create with name and globe reference" do
    g = Globe.create
    g.name = "test"
    g.globe_reference = "test_reference"
    assert  g.save
  end

end
