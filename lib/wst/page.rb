# encoding: utf-8
require 'wst/md_content'
require 'wst/haml_content'
require 'cgi'

module Wst
  module PageComparison
    def <=> obj
      return content_url <=> obj.content_url
    end
  end

  class XmlPage < HamlContent
    include PageComparison

    @@matcher = /^(.+\/)*(.*)(\.xml\.haml)$/

    def initialize file_path
      super file_path

      m, cats, slug, ext = *file_path.match(@@matcher)
      base_path = File.join(Configuration.config['path'], '_pages') + '/'
      @cats = cats.gsub(base_path, '').chomp('/') if !cats.nil? && cats != base_path
      @slug = slug
      @ext = ext
    end

    def content_url
      "#{@cats + '/' if @cats != ''}#{CGI.escape @slug}.xml"
    end

    def self.matcher
      @@matcher
    end
  end

  class HamlPage < HamlContent
    include PageComparison

    @@matcher = /^(.+\/)*(.*)((?<!\.xml)\.[^.]+)$/

    def initialize file_path
      super file_path

      m, cats, slug, ext = *file_path.match(@@matcher)
      base_path = File.join(Configuration.config['path'], '_pages') + '/'
      @cats = cats.gsub(base_path, '').chomp('/') if !cats.nil? && cats != base_path
      @slug = slug
      @ext = ext
    end

    def content_url
      "#{@cats + '/' if @cats != ''}#{CGI.escape @slug}.html"
    end

    def self.matcher
      @@matcher
    end
  end

  class MdPage < MdContent
    include PageComparison

    def initialize file_path
      super file_path

      base_path = File.join(Configuration.config['path'], '_pages') + '/'
      @cats = @cats.gsub(base_path, '') if !@cats.nil?
      @cats.chomp!('/')
    end

    def content_url
      "#{@cats + '/' if @cats != ''}#{CGI.escape @slug}.html"
    end
  end

  class Page
    @@glob_xml = '*.xml.haml'
    @@glob_md = '*.{md,mkd,markdown}'
    @@glob_haml = '*.haml'

    class << self
      def all
        (xml_pages + haml_pages + md_pages).sort
      end

      private

      def xml_pages
        page_files(@@glob_xml, XmlPage.matcher).inject([]) { |pages, file| pages << XmlPage.new(file) }
      end

      def haml_pages
        page_files(@@glob_haml, HamlPage.matcher).inject([]) { |pages, file| pages << HamlPage.new(file) }
      end

      def md_pages
        page_files(@@glob_md, MdContent.matcher).inject([]) { |pages, file| pages << MdPage.new(file) }
      end

      def page_files glob, matcher
        select_match all_files(glob), matcher
      end

      def select_match files, matcher
        files.select { |file| file =~ matcher }
      end

      def all_files glob
        Dir.glob glob_path glob
      end

      def glob_path glob
        File.join "#{Configuration.config['path']}/_pages", '**', glob
      end
    end
  end
end
