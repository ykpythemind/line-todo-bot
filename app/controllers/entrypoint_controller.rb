class EntrypointController < ApplicationController
  def index
    puts "yeah"
    render plain: "piyopiyo"
  end
end
