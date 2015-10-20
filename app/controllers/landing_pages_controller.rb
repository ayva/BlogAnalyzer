class LandingPagesController < ApplicationController
  require 'grammarly'
  include GrammarCheck



  def test

    text="I am eephant"
    @data = check_errors(text)

  end

  def main

  end


end
