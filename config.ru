#!/usr/bin/env ruby
# encoding: utf-8

# push the ../lib dir into the load path.
# so "require" finds your project modules
$:.push File.join(File.dirname(__FILE__), ["lib"])

require 'blog'

run Blog::App
