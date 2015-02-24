#
# Cookbook Name:: base
# Recipe:: users
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

search(:users, '*:*').each do |u|
  group u['group_id'] do
    action :create
  end

  user u['id'] do
    gid u['group_id']
    comment u['comment']
    shell u['user_shell']
    supports manage_home: true
  end

  directory "#{u['user_home']}/.ssh" do
    owner u['id']
  end

  file "#{u['user_home']}/.ssh/authorized_keys" do
    owner u['id']
    mode '644'
    content u['ssh_keys']#.join("\n")
  end
end