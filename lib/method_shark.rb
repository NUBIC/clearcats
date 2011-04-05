#!/usr/bin/env ruby

# Print the complexity over time for a Ruby method in a
# git repository.
#
# Requires: >= bash ?.?
#           >= git 1.7.1
#           >= ruby 1.9.2
#           >= flog 2.5.0
#

require 'flog'
require 'time'

TEMP_FILE = "#{Rails.root}/tmp/methodshark_junk.rb"

class MethodShark

  class Reporter < ::StringIO
    def initialize(methodname)
      super()
      @detector = Regexp.new('\s+(\d+.\d+):\s+' + methodname)
    end

    def score
      Rails.logger.info("~~~ MethodShark :: string = [#{string}]")
      raw_scan = string.scan(@detector)
      text = raw_scan.flatten.first
      text ? Float(text) : 0.0
    end
  end

  def self.trail_for(filename, methodname)
    new(filename, methodname).generate_datestamped_complexities.sort
  end

  def initialize(filename, methodname)
    @filename = filename
    @methodname = methodname
  end

  def generate_datestamped_complexities
    # Bin-ing all commits on a date as we're just looking at trend
    complexities = {}
    sha1s_of_commits.each do |sha1|
      complexities[commit_date_of(sha1)] = complexity_of(sha1)
    end
    complexities
  end

  def commit_date_of(sha1)
    Time.parse(`git show -s --format=%cd #{sha1}`)
  end

  def complexity_of(sha1)
    `git show #{sha1}:#{@filename} > #{TEMP_FILE}`
    flogger = Flog.new({ :all => true })
    reporter = Reporter.new(@methodname)
    flogger.flog(TEMP_FILE)
    flogger.report(reporter)
    reporter.score
  end

  def sha1s_of_commits
    @sha1s ||= `git log #{@filename}| grep ^commit`.split(/\n/).map(&:split).map {|fields| fields[sha1_column = 1] }
  end
end

# if ARGV.size != 2
#   puts "help: methodshark <rubyfilename> <methodname>"
#   puts ""
#   puts "      Run in a git repository folder"
#   puts ""
#   puts "      Ex.  methodshark app/models/flubber.rb Foo#bar!"
#   puts "           methodshark app/models/flubber.rb no_foo?"
#   puts ""
#   exit
# end

# MethodShark.trail_for(ARGV[0], ARGV[1]).each do |date,complexity|
#   puts "#{date.strftime("%D")},#{complexity}"
# end

# fn = "lib/cos_scraper.rb"
# mn = "CosScraper#import_opportunities"
# MethodShark.trail_for(fn,mn).each { |dt,c| puts "#{dt.strftime('%D')}, #{c}" }