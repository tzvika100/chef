#
# Cookbook:: s3
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

version = node["s3"]["version"]

if Dir.exist?('/home/ubuntu/app')
	directory '/home/ubuntu/app' do
		recursive true
		action :create
	end

	execute 'clean old version' do
        	command 'rm -r /home/ubuntu/app/*.rar'
    		ignore_failure true
  	end

end

remote_file_s3 '/home/tzvi/app/apk' do
	bucket 'my-storage-apk'
        remote_path 'app/'
        aws_access_key_id 'xxxxxxxxxxxxxxxxxxxxxxxx'
        aws_secret_access_key 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
        region 'us-west-2'
        action :create
end

execute 'extract_artifact' do
  command "tar -xf /home/tzvi/app/app-#{version}.tar "
  action :run
end

