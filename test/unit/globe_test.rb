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

  # Subdomains are used as the 'globe_reference' and they currently
  # do not support underscore characters. Ensure our globe rejects
  # any attempt to create an instance with an underscore.
  test "fail to create with name and underscored globe reference" do
    g = Globe.create
    g.name = "test"
    g.globe_reference = "test_reference"
    assert  !g.save
  end

  test "create with name and non-underscored globe reference" do
    g = Globe.create
    g.name = "test"
    g.globe_reference = "testreference"
    assert  g.save
  end

  test "globes by default are top level" do
    g = Globe.create
    g.name = "test"
    g.globe_reference = "testreference"
    g.save
    
    assert g.parent_id.nil?
  end
  
  test "check that duplicate names cannot be generated" do
    g = Globe.create
    g.name = "test"
    g.globe_reference = "testreference1"
    g.save

    g = Globe.create
    g.name = "test"
    g.globe_reference = "testreference2"
    assert !g.save
  end

  test "check that duplicate references cannot be generated" do
    g = Globe.create
    g.name = "test1"
    g.globe_reference = "testreference"
    g.save

    g = Globe.create
    g.name = "test2"
    g.globe_reference = "testreference"
    assert !g.save
  end

  test "child profiles are generated and attached" do
    g = Globe.create
    g.name = "test1"
    g.globe_reference = "testreference"
    g.save
    
    p = Profile.new
    p.name = "Profile Test"
    p.globe_id = g.id
    p.save
    
    assert g.profiles.count == 1, "One Profile created."
  end

  test "child profiles are generated and destroyed" do
    g = Globe.create
    g.name = "test1"
    g.globe_reference = "testreference"
    g.save
    
    p = Profile.new
    p.name = "Profile Test"
    p.globe_id = g.id
    p.save
    
    g.destroy
    
    assert Profile.where(:globe_id=>g.id).count == 0, Profile.where(:globe_id=>g.id).count.to_s + " profiles remain when all should be destroyed when associated globe is destroyed."
  end
end
