Config = {}
Config.Debug = false               -- This is if you want to test something and need debug
Config.Job = {
    bahamas = {                    -- Job Name
        boss = vec3(0, 0, 0),      -- Boss menu Coords or false
        label = "bahamas Job",     -- Label for the menu
        stash = vec3(0, 0, 0),     -- Stash to store items
        job = { ["bahamas"] = 0 }, -- Name and the lowest rank to open the stash
        id = "bahamas",            -- Id for the menu must be the name of the job for some reason that i dont remember now
        cloth = vec3(0, 0, 0),     -- Cloth coords or false
        blip = {                   -- Blip info or false
            sprite = 766,
            color = 48,
            label = "Bahamas Mammas",
        },
        garage = {                         -- Garage for the job or false
            sacarvehiculo = vec3(0, 0, 0), -- This means take the vehicle from this coords
            label = "Bahamas Garage's",    -- Name of the garage
            options = {                    -- Options for the garage
                {
                    label = "Long Vehicle",
                    args = { hash = "stretch" },

                },
                {
                    label = "Stafford",
                    args = { hash = "stafford" },

                },
                {
                    label = "Hammer",
                    args = { hash = "patriot2" },

                },
            },
            devolucion = vec3(0, 0, 0),            -- This means return the vehicle to this coords
            spawn = vector4(0, 0, 0, 0),           -- Spawn coords
            livery = false,                        -- Livery or false
        },
        shop = {                                   -- Items for the shop or false
            name = "Bahamas mammas",               -- Name of the shop
            inventory = {
                { name = "bluelabel", price = 1 }, -- Item | price
                { name = "beer",      price = 1 },

            },
            locations = { vec3(0, 0, 0) } -- Where the shop is, can be an array like { vector3(0, 0, 0), vector3(0, 0, 0) }

        },
        groups = false -- Dont remember this one, but you can check the code, is open ;)
    },
    -- FIRE JOB EXAMPLE
    fire = {                                   -- Name of the job
        boss = vec3(0, 0, 0),                  -- Boss menu coords or false
        label = "Fire Station",                -- label for the menu
        stash = vec3(-620.87, -95.83, 45.50),  -- Stash to save items
        job = { ["fire"] = 0 },                -- name and the lowest rank to open the stash
        id = "fire",
        cloth = vec3(-627.94, -122.01, 39.22), -- Clothes coords
        blip = {                               -- Blip info
            sprite = 635,
            color = 1,
            label = "Fire Station"
        },
        garage = { -- Garage for the job
            sacarvehiculo = vec3(-635.78, -101.63, 38.05),
            label = "Fire Garage",
            options = {
                {
                    label = "Fire generic vehicle",
                    args = { hash = "firetruck" },

                },
            },
            devolucion = vec3(0, 0, 0),  -- This means return the vehicle to this coords
            spawn = vector4(0, 0, 0, 0), -- Spawn coords VECTOR 4
            livery = {
                ["firetruck"] = {
                    {
                        ["3"] = false,
                        ["4"] = false
                    }
                },

            }
        },
        shop = {                                                 -- Shop items
            name = "Fire Shop",                                  -- Name of the shop
            inventory = {
                { name = "WEAPON_FIREEXTINGUISHER", price = 0 }, -- Item | price}
                { name = "WEAPON_HATCHET",          price = 0 }, -- Item | price}
            },
            locations = { vec3(-630.9982, -123.6432, 39.2201) }  -- Where the shop is located
        },
    },

    --SHORTER ONE

    weazelnews = {                              -- Job Name
        boss = vec3(-1053.65, -230.63, 44.02),  -- Ubicacion del bossMenu
        label = "weazel",                       -- label para el menu
        stash = vec3(-1051.87, -232.99, 44.02), -- Stash para guardar items
        job = { ["weazel"] = 0 },               -- Jjob name and the lowest rank to open the stash
        id = "weazel",                          -- Inventory ID
        cloth = vec3(-1051.31, -235.08, 44.02),
        blip = {
            sprite = 135,
            color = 1,
            label = "Weazel News"
        },
        shop = false,
        groups = false
    },

}



