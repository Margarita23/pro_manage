require 'rails_helper'

RSpec.describe Project, type: :model do

	let(:project) { create(:project, title: "Landing Photo", description: "A project for landing page photo") }
	let(:project_without_title) { attributes_for(:project, title: nil, description: "A project for landing page photo") }

	describe 'associations' do
    it { should have_many(:tasks).dependent(:destroy) }
  end

	describe 'validations' do
		it { should validate_presence_of(:title) }
	end

end
