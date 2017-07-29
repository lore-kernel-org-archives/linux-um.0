Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <thomas@m3y3r.de>) id 1dbUTr-0004UW-6F
 for user-mode-linux-devel@lists.sourceforge.net;
 Sat, 29 Jul 2017 16:20:43 +0000
Received: from www17.your-server.de ([213.133.104.17])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dbUTp-0000g9-EV
 for user-mode-linux-devel@lists.sourceforge.net;
 Sat, 29 Jul 2017 16:20:43 +0000
Date: Sat, 29 Jul 2017 18:20:30 +0200
From: Thomas Meyer <thomas@m3y3r.de>
Message-ID: <20170729162030.GA24691@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] um: Run kselftests under UML
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: linux-kselftest@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Hi,

I did write a small script that compiles a user mode linux kernel and then run
all kselftests under this kernel.

What do you think about this idea?

script is:

#!/bin/sh

# x86_64 or i386
SUBARCH=x86_64

LINUX_DIR=/home/thomas/git/linux

RAW_FILE=Fedora-Cloud-Base-26-1.5.x86_64.raw
CLOUD_INIT_FILE=Fedora-Cloud-Base-Init.iso
KSELFTEST_FILE=Fedora-Cloud-Base-kselftests.img

if [ ! -f "$RAW_FILE" ]; then
  curl -OL "https://download.fedoraproject.org/pub/fedora/linux/releases/26/CloudImages/x86_64/images/$RAW_FILE.xz"
  unxz $RAW_FILE.xz
fi

if [ ! -f "$CLOUD_INIT_FILE" ]; then
  { echo instance-id: iid-local01; echo local-hostname: cloudimg; } > meta-data
  cat > user-data << EOF
#cloud-config
password: passw0rd
chpasswd: { expire: False }
ssh_pwauth: True

mounts:
 - [ /dev/ubdc, /opt ]

write_files:
 - content: |
     [Unit]
     Description=/etc/rc.d/rc.local Compatibility
     [Install]
     WantedBy=multi-user.target
     [Service]
     Type=simple
     ExecStart=/bin/sh /opt/run_kselftest.sh
     TimeoutSec=0
     RemainAfterExit=yes
     GuessMainPID=no
     WorkingDirectory=/opt/
     StandardOutput=journal+console
   path: /etc/systemd/system/kselftest.service
   permissions: '0755'

runcmd:
  - [ systemctl, daemon-reload ]
  - [ systemctl, enable, kselftest.service ]
  - [ systemctl, start, --no-block, kselftest.service ]

EOF

  ## create a disk to attach with some user-data and meta-data
  genisoimage -output $CLOUD_INIT_FILE -volid cidata -joliet -rock user-data meta-data
fi

# build kernel

# neither allyesconfig nor defconfig work correctly, because of failing build, missing config options
# so use a custom config for now. FIXME: goal should be to use allyesconfig?
cp config-$SUBARCH $LINUX_DIR/.config
make ARCH=um -C $LINUX_DIR/ -j$(nproc) all

# build and install kselftests
# used by kselftest install
export INSTALL_PATH=`mktemp -d`
make -C $LINUX_DIR/tools/testing/selftests all install
mke2fs -F -d $INSTALL_PATH $KSELFTEST_FILE 256m
rm -R $INSTALL_PATH

$LINUX_DIR/linux mem=1280m umid=kselftests ubd0=$RAW_FILE.cow,$RAW_FILE ubd1=$CLOUD_INIT_FILE ubd2=$KSELFTEST_FILE root=/dev/ubda1 ro rhgb quiet LANG=de_DE.UTF-8 plymouth.enable=0 con=pts con0=fd:0,fd:1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

