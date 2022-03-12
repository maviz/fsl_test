# frozen_string_literal: true

class Url < ApplicationRecord
  # scope :latest, -> {}

  CHARS = [('A'..'Z').to_a,(0..9).to_a].flatten
  has_many :clicks

  validates :short_url, presence: true, uniqueness: true
  validates :original_url, presence: true

  validates_format_of :original_url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix, multiline: true

  before_validation :generate_short_code

  private

  def generate_short_code(code = nil)
    code ||= ''
    code = code + (CHARS[rand(0..CHARS.length-1)]).to_s 
    return assign_code(code) if code.length == 5
    generate_short_code(code)
  end

  def assign_code(code)
    return generate_short_code unless Url.find_by(short_url: code).nil?
    self.short_url = code
  end


end
