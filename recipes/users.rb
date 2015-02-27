#
# Cookbook Name:: base
# Recipe:: users
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

search(:users, '*:*').each do |u|
  user u['id'] do
    unless u['user_id'].empty?
      uid u['user_id']
    end
    unless u['group_id']
      gid u['group_id']
    end
    comment u['comment']
    unless u['user_home'].empty?
      home u['user_home']
      supports :manage_home => true
    end
    shell u['user_shell']
  end

  directory "#{u['user_home']}/.ssh" do
    owner u['id']
  end

  file "#{u['user_home']}/.ssh/authorized_keys" do
    owner u['id']
    mode '644'
    content u['ssh_keys']
  end

  if u['sudo'] == 'yes'
    sudo u['id'] do
      user u['id']
    end
  end
end