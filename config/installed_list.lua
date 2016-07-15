for installed_package in installed_list() do
    print(installed_package['package_id'])
    print(installed_package['version'] > "1.0")
end