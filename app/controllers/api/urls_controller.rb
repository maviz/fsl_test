# frozen_string_literal: true

class Api::UrlsController < ApplicationController

  def index
    @urls = Url.order(created_at: :desc).limit(10)
    render jsonapi: @urls,status: :found
  end

end
