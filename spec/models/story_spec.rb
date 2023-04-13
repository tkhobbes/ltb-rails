require 'rails_helper'

RSpec.describe Story do
  describe 'validations and database constraints' do
    context 'database constraints' do
      it 'is not valid if the code is blank' do
        story = Story.new(title: 'abc', published: 1961)
        expect(story).not_to be_valid
      end

      it 'is valid if the code is given' do
        story = Story.new(code: '123')
        expect(story).to be_valid
      end

      it 'cannot have two stories with the same code' do
        s = create(:story)
        story = Story.new(code: s.code)
        expect(story).not_to be_valid
      end
    end
  end
end
