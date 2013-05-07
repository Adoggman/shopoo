class ApplicationController < ActionController::Base
  protect_from_forgery
  # we need the methods from this helper available to all views,
  # so we include it in the application_controller
  include SessionsHelper
  require 'will_paginate/array'
end
