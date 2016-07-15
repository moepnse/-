function print_products()
    for product_name in software_list() do
        print(startswith(product_name, [[Microsoft Office Professional Plus 2013]]))
    end
end

local status, err = pcall(print_products)
--print(err.code)  -->  121

for installed_software in software_list() do
    print(installed_software)
end