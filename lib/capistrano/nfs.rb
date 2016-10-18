require "capistrano/nfs/version"
require "capistrano/nfs/dsl"

include Capistrano::NFS::DSL

load File.expand_path("../tasks/utility.rake", __FILE__)
