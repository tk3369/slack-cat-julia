module CatFacts

using HTTP
using Sockets
using JSON3
using Dates

const ROUTER = HTTP.Router()

struct SimpleMessage
    text::String
    response_type::String
end

# type can be "in_channel" or "ephemeral"
make_message(s::String; type = "in_channel") = SimpleMessage(s, type)

JSON3.StructType(::Type{SimpleMessage}) = JSON3.Struct()

function cat_facts(req::HTTP.Request)
    println(req)
    try
        println(now(), ": Fetching cat fact")
        response = HTTP.request("GET", "https://catfact.ninja/fact")    
        println(now(), ": Recevied cat fact")
    
        json = JSON3.read(response.body)
        msg = make_message("😸😸😸Did you know... " * json[:fact])

        headers = ["Content-type" => "application/json"]
        body = JSON3.write(msg)
        println(now(), ": Returning data")

        return HTTP.Response(200, headers, body = body)
    catch ex
        println(now(), ": exception ex=$ex")
        return HTTP.Response(500, "Sorry, got an exception.")
    end
end

function start(port)
    HTTP.@register(ROUTER, "GET", "/", cat_facts)    
    HTTP.@register(ROUTER, "POST", "/", cat_facts)    
    HTTP.serve(ROUTER, IPv4(0), port, verbose = true)
end

end
