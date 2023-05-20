#!BuildTag: warpdriveengaged:latest

FROM opensuse/tumbleweed:latest

RUN zypper ar http://download.opensuse.org/repositories/home:darix:container-workshop/openSUSE_Tumbleweed/ "home:darix:container-workshop"
RUN zypper mr -p 97 "home:darix:container-workshop"
RUN zypper --gpg-auto-import-keys ref

RUN zypper install -y warpdriveengaged-ruby util-linux shadow

RUN groupadd --gid 64536 -r warpdriveengaged && useradd --uid 64536 --no-log-init -r -g warpdriveengaged warpdriveengaged
RUN install -o warpdriveengaged -g warpdriveengaged -D -d /home/warpdriveengaged ; install -o warpdriveengaged -g warpdriveengaged -D -d /home/warpdriveengaged/bin

USER warpdriveengaged:warpdriveengaged
WORKDIR /home/warpdriveengaged
EXPOSE 9292/tcp
CMD ["/usr/bin/puma", "--dir", "/usr/share/warpdriveengaged-ruby/"]

