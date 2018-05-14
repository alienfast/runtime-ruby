FROM ruby:2.5.1-slim-stretch

# make Apt non-interactive
RUN echo 'APT::Get::Assume-Yes "true";' > /etc/apt/apt.conf.d/90alienfast \
  && echo 'DPkg::Options "--force-confnew";' >> /etc/apt/apt.conf.d/90alienfast

ENV DEBIAN_FRONTEND=noninteractive

# install packages
# - Add default-libmysqlclient-dev for mysql connectivity
# - Add libvips and dependencies for image processing https://github.com/TailorBrands/docker-libvips/blob/master/8.6.1/Dockerfile
ENV LIBVIPS_VERSION 8.6.1
RUN apt-get update -qq \
    && apt-get install -y \
    default-libmysqlclient-dev \
    locales \
    automake build-essential curl \
    cdbs debhelper dh-autoreconf flex bison \
    libjpeg-dev libtiff-dev libpng-dev libgif-dev librsvg2-dev libpoppler-glib-dev zlib1g-dev fftw3-dev liblcms2-dev \
    liblcms2-dev libmagickwand-dev libfreetype6-dev libpango1.0-dev libfontconfig1-dev libglib2.0-dev libice-dev \
    gettext pkg-config libxml-parser-perl libexif-gtk-dev liborc-0.4-dev libopenexr-dev libmatio-dev libxml2-dev \
    libcfitsio-dev libopenslide-dev libwebp-dev libgsf-1-dev libgirepository1.0-dev gtk-doc-tools \
    \
    && cd /tmp \
    && curl -L -O https://github.com/jcupitt/libvips/releases/download/v$LIBVIPS_VERSION/vips-$LIBVIPS_VERSION.tar.gz \
    && tar zxvf vips-$LIBVIPS_VERSION.tar.gz \
    && cd /tmp/vips-$LIBVIPS_VERSION \
    && ./configure --enable-debug=no --without-python $1 \
    && make \
    && make install \
    && ldconfig \
    \
    && apt-get autoclean -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set timezone to UTC by default
RUN ln -sf /usr/share/zoneinfo/Etc/UTC /etc/localtime

# Use unicode
RUN locale-gen C.UTF-8 || true
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8