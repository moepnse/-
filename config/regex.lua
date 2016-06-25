print(tostring(regex_does_match([[Zerg]], "Zerg")))
matched, whole_match, matches = regex_match([[([a-zA-Z]+)[\s]+([a-zA-Z]+)]], "Sarah Kerrigan")
print(tostring(matched))
print(whole_match)
for index, re_match in ipairs(matches) do
    print(re_match)
end