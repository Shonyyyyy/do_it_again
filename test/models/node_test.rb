require 'test_helper'

class NodeTest < ActiveSupport::TestCase
  test "Model should be saved, since all values are fullfilled." do
    annoyer = Annoyer.find(annoyers(:one).id)
    node = Node.new title: "This is the Title", content: "This is the Content", annoyer_id: annoyer.id
    assert node.save, "Should be saved, since all values are completly fullfilled."

    test_annoyer = Annoyer.find(node.annoyer_id)

    assert_equal test_annoyer.title, annoyer.title, "Title of both annoyers should be the same."
    assert_equal test_annoyer.color, annoyer.color, "Color of both annoyers should be the same."
  end

  test "Model should not be saved, since title is missing." do
    annoyer = Annoyer.find(annoyers(:one).id)
    node = Node.new content: "This is the Content", annoyer_id: annoyer.id
    assert !node.save, "Shouldn't be saved, since title is missing."
  end

  test "Model should not be saved, since content is missing." do
    annoyer = Annoyer.find(annoyers(:one).id)
    node = Node.new title: "This is the Title", annoyer_id: annoyer.id
    assert !node.save, "Shouldn't be saved, since content is missing."
  end

  test "Model should not be saved, since annoyer_id is missing." do
    annoyer = Annoyer.find(annoyers(:one).id)
    node = Node.new title: "This is the Title", content: "This is the Content"
    assert !node.save, "Shouldn't be saved, since annoyer_id is missing."
  end

  test "Model should not be saved, since title is too short." do
    annoyer = Annoyer.find(annoyers(:one).id)
    node = Node.new title: "This", content: "This is the Content", annoyer_id: annoyer.id
    assert !node.save, "Shouldn't be saved, since title is too short."
  end

  test "Model should not be saved, since content is too short." do
    annoyer = Annoyer.find(annoyers(:one).id)
    node = Node.new title: "This is the Title", content: "This", annoyer_id: annoyer.id
    assert !node.save, "Shouldn't be saved, since content is too short."
  end

  test "Model should be updated." do
    annoyer = Annoyer.find(annoyers(:one).id)
    prep_node = Node.find(nodes(:one).id)
    prep_node.update title: "This is the Title", content: "This is the Content", annoyer_id: annoyer.id

    updated_node = Node.find(nodes(:one).id)

    assert_equal updated_node.title, "This is the Title", "Title should have been the updated one."
    assert_equal updated_node.content, "This is the Content", "Content should have been the updated one."

    annoyer_from_updated_node = Annoyer.find(updated_node.annoyer_id)

    assert_equal annoyer.title, annoyer_from_updated_node.title, "Titles of annoyers should be the same."
  end

  test "Model shouldn't be updated, since title is too short" do
    annoyer = Annoyer.find(annoyers(:one).id)
    prep_node = Node.find(nodes(:one).id)
    prep_node.update title: "This is the Title", content: "This is the Content", annoyer_id: annoyer.id

    #find again after update, for new instance
    updated_node = Node.find(nodes(:one).id)

    assert_equal prep_node.title, updated_node.title, "Should be updated, since title for preparation is ok."

    assert !updated_node.update(title: "This", content: "This is a new Content", annoyer_id: annoyer.id), "Shouldn't update, since title is too short."

    #find updated_node again, after update
    updated_node = Node.find(nodes(:one).id)

    assert_not_equal updated_node.title, "This", "Title shouldn't be the same, since Model wasn't updated."
    assert_not_equal updated_node.content, "This is a new Content", "Content shouldn't be the same, since Model wasn't updated."

    assert_equal updated_node.title, "This is the Title", "Should not fail, since model wasn't updated."
    assert_equal updated_node.content, "This is the Content", "Should not fail, since model wasn't updated."
  end

  test "Model shouldn't be updated, since content is too short" do
    annoyer = Annoyer.find(annoyers(:one).id)
    prep_node = Node.find(nodes(:one).id)
    prep_node.update title: "This is the Title", content: "This is the Content", annoyer_id: annoyer.id

    #find again after update, for new instance
    updated_node = Node.find(nodes(:one).id)

    assert_equal prep_node.title, updated_node.title, "Should be updated, since title for preparation is ok."

    assert !updated_node.update(title: "This is a new Title", content: "This", annoyer_id: annoyer.id), "Shouldn't update, since title is too short."

    #find updated_node again, after update
    updated_node = Node.find(nodes(:one).id)

    assert_not_equal updated_node.title, "This is a new Title", "Title shouldn't be the same, since Model wasn't updated."
    assert_not_equal updated_node.content, "This", "Content shouldn't be the same, since Model wasn't updated."

    assert_equal updated_node.title, "This is the Title", "Should not fail, since model wasn't updated."
    assert_equal updated_node.content, "This is the Content", "Should not fail, since model wasn't updated."
  end

end
