Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mout.kundenserver.de ([212.227.126.130])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iTBv5-0000zf-Hz
 for linux-um@lists.infradead.org; Fri, 08 Nov 2019 21:35:53 +0000
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 00/16] drivers: y2038 updates
Date: Fri,  8 Nov 2019 22:32:38 +0100
Message-Id: <20191108213257.3097633-1-arnd@arndb.de>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: y2038@lists.linaro.org
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org, jcmvbkbc@gmail.com, edumazet@google.com, netdev@vger.kernel.org, linux1394-devel@lists.sourceforge.net, devel@driverdev.osuosl.org, richard@nod.at, kadlec@netfilter.org, cluster-devel@redhat.com, ccaulfie@redhat.com, coreteam@netfilter.org, linux+etnaviv@armlinux.org.uk, pablo@netfilter.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, jdike@addtoit.com, linux-um@lists.infradead.org, etnaviv@lists.freedesktop.org, christian.gmeiner@gmail.com, teigland@redhat.com, viro@zeniv.linux.org.uk, tglx@linutronix.de, sean@poorly.run, hirofumi@mail.parknet.co.jp, willemb@google.com, valdis.kletnieks@vt.edu, rfontana@redhat.com, gregkh@linuxfoundation.org, fw@strlen.de, linux-kernel@vger.kernel.org, robdclark@gmail.com, stefanr@s5r6.in-berlin.de, netfilter-devel@vger.kernel.org, daniel@ffwll.ch, jack@suse.com, linux-fsdevel@vger.kernel.org, freedreno@lists.freedesktop.org, davem@davemloft.net, l.stach@pengutronix.de

These are updates to devidce drivers and file systems that for some
reason or another were not included in the kernel in the previous
y2038 series.

I've gone through all users of time_t again to make sure the
kernel is in a long-term maintainable state.

Posting these as a series for better organization, but each change
here is applicable standalone.

Please merge, review, ack/nack etc as you see fit. My plan is to
include any patches that don't get a reply this time around in
a future pull request, probably for linux-5.6.

As mentioned before, the full series of 90 patches is available at
https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/log/?h=y2038-endgame

    Arnd

Arnd Bergmann (16):
  staging: exfat: use prandom_u32() for i_generation
  fat: use prandom_u32() for i_generation
  net: sock: use __kernel_old_timespec instead of timespec
  dlm: use SO_SNDTIMEO_NEW instead of SO_SNDTIMEO_OLD
  xtensa: ISS: avoid struct timeval
  um: ubd: use 64-bit time_t where possible
  acct: stop using get_seconds()
  tsacct: add 64-bit btime field
  netfilter: nft_meta: use 64-bit time arithmetic
  packet: clarify timestamp overflow
  quota: avoid time_t in v1_disk_dqblk definition
  hostfs: pass 64-bit timestamps to/from user space
  hfs/hfsplus: use 64-bit inode timestamps
  drm/msm: avoid using 'timespec'
  drm/etnaviv: use ktime_t for timeouts
  firewire: ohci: stop using get_seconds() for BUS_TIME

 arch/um/drivers/cow.h                         |  2 +-
 arch/um/drivers/cow_user.c                    |  7 +++--
 arch/um/drivers/ubd_kern.c                    | 10 +++----
 arch/um/include/shared/os.h                   |  2 +-
 arch/um/os-Linux/file.c                       |  2 +-
 .../platforms/iss/include/platform/simcall.h  |  4 +--
 drivers/firewire/ohci.c                       |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_drv.c         | 19 ++++++-------
 drivers/gpu/drm/etnaviv/etnaviv_drv.h         | 21 ++++++--------
 drivers/gpu/drm/etnaviv/etnaviv_gem.c         |  5 ++--
 drivers/gpu/drm/etnaviv/etnaviv_gem.h         |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c         |  4 +--
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h         |  4 +--
 drivers/gpu/drm/msm/msm_drv.h                 |  3 +-
 drivers/staging/exfat/exfat_super.c           |  4 +--
 fs/dlm/lowcomms.c                             |  6 ++--
 fs/fat/inode.c                                |  3 +-
 fs/hfs/hfs_fs.h                               | 26 +++++++++++++----
 fs/hfs/inode.c                                |  4 +--
 fs/hfsplus/hfsplus_fs.h                       | 26 +++++++++++++----
 fs/hfsplus/inode.c                            | 12 ++++----
 fs/hostfs/hostfs.h                            | 22 +++++++++------
 fs/hostfs/hostfs_kern.c                       | 15 ++++++----
 fs/quota/quotaio_v1.h                         |  6 ++--
 include/linux/skbuff.h                        |  7 +++--
 include/uapi/linux/acct.h                     |  2 ++
 include/uapi/linux/taskstats.h                |  6 +++-
 kernel/acct.c                                 |  4 ++-
 kernel/tsacct.c                               |  9 ++++--
 net/compat.c                                  |  2 +-
 net/ipv4/tcp.c                                | 28 +++++++++++--------
 net/netfilter/nft_meta.c                      | 10 +++----
 net/packet/af_packet.c                        | 27 +++++++++++-------
 net/socket.c                                  |  2 +-
 34 files changed, 184 insertions(+), 124 deletions(-)

-- 
2.20.0

Cc: jdike@addtoit.com
Cc: richard@nod.at
Cc: jcmvbkbc@gmail.com
Cc: stefanr@s5r6.in-berlin.de
Cc: l.stach@pengutronix.de
Cc: linux+etnaviv@armlinux.org.uk
Cc: christian.gmeiner@gmail.com
Cc: airlied@linux.ie
Cc: daniel@ffwll.ch
Cc: robdclark@gmail.com
Cc: sean@poorly.run
Cc: valdis.kletnieks@vt.edu
Cc: gregkh@linuxfoundation.org
Cc: ccaulfie@redhat.com
Cc: teigland@redhat.com
Cc: hirofumi@mail.parknet.co.jp
Cc: jack@suse.com
Cc: davem@davemloft.net
Cc: edumazet@google.com
Cc: pablo@netfilter.org
Cc: kadlec@netfilter.org
Cc: fw@strlen.de
Cc: willemb@google.com
Cc: viro@zeniv.linux.org.uk
Cc: rfontana@redhat.com
Cc: tglx@linutronix.de
Cc: linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux1394-devel@lists.sourceforge.net
Cc: etnaviv@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org>
Cc: linux-arm-msm@vger.kernel.org>
Cc: freedreno@lists.freedesktop.org>
Cc: devel@driverdev.osuosl.org>
Cc: cluster-devel@redhat.com>
Cc: linux-fsdevel@vger.kernel.org>
Cc: netdev@vger.kernel.org>
Cc: netfilter-devel@vger.kernel.org>
Cc: coreteam@netfilter.org>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

