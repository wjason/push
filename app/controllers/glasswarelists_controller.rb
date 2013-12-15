class GlasswarelistsController < ApplicationController
  def index
    @glasswares = Manager.all
  end
end