Config.Gangs = {
    --[["families"] = {                            -- Nombre del Trabajo
        boss = vec3(-164.32, -1617.67, 33.65),  -- Ubicacion del bossMenu
        label = "La Familia",                   -- label para el menu
        stash = vec3(-163.67, -1607.08, 33.65), -- Stash para guardar items
        gang = { ["families"] = 0 },            -- nombre del trabajo y el rango menor para abrir el stash
        id = "families",
        cloth = vec3(-162.80, -1612.82, 33.65),
        blip = false,
        garage = {
            sacarvehiculo = vec3(-151.57, -1651.39, 32.67),
            label = "Garage",
            options = {
                {
                    label = "sultan",
                    args = { hash = "sultan" },

                },
                {
                    label = "bf400",
                    args = { hash = "bf400" },

                },
                {
                    label = "kuruma",
                    args = { hash = "kuruma" },

                },
                {
                    label = "kamacho",
                    args = { hash = "kamacho" },

                },
            },
            devolucion = vec3(-139.04, -1635.34, 32.36),
            spawn = vector4(-143.75, -1647.94, 32.68, 114.42),
            livery = {
                ["kamacho"] = {
                    {
                        ["3"] = false,
                        ["4"] = false
                    }
                },

            }
        },
        -- Id para el inventario
        shop = false,
        groups = false
    },
    ["anarchy"] = {                            -- Nombre del Trabajo
        boss = vec3(2186.08, 5570.31, 53.90),  -- Ubicacion del bossMenu
        label = "Sons of Anarchy",             -- label para el menu
        stash = vec3(2188.23, 5569.86, 53.90), -- Stash para guardar items
        gang = { ["anarchy"] = 0 },            -- nombre del trabajo y el rango menor para abrir el stash
        id = "anarchy",
        cloth = vec3(2190.75, 5579.32, 53.90),
        blip = false,
        garage = {
            sacarvehiculo = vec3(2196.00, 5605.32, 53.52),
            label = "Garaje",
            options = {
                {
                    label = "sultan",
                    args = { hash = "sultan" },

                },
                {
                    label = "bf400",
                    args = { hash = "bf400" },

                },
                {
                    label = "kuruma",
                    args = { hash = "kuruma" },

                },
                {
                    label = "kamacho",
                    args = { hash = "kamacho" },

                },
            },
            devolucion = vec3(2198.18, 5613.37, 53.64),
            spawn = vector4(2196.28, 5609.43, 53.13, 321.61),
            livery = {
                ["kamacho"] = {
                    {
                        ["3"] = false,
                        ["4"] = false
                    }
                },

            }
        },
        -- Id para el inventario
        shop = false,
        groups = false
    },
    ["crips"] = {                            -- Nombre del Trabajo
        boss = vec3(484.79, -1534.79, 29.29),  -- Ubicacion del bossMenu
        label = "Crips",             -- label para el menu
        stash = vec3(495.61, -1527.40, 29.29), -- Stash para guardar items
        gang = { ["crips"] = 0 },            -- nombre del trabajo y el rango menor para abrir el stash
        id = "crips",
        cloth = vec3(491.95, -1524.43, 29.29),
        blip = false,
        garage = {
            sacarvehiculo = vec3(491.30, -1517.82, 29.29),
            label = "Garaje",
            options = {
                {
                    label = "sultan",
                    args = { hash = "sultan" },

                },
                {
                    label = "bf400",
                    args = { hash = "bf400" },

                },
                {
                    label = "kuruma",
                    args = { hash = "kuruma" },

                },
                {
                    label = "kamacho",
                    args = { hash = "kamacho" },

                },
            },
            devolucion = vec3(505.37, -1520.01, 29.29),
            spawn = vector4(495.85, -1521.34, 29.29, 316.69),
            livery = {
                ["kamacho"] = {
                    {
                        ["3"] = false,
                        ["4"] = false
                    }
                },

            }
        },
        -- Id para el inventario
        shop = false,
        groups = false
    },

    ["midnight"] = {                            -- Nombre del Trabajo
        boss = false,  -- Ubicacion del bossMenu
        label = "Midnight",             -- label para el menu
        stash = vec3(432.79, -1890.48, 31.73), -- Stash para guardar items
        gang = { ["midnight"] = 0 },            -- nombre del trabajo y el rango menor para abrir el stash
        id = "midnight",
        cloth = false,
        blip = false,
        garage = false,
        -- Id para el inventario--
        shop = false,
        groups = false
    },]]
}

-----------##############-------------------Blip Creator-------------------##############-----------
Config.Blips = {
    -- {
    --     name = "Hawaii",           -- Name of the blip
    --     coords = vector3(0, 0, 0), -- Coords of the blip
    --     sprite = 270,              -- Blip sprite
    --     color = 50,                -- Blip color
    --     size = 0.5,                -- Blip size
    --     display = 4,               -- Blip display
    --     range = true,              -- Blip range
    -- },
}
