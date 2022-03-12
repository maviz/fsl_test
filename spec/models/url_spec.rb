# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
    it 'validates original URL is a valid URL' do
      url = Url.new
      url.original_url= 'xxx'
      expect(url.save).to eq(false)

      url.original_url = 'https://www.google.com'
      expect(url.save).to eq(true)      
    end


    it 'validates short URL is present' do
      url = Url.new
      url.original_url = 'https://test.com'
      url.save
      expect(url.short_url).not_to eq(nil)
      expect(url.short_url.length).to eq(5)
      special = "?<>',?[]}{=-)(*&^%$#`~{}"
      regex = /[#{special.gsub(/./){|char| "\\#{char}"}}]/
      expect(url.short_url =~ regex).to eq(nil)
    end

    # add more tests
  end
end
