local console = {}
console.__index = console


function console.new(Title: string)
    local self = setmetatable({}, console)


    function self.say(...: string)
        rconsoleprint(...)
    end

    function self.title(title: string)
        rconsolesettitle(title)
    end

    function self.clear(callback: (response: boolean | string)->()?)
        local success, resp = pcall(function()
            rconsoleclear()
        end)
        callback(success or resp)
    end

    function self.close()
        rconsoledestroy()
    end

    function self.input(callback: (value: string)->())
        callback(rconsoleinput())
    end


    rconsolesettitle(Title)
    return self
end


function console:Title(title: string)
    self.title(title)
end

function console:Write(...: string)
    self.say(...)
end

function console:Input(callback: (value: string)->())
    self.input(callback)
end

function console:Reset(callback: (response: boolean | string)->()?)
    self.clear(callback or function(v)
        return;
    end)
end

function console:End()
    self.close()
end

return console
