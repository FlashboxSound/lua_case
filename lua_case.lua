--[[
Helper functions:
]]

function PrintArray(table)
    for k, v in pairs(table) do
        print(v)
    end
end



switch = function (choice) -- Analouge to a switch case in C++ to avoid enless if-statments and allow for a default value
    choice = string.lower(choice) -- Make sure that the input is read even with different formating
    case =
        {
        ["eng"] = function ( ) 
            lang_id = "eng"
        end,

        ["swe"] = function ( ) 
            lang_id = "swe"
        end,

        ["ger"] = function ( ) 
            lang_id = "ger"
        end,

        ["lorem"] = function ( )
            lang_id = "lorem"
        end,

        default = function ( )
            io.write("\nYour choice is din't match any of the specified languanges, the program will default to: lorem")
            lang_id = "lorem" 
        end,
        }

    -- execution section
    if case[choice] then
        case[choice]()
    else
        case["default"]()
    end
end



function PrintOutput(table) -- Function to handle printing of the output table and all its key-value pairs
    local headline = ""
    local key = ""
    local value = ""
    for k, v in pairs(output) do
        headline = k
        io.write(headline .. ":\n")
        for i, j in pairs(v) do
            key = i
            value = j
            io.write("\t" .. key .. ": " .. value .. "\n")
        end
    end
end





--[[
Test constants:
]]

local input = {
    greeting = {
        eng = "Hello World!",
        swe = "Hallå Världen!",
        ger = "Hallo Welt!",
        lorem = "Lorem ipsum!",
        text_id = 1
    },
    headline = {
        eng = "This is a headline.",
        swe = "Det här en rubrik.",
        ger = "Dies ist eine Überschrift.",
        lorem = "Dolor sit amet.",
        text_id = 2
    },
    content = {
        eng = "This is the main content. It consists of two sentences.",
        swe = "Det här är huvudinnehållet. Det består av två meningar.",
        ger = "Dies ist der Hauptinhalt. Er besteht aus zwei Sätzen.",
        lorem = "Quisque at luctus libero. Lorem ipsum dolor sit amet.",
        text_id = 3
    },
    footer = {
        eng = "Last updated: February 15 2024.",
        swe = "Senast uppdaterad: 15 februari 2024.",
        ger = "Zuletzt aktualisiert: 15. Februar 2024.",
        lorem = "Donec iaculis facilisis: Jan 1 1970.",
        text_id = 4
    }
}

local lang_id = "swe"





--[[
Input module for picking a language ID. All reading and printing is done directly in the terminal. This is soley for testing purposes.
]]

local answer
io.write("Choose language ID (eng, swe, ger or lorem): ")
answer = io.read()

switch(answer)

io.write("\n\n= = = = = = = = = = = = = = = = = = = =\n\n")





--[[
Task: Create an array table where the strings are stored and ordered by text_id from lowest to highest id

Description: ...
]]

local output = {} -- Creating the output table

switch(lang_id) -- Make sure that the language ID is set to an exsisting language, otherwise set to Lorem

function Map(table, filter) -- A function to map an existing tables values to a new table given a filter
    
    local new_table = {} -- Creating a temporary table too hold the data
    
    for k, v in pairs(table) do -- 2D for loops to check through the table and then the tables within the table
        for i, j in pairs(v) do
            if i == filter then
                new_table[k] = {["value"] = j, ["text_id"] = v["text_id"]}
            end
        end
    end

    return new_table -- Return the new table
end

output = Map(input, lang_id)

io.write("Finalized output table:\n") -- Print the finalized output table

PrintOutput(output)
io.write("\n= = = = = = = = = = = = = = = = = = = =\n\n")





--[[
Task: Create an array table where the strings are stored and ordered by text_id from lowest to highest id

Description: ...
]]

function TableToAssositiveArray(table, order) -- Function that transforms a table with multiple levels to a flat, associative array with the key [text_id] and value [value]
    local new_table = {}
    local position = 0
    local string = ""

    for k, v in pairs(table) do
        for i, j in pairs(v) do
            if i == "text_id" then
                position = j
            elseif i == "value" then
                string = j
            end
        end
        
        new_table[position] = string -- Places the new pairs at the correct position according to the [text_id], no sorting needed

    end

    return new_table
end

local ordered_by_id = TableToAssositiveArray(output)

io.write("Ordered by text ID:\n")

PrintArray(ordered_by_id)

io.write("\n= = = = = = = = = = = = = = = = = = = =\n\n")





--[[
Task: Create an array table where the strings are stored and sorted from fewest characters to most characters

Description: ...
]]

local ordered_by_lenght = ordered_by_id
table.sort(ordered_by_lenght, function(a,b) return #a<#b end)

io.write("Ordered by string lenght:\n")

PrintArray(ordered_by_lenght)