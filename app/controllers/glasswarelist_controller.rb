class GlasswarelistController < ApplicationController
  def index
    @glasswares = Manager.all
  end
end
