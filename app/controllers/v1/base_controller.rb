class V1::BaseController < ApplicationController

  respond_to :json, :html

  skip_before_filter :verify_authenticity_token

  before_filter :find_one, :except => [:create, :index]
  before_filter :find, :only => [:index]
end