# frozen_string_literal: true

class Click < ApplicationRecord
  belongs_to :url, required: true
  validates :platform, presence: true
  validates :browser, presence: true
end
