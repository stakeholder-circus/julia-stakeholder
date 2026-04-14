FROM alpine:3.20
LABEL org.opencontainers.image.title="julia-stakeholder"
LABEL org.opencontainers.image.description="Scaffold-only placeholder container for julia-stakeholder"
CMD ["sh", "-lc", "echo 'julia-stakeholder scaffold-only baseline';"]
