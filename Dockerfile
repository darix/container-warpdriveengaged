#!BuildTag: warpdriveengaged:latest
FROM opensuse/tumbleweed:latest

RUN zypper ar http://download.opensuse.org/repositories/home:darix:container-workshop/openSUSE_Tumbleweed/ "home:darix:container-workshop"
RUN zypper mr -p 97 "home:darix:container-workshop"
RUN zypper --gpg-auto-import-keys ref

RUN zypper install -y warpdriveengaged-ruby util-linux
RUN zypper install -y shadow

RUN groupadd --gid 64536 -r wardriveengaged && useradd --uid 64536 --no-log-init -r -g wardriveengaged wardriveengaged
RUN install -o wardriveengaged -g wardriveengaged -D -d /home/wardriveengaged ; install -o wardriveengaged -g wardriveengaged -D -d /home/wardriveengaged/bin

USER wardriveengaged:wardriveengaged
WORKDIR /home/wardriveengaged
EXPOSE 9292/tcp
CMD ["/usr/bin/puma", "--dir", "/usr/share/warpdriveengaged-ruby/"]

