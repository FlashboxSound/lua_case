-- Test constants:
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



-- Helper functions:
local function PrintArray(tbl)
    for _, v in ipairs(tbl) do
        print(v)
    end
end


-- Function to shorten any given text if it's longer than the given cap
local function ShortenTextIfRequired(text, capAtLen)
    if string.len(text) > capAtLen then
        return string.sub(text, 1, capAtLen - 3) .. "..."
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


-- Input module for picking a language ID. All reading and printing is done directly in the terminal. This is soley for testing purposes.

local answer
io.write("Choose language ID (eng, swe, ger or lorem): ")
answer = io.read()

ChooseLanguangeID(answer)

io.write("\n\n= = = = = = = = = = = = = = = = = = = =\n\n")



-- Task: Create an array table where the strings are stored and ordered by text_id from lowest to highest id
-- Description: ...

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
} -- Creating the output table

ChooseLanguangeID(lang_id) -- Make sure that the language ID is not nil or a non exsiting languange, if so default to lorem

local function ExtractLanguage(input_tbl, output_tbl, language) -- A function to map an existing tables values to a new table given a filter
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

local function ProccessTable(tbl)
    for element_type, element_table in pairs(tbl) do
        for key, value in pairs(element_table) do
            local shortened_text = ShortenTextIfRequired(value, 20)
            if shortened_text then
                tbl[element_type]["shortened_text"] = shortened_text
            end
        end
    end
end

ExtractLanguage(input, output, lang_id)
ProccessTable(output)

local function PrintOutput(tbl) -- Function to handle printing of the output table and all its key-value pairs
    for k, v in pairs(tbl) do
        local headline = k
        io.write(headline .. ":\n")
        for i, j in pairs(v) do
            local key = i
            local value = j
            io.write("\t" .. key .. ": " .. value .. "\n")
        end
    end
end

io.write("Finalized output table:\n") -- Print the finalized output table

PrintOutput(output)
io.write("\n= = = = = = = = = = = = = = = = = = = =\n\n")



-- Task: Create an array table where the strings are stored and ordered by text_id from lowest to highest id
-- Description: ...

function TableToAssositiveArray(tbl, order) -- Function that transforms a table with multiple levels to a flat, associative array with the key [text_id] and value [value]
    local new_table = {}
    local position = 0
    local string = ""

    for _, v in pairs(tbl) do
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



-- Task: Create an array table where the strings are stored and sorted from fewest characters to most characters
-- Description: ...

local ordered_by_lenght = ordered_by_id
table.sort(ordered_by_lenght, function(a,b) return #a<#b end)

io.write("Ordered by string lenght:\n")

PrintArray(ordered_by_lenght)