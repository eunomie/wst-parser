# encoding: utf-8
require 'wst/post'
require 'wst/page'

module Wst
  class Contents
    def initialize
      @posts = Post.all
      @pages = Page.all
      @all = [@posts, @pages].flatten
    end

    # Get all contents
    # @param [Boolean] show_non_published Get all contents or only published
    # @return [Array<Content>] Contents
    def all(show_non_published = false)
      get @all, show_non_published
    end

    # Get all pages
    # @param [Boolean] show_non_published Get all pages or only published
    # @return [Array<Content>] Contents
    def pages(show_non_published = false)
      get @pages, show_non_published
    end

    # Get all posts
    # @param [Boolean] show_non_published Get all posts or only published
    # @return [Array<Content>] Contents
    def posts(show_non_published = false)
      get @posts, show_non_published
    end

    private
    def get(contents, show_non_published)
      return contents if show_non_published
      contents.select { |c| c.published }
    end
  end
end
