# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Click, type: :model do
  describe 'validations' do
    it 'validates url_id is valid' do
      url = Url.create(original_url: 'https://test.com')
      cl = Click.new
      cl.browser = 'test'
      cl.platform = 'test'
      expect(cl.save).to eq(false)
      cl.url_id = url.id
      expect(cl.save).to eq(true)
    end

    it 'validates browser is not null' do
      url = Url.create!(original_url: 'https://www.test.com')
      cl = Click.new(platform: 'test', url_id: url.id)
      expect(cl.save).to eq(false)
      cl.browser = 'test'
      expect(cl.save).to eq(true)

    end

    it 'validates platform is not null' do
      url = Url.create!(original_url: 'https://www.test.com')
      cl = Click.new(browser: 'test', url_id: url.id)
      expect(cl.save).to eq(false)
      cl.platform = 'test'
      expect(cl.save).to eq(true)
    end
  end
end
