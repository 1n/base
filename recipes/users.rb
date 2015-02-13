#
# Cookbook Name:: base
# Recipe:: users
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

search(:users, '*:*').each do |u|
  user u['id'] do
    comment u['comment']
    supports manage_home: true
  end

  directory "/home/#{u['id']}/.ssh" do
    owner u['id']
  end

  file "/home/#{u['id']}/.ssh/authorized_keys" do
    owner u['id']
    mode '644'
    content u['ssh_keys'].join("\n")
  end
end