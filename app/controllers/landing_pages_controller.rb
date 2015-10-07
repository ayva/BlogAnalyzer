class LandingPagesController < ApplicationController
  require 'grammarly'
  include GrammarCheck



  def test

    # text = "HTML5 added several new functional and semantic tags.The new semantic tags were added because the old HTML4 standard basically assumed that each page was a single entity about a single topic. In the real world, that's just not true so it makes sense to divvy up the page according to which sections and pieces of it mean different things.This is useful to you the developer because it allows you to write markup for subsections of the page independently from the enclosing document (allowing easy re-use). It's useful to users with accessibility needs and search engines because it helps them parse the meaning of each part of the page more effectively."

      # @data =  check_errors(text)

      # !!!Example how to twit in Grandma's timeline!!!
      # t = TwitterAPI.new
      # t.twit("Cheking grammar today...")


  end

  def main

  end


end
