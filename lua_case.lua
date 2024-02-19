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

Your code here.

]]

-- Creating the output table
local output = {}

-- A function to create a new table from an existing tables data, given a filter
local function CreateTable(table, filter)
    -- Creating a temporary table too hold the data
    local new_table = {}
    
    -- 2D for loops to check through the table and then the tables within the table
    for k, v in pairs(table) do
        for i, y in pairs(v) do
            if i == filter then
                new_table[k] = {["value"] = y, ["text_id"] = v["text_id"]}
            end
        end
    end

    -- Return the temporary table
    return new_table
end

output = CreateTable(input, lang_id)
print(output.footer.text_id .. " " .. output.footer.value)