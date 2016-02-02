require 'test_helper'

class ReminderTest < ActiveSupport::TestCase
  test "Model should be saved, since it has complete title and color." do
    annoyer = Annoyer.find(annoyers(:one))
    reminder = Reminder.new title: "This is the Title", frequency: 2, repeat: "Month", annoyer_id: annoyer.id
    assert reminder.save, "saved with completed values."
  end

  test "Model shouldn't be saved, since the Title is missing" do
    annoyer = Annoyer.find(annoyers(:one))
    reminder = Reminder.new frequency: 2, repeat: "Month", annoyer_id: annoyer.id
    assert !reminder.save, "shouldn't be saved, since Title is missing."
  end

  test "Model shouldn't be saved, since the frequency is missing" do
    annoyer = Annoyer.find(annoyers(:one))
    reminder = Reminder.new title: "This is the Title", repeat: "Month", annoyer_id: annoyer.id
    assert !reminder.save, "shouldn't be saved, since Title is missing."
  end

  test "Model shouldn't be saved, since the repeat is missing" do
    annoyer = Annoyer.find(annoyers(:one))
    reminder = Reminder.new title: "This is the Title", frequency: 2, annoyer_id: annoyer.id
    assert !reminder.save, "shouldn't be saved, since repeat is missing."
  end

  test "Model shouldn't be saved, since annoyer_id is missing." do
    annoyer = Annoyer.find(annoyers(:one))
    reminder = Reminder.new title: "This is the Title", frequency: 2, repeat: "Month"
    assert !reminder.save, "shouldn't be saved, since the annoyer_id is missing."
  end

  test "Model shouldn't be saved, since the Title is too short." do
    annoyer = Annoyer.find(annoyers(:one))
    reminder = Reminder.new title: "This", frequency: 2, repeat: "Month", annoyer_id: annoyer.id
    assert !reminder.save, "shouldn't be saved, since the Title is too short."
  end

  test "Model shouldn't be saved, since the frequency's value is too low" do
    annoyer = Annoyer.find(annoyers(:one))
    reminder = Reminder.new title: "This is the Title", frequency: 0, repeat: "Month", annoyer_id: annoyer.id
    assert !reminder.save, "shouldn't be saved, since the frequency's value is too low."
  end

  test "Model shouldn't be saved, since the repeat's value is not Day, Week, Month or Year" do
    annoyer = Annoyer.find(annoyers(:one))
    reminder = Reminder.new title: "This is the Title", frequency: 1, repeat: "month", annoyer_id: annoyer.id
    assert !reminder.save, "shouldn't be saved, since the repeat's value is not Day, Week, Month or Year."
  end

  test "Model should be updated, since all values are fullfilled" do
    #
    # Start Preparation
    #
    annoyer = Annoyer.find(annoyers(:one))
    prep_reminder = Reminder.find(reminders(:one))
    prep_reminder.update title: "This is the Title", frequency: 1, repeat: "Month", annoyer_id: annoyer.id
    #find again after update, for new instance
    updated_reminder = Reminder.find(nodes(:one))
    #
    # End Preparation
    #
    assert_equal prep_reminder.title, updated_reminder.title, "Should be updated, since title for preparation is ok."
    assert_equal prep_reminder.frequency, updated_reminder.frequency, "Should be updated, since frequency for preparation is ok."
    assert_equal prep_reminder.repeat, updated_reminder.repeat, "Should be updated, since repeat for preparation is ok."

    updated_annoyer = Annoyer.find(annoyers(:one))
    assert_equal updated_reminder.annoyer_id, updated_annoyer.id, "Should be updated, since, all other values where completed."
  end

  test "Model shouldn't be updated, since the Title is too short." do
    #
    # Start Preparation
    #
    annoyer = Annoyer.find(annoyers(:one))
    prep_reminder = Reminder.find(reminders(:one))
    prep_reminder.update title: "This is the Title", frequency: 1, repeat: "Month", annoyer_id: annoyer.id
    #find again after update, for new instance
    updated_reminder = Reminder.find(reminders(:one))
    assert_equal prep_reminder.title, updated_reminder.title, "Should be updated, since title for preparation is ok."
    #
    # End Preparation
    #
    assert !updated_reminder.update(title: "This", frequency: 2, repeat: "Week", annoyer_id: annoyer.id), "Shouldn't update, since the Title is too short"

    updated_reminder = Reminder.find(reminders(:one))

    assert_not_equal updated_reminder.title, "This", "Title should not be the same, since Model wasn't updated."
    assert_equal updated_reminder.title, "This is the Title", "Title should not be the same, since Model wasn't updated."

    assert_not_equal updated_reminder.frequency, 2, "frequency should not be the same, since Model wasn't updated."
    assert_equal updated_reminder.frequency, 1, "frequency should not be the same, since Model wasn't updated."

    assert_not_equal updated_reminder.repeat, "Week", "repeat should not be the same, since Model wasn't updated."
    assert_equal updated_reminder.repeat, "Month", "repeat should not be the same, since Model wasn't updated."
  end

  test "Model shouldn't be updated, since the frequency's value is too low." do
    #
    # Start Preparation
    #
    annoyer = Annoyer.find(annoyers(:one))
    prep_reminder = Reminder.find(reminders(:one))
    prep_reminder.update title: "This is the Title", frequency: 1, repeat: "Month", annoyer_id: annoyer.id
    #find again after update, for new instance
    updated_reminder = Reminder.find(reminders(:one))
    assert_equal prep_reminder.title, updated_reminder.title, "Should be updated, since title for preparation is ok."
    #
    # End Preparation
    #
    assert !updated_reminder.update(title: "This is another Title", frequency: 0, repeat: "Week", annoyer_id: annoyer.id), "Shouldn't update, since the Title is too short"

    updated_reminder = Reminder.find(reminders(:one))

    assert_not_equal updated_reminder.title, "This is another Title", "Title should not be the same, since Model wasn't updated."
    assert_equal updated_reminder.title, "This is the Title", "Title should not be the same, since Model wasn't updated."

    assert_not_equal updated_reminder.frequency, 0, "frequency should not be the same, since Model wasn't updated."
    assert_equal updated_reminder.frequency, 1, "frequency should not be the same, since Model wasn't updated."

    assert_not_equal updated_reminder.repeat, "Week", "repeat should not be the same, since Model wasn't updated."
    assert_equal updated_reminder.repeat, "Month", "repeat should not be the same, since Model wasn't updated."
  end

  test "Model shouldn't be updated, since the repeat's value is not valid." do
    #
    # Start Prepatation
    #
    annoyer = Annoyer.find(annoyers(:one))
    prep_reminder = Reminder.find(reminders(:one))
    prep_reminder.update title: "This is the Title", frequency: 1, repeat: "Month", annoyer_id: annoyer.id
    #find again after update, for new instance
    updated_reminder = Reminder.find(reminders(:one))
    assert_equal prep_reminder.title, updated_reminder.title, "Should be updated, since title for preparation is ok."
    #
    # End Prepatation
    #
    assert !updated_reminder.update(title: "This is another Title", frequency: 0, repeat: "week", annoyer_id: annoyer.id), "Shouldn't update, since the Title is too short"

    updated_reminder = Reminder.find(reminders(:one))

    assert_not_equal updated_reminder.title, "This is another Title", "Title should not be the same, since Model wasn't updated."
    assert_equal updated_reminder.title, "This is the Title", "Title should not be the same, since Model wasn't updated."

    assert_not_equal updated_reminder.frequency, 0, "frequency should not be the same, since Model wasn't updated."
    assert_equal updated_reminder.frequency, 1, "frequency should not be the same, since Model wasn't updated."

    assert_not_equal updated_reminder.repeat, "week", "repeat should not be the same, since Model wasn't updated."
    assert_equal updated_reminder.repeat, "Month", "repeat should not be the same, since Model wasn't updated."
  end
end
