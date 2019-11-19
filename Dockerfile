FROM julia

LABEL maintainer="Tom Kwong <tk3369@gmail.com>"

WORKDIR /app

COPY src /app

RUN julia --project=/app -e 'using Pkg; Pkg.instantiate(); Pkg.API.precompile();' 

ENTRYPOINT [ "julia", "--project=/app", "run.jl" ]
