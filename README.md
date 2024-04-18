# FX-Stash

A complete solution for that kind of people that dont want to jump from one resource to another to add or modify something.

## Job Menu Creator

Here you can Modify and create:

- Boss Menu (Vector 3)
- A label for the menu.
- Stash to store items (Shared)
- Cloth Coords (vector3)
- Blip Creator
- Garage to take Vehicles
  - Take vehicle Coords (vector3)
  - Menu's Title
  - A list of vehicles to take.
  - Return Coords (vector3)
  - Spawn Coords (**VECTOR4**)
  - Livery config.
- Shop Creator
  - Name of the Shop
  - Inventory with name of the item and the price of it.
  - Locations (Array of vector3)

Example:
Short one, whitout a lot of stuff

```lua
 weazelnews = {                              -- Job Name
        boss = vec3(-1053.65, -230.63, 44.02),  -- Boss menu coord
        label = "weazel",                       -- Label of the menu
        stash = vec3(-1051.87, -232.99, 44.02), -- Stash to save Items (Shared)
        job = { ["weazel"] = 0 },               -- Job name and the lowest rank to open the stash
        id = "weazel",                          -- Inventory ID
        cloth = vec3(-1051.31, -235.08, 44.02), -- Cloth Coords
        blip = {                                -- Blip Coords
            sprite = 135,
            color = 1,
            label = "Weazel News"
        },
        garage = false,                          -- In this case this job doesnt have a garage
        shop = false,                           -- In this case this job doesnt have a shop
        groups = false
    },
```

Bigger one:

```lua
    fire = {                                   -- Name of the job
        boss = vec3(-0, 0, 0),                 -- Boss menu coords or false
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
            sacarvehiculo = vec3(0,0,0), -- Coordinates to the menu
            label = "Fire Garage", -- Menu Label
            options = { -- Options
                { -- table that cotain the vehicles
                    label = "Fire generic vehicle", -- Vehicle menu label
                    args = { hash = "firetruck" }, -- Args, cant be null
                },
            },
            devolucion = vec3(0, 0, 0),  -- This means return the vehicle to this coords
            spawn = vector4(0, 0, 0, 0), -- Spawn coords VECTOR 4
            livery = {
                ["firetruck"] = { -- Here the vehicle wont have the livery 3 and 4
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
                -- You can add many as you want
            },
            locations = { vec3(0,0,0) }  -- Where the shop is located, is an array, you can do {vec3(0,0,0),vec3(0,0,0)}
        },
    },

```

## Blip Creator

Here you can create blips for the game.

Example:

```lua
{
        name = "Hawaii",           -- Name of the blip
        coords = vector3(0, 0, 0), -- Coords of the blip
        sprite = 270,              -- Blip sprite
        color = 50,                -- Blip color
        size = 0.5,                -- Blip size
        display = 4,               -- Blip display
        range = true,              -- Blip range
},

```
