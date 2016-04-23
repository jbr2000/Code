class DoiServerController < ApplicationController
  before_action :setup, only: [:index, :home]
  def setup
    @dois = Doi.all
    @urls = Url.all
  end
  def index
  end
  def home
  end
  def new
  end
  def doi 
    @doi = Doi.find_by name: params[:doi_name]
    if @doi
      @url = @doi.urls.last
      @urls = @doi.urls.order(:created_at)
    end
    session[:doi_id] = @doi.id
  end
  def create
    @doi = Doi.create(name: Time.now.strftime("%Y%m%d%H%M%S%L")+params[:name].to_s, description: params[:description])
    Url.create(url: params[:initial_url], doi_id: @doi.id)
    redirect_to(home_path)
  end
  def add_url
    unless params[:url].to_s.empty?
      Url.create(url: params[:url], doi_id: session[:doi_id])
    end
    redirect_to(:back)
  end
  def doi_history
    @doi = Doi.find(session[:doi_id])
  end
end
