FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
ENV USER root

ENV USE_CCACHE 1
ENV CCACHE_SIZE 50G
ENV CCACHE_EXEC /usr/bin/ccache
ENV BRANCH_NAME 'lineage-16.0'
ENV DEVICE_LIST 'lavender'
ENV RELEASE_TYPE 'UNOFFICIAL'
ENV OTA_URL ''
ENV USER_NAME 'LineageOS Buildbot'
ENV USER_MAIL 'lineageos-buildbot@docker.host'
ENV INCLUDE_PROPRIETARY true
ENV BUILD_OVERLAY false
ENV LOCAL_MIRROR false
ENV CLEAN_OUTDIR true
ENV CRONTAB_TIME 'now'
ENV CLEAN_AFTER_BUILD false
ENV WITH_SU false
ENV ANDROID_JACK_VM_ARGS "-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4G"
ENV CUSTOM_PACKAGES ''
ENV SIGN_BUILDS false
ENV KEYS_SUBJECT '/C=US/ST=California/L=Mountain View/O=Android/OU=Android/CN=Android/emailAddress=android@android.com'
ENV ZIP_SUBDIR true
ENV LOGS_SUBDIR true
ENV SIGNATURE_SPOOFING "no"
ENV DELETE_OLD_ZIPS 0
ENV DELETE_OLD_LOGS 0

RUN apt-get -qq update && \
      apt-get install -y bc bison bsdmainutils build-essential ccache cgpt clang \
      cron curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick \
      kmod lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool \
      libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 \
      libxml2-utils lsof lzop maven openjdk-8-jdk pngcrush procps \
      python rsync schedtool squashfs-tools wget xdelta3 xsltproc yasm zip \
      zlib1g-dev \
      && rm -rf /var/lib/apt/lists/*

RUN curl 'https://dl.google.com/android/repository/platform-tools-latest-linux.zip' > ~/platform-tools-latest-linux.zip
RUN unzip -q ~/platform-tools-latest-linux.zip -d ~
RUN mkdir -p ~/bin
RUN mkdir -p ~/android/lineage
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo && \
      chmod a+x /usr/local/bin/repo

COPY build.sh /root/build.sh
ENTRYPOINT /root/build.sh
