#
# Cookbook Name:: base
# Recipe:: groups
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

search(:groups, '*:*').each do |g|
  group g['id'] do
    unless g['group_id'].empty?
      gid g['group_id']
    end
    action :create
  end

  if g['sudo'] == 'yes'
    sudo g['id'] do
      group g['id']
    end
  end
end