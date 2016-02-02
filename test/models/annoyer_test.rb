require 'test_helper'

class AnnoyerTest < ActiveSupport::TestCase
  test "Model should be saved, since it has complete title and color." do
    annoyer = Annoyer.new title: "Hello Test", color: "ffffff"
    assert annoyer.save, "saved with completed title and color."
  end

  test "Should not save model without title and color" do
    annoyer = Annoyer.new
    assert !annoyer.save, "not saved without a title or color."
  end

  test "Model should not be saved, since the title is missing" do
    annoyer = Annoyer.new color: "ffffff"
    assert !annoyer.save, "not saved, since the title is missing"
  end

  test "Model should not be saved, since the color is missing" do
    annoyer = Annoyer.new title: "Hello Test"
    assert !annoyer.save, "not saved, since the color is missing"
  end

  test "Model should not be saved, since the title is too short." do
    annoyer = Annoyer.new title: "Hell", color: "ffffff"
    assert !annoyer.save, "not saved, since title is too short."
  end

  test "Model should not be saved, since the color is too short." do
    annoyer = Annoyer.new title: "Hello Test", color:"fff"
    assert !annoyer.save, "not saved, since the color is too short"
  end

end
