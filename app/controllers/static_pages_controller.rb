class StaticPagesController < ApplicationController

  layout "home", only: [:home]

  def home
    @locations = Location.all
  end

  def about
  end

  def contact
  end

  def legal
  end

end
