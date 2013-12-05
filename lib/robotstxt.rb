#
# = Ruby Robotstxt
#
# An Ruby Robots.txt parser.
#
#
# Category::    Net
# Package::     Robotstxt
# Author::      Simone Rinzivillo <srinzivillo@gmail.com>
# License::     MIT License
#
#--
#
#++


require 'robotstxt/parser'
require 'uri'



module Robotstxt

  NAME            = 'Robotstxt'
  GEM             = 'robotstxt'
  AUTHORS         = ['Simone Rinzivillo <srinzivillo@gmail.com>']
  VERSION	      = '0.5.4'


  # Check if the <tt>URL</tt> is allowed to be crawled from the current <tt>Robot_id</tt>.
  # Robotstxt::Allowed? returns <tt>true</tt> if the robots.txt file does not block the access to the URL.
  #
  #  Robotstxt.allowed?('http://www.simonerinzivillo.it/', 'rubytest')
  #
  def self.allowed?(url, robot_id)
	
	  u = URI.parse(url)
	  r = Robotstxt::Parser.new(robot_id)
		r.allowed?(url) if r.get(u.scheme + '://' + u.host)	
    
  end
  
  # Analyze the robots.txt file to return an <tt>Array</tt> containing the list of XML Sitemaps URLs.
  #
  #  Robotstxt.sitemaps('http://www.simonerinzivillo.it/', 'rubytest')
  #  
  def self.sitemaps(url, robot_id)
	
	  u = URI.parse(url)
	  r = Robotstxt::Parser.new(robot_id)
		r.sitemaps if r.get(u.scheme + '://' + u.host)	
    
  end

  def self.get_robots_rules(url, robot_id)
    u = URI.parse(url)
    r = Robotstxt::Parser.new(robot_id)
    if block_given?
      r.body = yield
    else
      r.get(u.scheme + '://' + u.host)
    end && r.rules_to_hash
  end

end