FROM nginxinc/nginx-unprivileged:1.27-bookworm
LABEL maintainer="Richard Craddock craddock9richard@gmail.com"
LABEL version=$VERSION
ARG VERSION
ENV VERSION=${VERSION}
USER root
COPY --link --chmod=755 --chown=nginx:root entrypoint /entrypoint
RUN apt update && apt install -y git \
  && cd /usr/share/nginx/ && git clone https://github.com/ShatteredDisk/rickroll.git \
  && mv rickroll/* html/ \
  && chown -R nginx:nginx html \
  # && mv html/rickroll.mp4 html/homepage.mp4 \
  && rm -rf rickroll
USER nginx
CMD ["sh", "entrypoint"]
