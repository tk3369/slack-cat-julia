# Run cat-facts app

# ensure that PORT env var is set
haskey(ENV, "PORT") || error("Please set PORT environment variable")

# parse PORT
portstr = ENV["PORT"]
port = tryparse(Int, portstr)
isnothing(port) && error("Unable to parse PORT: $portstr")

# include module
include("slack.jl")

# main program
using .CatFacts
CatFacts.start(port)
