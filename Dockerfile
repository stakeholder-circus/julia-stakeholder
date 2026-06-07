FROM julia:1.12-bookworm
LABEL org.opencontainers.image.title="julia-stakeholder"
LABEL org.opencontainers.image.description="Julia deterministic-first stakeholder CLI"
WORKDIR /app
COPY Project.toml ./
COPY src ./src
COPY test ./test
RUN julia --project=. -e 'using Pkg; Pkg.test()'
ENTRYPOINT ["julia", "--project=/app", "/app/src/Stakeholder.jl"]
CMD ["--list-values"]
