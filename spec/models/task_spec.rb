require 'rails_helper'

RSpec.describe Task, type: :model do

	let(:task) { create(:task) }

	describe 'associations' do
    it { should belong_to(:project) }
  end

	describe 'validations' do
		it { should validate_presence_of(:title) }
    it { should define_enum_for(:status).with_values(created: 0, in_progress: 1, completed: 2) }
	end

end
