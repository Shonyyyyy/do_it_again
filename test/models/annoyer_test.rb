require 'test_helper'

class AnnoyerTest < ActiveSupport::TestCase
  test "Model should be saved, since it has complete title and color." do
    annoyer = Annoyer.new title: "Hello Test", color: "ffffff"
    assert annoyer.save, "saved with completed title and color."
  end

  test "Should not save model without title and color." do
    annoyer = Annoyer.new
    assert !annoyer.save, "not saved without a title or color."
  end

  test "Model should not be saved, since the title is missing." do
    annoyer = Annoyer.new color: "ffffff"
    assert !annoyer.save, "not saved, since the title is missing."
  end

  test "Model should not be saved, since the color is missing." do
    annoyer = Annoyer.new title: "Hello Test"
    assert !annoyer.save, "not saved, since the color is missing."
  end

  test "Model should not be saved, since the title is too short." do
    annoyer = Annoyer.new title: "Hell", color: "ffffff"
    assert !annoyer.save, "not saved, since title is too short."
  end

  test "Model should not be saved, since the color is too short." do
    annoyer = Annoyer.new title: "Hello Test", color:"fff"
    assert !annoyer.save, "not saved, since the color is too short."
  end

  test "Model should be updated." do
    annoyer = Annoyer.find(annoyers(:one).id)
    assert annoyer.update(title: "Hello World", color: "ffffff")

    assert_equal annoyer.title, "Hello World", "Title should be updated Title."
    assert_equal annoyer.color, "ffffff", "Color should be updated Color."

    assert_not_equal annoyer.title, "MyString", "Old vaule, should not be true."
    assert_not_equal annoyer.color, "000000", "Old Value, should not be true."
  end

  test "Model shouldn't be updated, title too short." do
    annoyer_fixtures = Annoyer.find(annoyers(:one).id)
    assert !annoyer_fixtures.update(title: "Hell", color: "ffffff"), "Not updated, since title is too short."

    assert_not_equal Annoyer.find(annoyers(:one).id).title, "Hell", "Title should not be updated since title is too short."
    assert_not_equal Annoyer.find(annoyers(:one).id).color, "ffffff", "Color should not be updated since model wasn't updated."

    assert_equal Annoyer.find(annoyers(:one).id).title, "MyString", "Old value, from not updated Model."
    assert_equal Annoyer.find(annoyers(:one).id).color, "000000", "Old value, from not updated Model."
  end

  test "Model shouldn't be updated, color too short." do
    annoyer_fixtures = Annoyer.find annoyers(:one).id
    assert !annoyer_fixtures.update(title: "Hello Test", color: "fff"), "Not updated, since title is too short."

    assert_not_equal Annoyer.find(annoyers(:one).id).title, "Hello Test", "title should not be updated since model wasn't updated."
    assert_not_equal Annoyer.find(annoyers(:one).id).color, "fff", "Color should not be updated since color is too short."

    assert_equal Annoyer.find(annoyers(:one).id).title, "MyString", "Old value, from not updated Model."
    assert_equal Annoyer.find(annoyers(:one).id).color, "000000", "Old value, from not updated Model."
  end
end
