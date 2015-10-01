# encoding: utf-8
require 'wst/post'
require 'wst/page'

module Wst
  class Contents
    def initialize
      @all = all_contents
    end

    # Get all contents
    # @param [Boolean] show_non_publised Get all contents or only published
    # @return [Array<Content>] Contents
    def all(show_non_published = false)
      return @all if show_non_published
      @all.select { |c| c.published }
    end

    private
    # Get all contents, publised or not
    # @return [Array<Content>] Contents
    def all_contents
      [Page.all, Post.all].flatten
    end
  end
end
