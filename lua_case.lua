--[[
LUA CASE FOR STORYKIT_ APPLICATION
By André Johanssson

Code conventions:
- All variables are formated in snake_case according to the variables given in the case (ie lang_id)
- All function-names are written in CamelCase
- Indentation is keept at 4 spaces according to LUA guidelines (they speek of 2 to 4 spaces)
- Itterators local variables are named according to most fitting for their function or k, v for the outer loop and i, j for the inner loop, _ is used for unused variables
- Global variables are avoided

How to use:
- Run the code in the terminal and read the output from their or examine the code directly. The input function to choose a language ID is primarily
built for debuging/testing so do feel free to use that.
]]




-- Given data in the case
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





-- Helper functions and variables
local string_spacer = "\n=   =   =   =   =   =   =   =   =   =   =   =   =   =   =   =   =   =   =   =\n\n"
local string_tab = "    " -- I know \t exsits but the tab is 8 spaces, breaking the LUA style guide

local function PrintArray(tbl) -- Prints an array
    for _, v in ipairs(tbl) do -- ipairs instead of pairs because the array has a numreric index
        io.write(string_tab .. v .. "\n")
    end
end

local function ShortenTextIfRequired(text, cap_at_len) -- Function to shorten any given text if it's longer than the given cap
    if string.len(text) > cap_at_len then
        return string.sub(text, 1, cap_at_len - 3) .. "..."
    else
        return nil
    end
end

local ChooseLanguangeID = function (choice) -- Switch case (C) style implementation of a language choice to avoid enless if-statments and allow for a default value
    choice = string.lower(choice) -- Make sure that the input is read even with different formating
    local case =
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
            io.write("\nYour choice is din't match any of the specified languanges, the program will default to language: lorem")
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





-- Input module for picking a language ID. All reading and printing is done directly in the terminal.
local answer
io.write("Choose language ID (eng, swe, ger or lorem): ")
answer = io.read()

ChooseLanguangeID(answer)
ChooseLanguangeID(lang_id) -- Make sure that the language ID is not nil or a non exsiting languange before going further, if so default to lorem

io.write("\n" .. string_spacer)





-- Creating the output table with correct structure to fill in later
local output = {
    greeting = {
        value = "",
        text_id = 0
    },
    headline = {
        value = "",
        text_id = 0
    },
    content = {
        value = "",
        text_id = 0
    },
    footer = {
        value = "",
        text_id = 0
    }
}

-- Maps the values from the input table to the corresponding spot in the output table after filtering out bassed on lang_id
local function ExtractLanguage(input_tbl, output_tbl, language)
    for element_type, element_table in pairs(input_tbl) do
        for key, value in pairs(element_table) do
                if key == language then
                    output_tbl[element_type]["value"] = value
                    output_tbl[element_type]["text_id"] = element_table["text_id"] or 0
                break
                end
        end
    end
end

-- Proccesses the filtered and mapped table to see if any strings are longer then 20 chars.
-- If so creates a new key value pair [shortened_text] and the text shortened to 17 chars with "..." concatenated to the end
local function ProccessTable(tbl)
    for element_type, element_table in pairs(tbl) do
        for _, value in pairs(element_table) do
            local shortened_text = ShortenTextIfRequired(value, 20)
            if shortened_text then
                tbl[element_type]["shortened_text"] = shortened_text
            end
        end
    end
end

-- Do the extraction and proccessing
ExtractLanguage(input, output, lang_id)
ProccessTable(output)

local function PrintOutput(tbl) -- A function to handle printing of the output table and all its key-value pairs in correct formating
    for element_type, element_table in pairs(tbl) do
        local headline = element_type
        io.write(string_tab .. headline .. ":\n")
        for key, value in pairs(element_table) do
            io.write(string_tab .. string_tab .. key .. ": " .. value .. "\n")
        end
    end
end

io.write("Finalized output table:\n")
PrintOutput(output)
io.write(string_spacer)

-- A function that maps the values: [text_id] and [value] to form a new key pair in an associative array
local function TableToAssositiveArray(tbl)
    local new_tbl = {}
    local position = 0
    local string = ""

    for _, element_table in pairs(tbl) do
        for key, value in pairs(element_table) do
            if key == "text_id" then
                position = value
            elseif key == "value" then
                string = value
            end
        end
        new_tbl[position] = string -- Places the new pairs at the correct position according to the [text_id], no sorting needed
    end
    return new_tbl
end

local ordered_by_id = TableToAssositiveArray(output)

io.write("Ordered by text ID:\n")
PrintArray(ordered_by_id)
io.write(string_spacer)

-- Takes the assocciative array of [text_id] [value] pairs and orders them in order of shortest string to longest
local ordered_by_lenght = ordered_by_id
table.sort(ordered_by_lenght, function(a,b) return #a<#b end)

io.write("Ordered by string lenght:\n")
PrintArray(ordered_by_lenght)