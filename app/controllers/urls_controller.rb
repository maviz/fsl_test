# frozen_string_literal: true

class UrlsController < ApplicationController

  before_action :load_urls, before: [:index, :create]

  def index
    @url = Url.new
  end

  def create
    @url = Url.new(original_url: permitted_params[:original_url])
    if @url.save
      flash[:notice] = 'Created successfully'
      render :index
    else
      flash[:notice] = 'Creation failed!'
      render :index
    end
  end

  def show
    @daily_clicks =  Url.order(created_at: :desc).limit(10).map{|_| [_.short_url, _.clicks_count]}

    @browsers_clicks = Url.joins(:clicks).group("clicks.browser").select("clicks.browser as b_name, count(clicks.id) as total_c").map{|_| [_.b_name, _.total_c]}

    @platform_clicks = Url.joins(:clicks).group("clicks.platform").select("clicks.platform as b_name, count(clicks.id) as total_c").map{|_| [_.b_name, _.total_c]}
  end

  def visit
    # params[:short_url]

    @url = Url.find_by(short_url: params[:short_url])

    if @url.nil?
      render file:'public/404.html', status: :not_found
    else
      create_click
      redirect_to @url.original_url
    end
  end

  private

  def permitted_params
    params.require(:url).permit("original_url")
  end

  def load_urls
    @urls = Url.order(created_at: :desc).limit(10)
  end

  def create_click
    Click.create!(url_id: @url.id, browser: browser_name, platform: platform_name)
    @url.update(clicks_count: @url.clicks_count + 1)
  end

  def browser_name
    browser.name rescue 'N/A'
  end

  def platform_name
    browser.platform.name rescue 'N/A'
  end
end
