Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52299C5B543
	for <linux-um@archiver.kernel.org>; Thu,  5 Jun 2025 09:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QpGV0n6u04ZW1P0zDrdpUx45bUUucEccJqYGRMnCtb8=; b=LbgmuRSz/vx+EItWTJjMM1GQ2i
	rhnj33BgdGJMWZG/dx+hFkKVv9JRJfvZTFckbQeC+tfYThZ+68Cfqgh5s4K28tM7gU+wxAHsbtC/W
	fEMTemfAD5zahJBOAUknJ9AY8fUshsMyQAHOwx+DL8af9ZSeg5Y72GHVhX3j13kozB0ZlI7rVsDQ8
	RoDplklZEA5QYc3FnFjx7XBOhUVF3DFziR/OQTt0rYx6IWS9smAH/l0J0OdJZb/JbT9zE0ziCgPCH
	6bnSs0zYCl9So2HPtsDaegB5SDENhaeaKSrmR1AuEju0xpH4bQs3g34mEYPddaAueRwvHoZHx5ycm
	xuHdfTkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN6qB-0000000F9hi-3zfr;
	Thu, 05 Jun 2025 09:24:51 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uN6ps-0000000F9eS-1LBH
	for linux-um@lists.infradead.org;
	Thu, 05 Jun 2025 09:24:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=QpGV0n6u04ZW1P0zDrdpUx45bUUucEccJqYGRMnCtb8=; t=1749115470; x=1750325070; 
	b=vvy+ftAfG0qN8/kOE7KINKtNR3jrgifs4sZy09Yjfz0OP5a+EbSRJkDIW3G8UDcZFAdtz8KL3Ba
	PNG9Dw8qvQHThKatuX2t4lUqZNS/U7lGZSu4BuKt86rKJEzr870IEBzCj27RGt7vyM6QzOcqAX5Wv
	gi+aoakoNC4nMlhQL2NCIiSeqtFa1OPUZVfT1mw6ZPCLRM6V1Kg5CU+LUyvZH7TBhY9DFNKCPoqWX
	fUY9culyxHrikAgMB62oswm6SNKZXqLLi6CqUPyTZqhKlzhcR301GG1Vk7/0fIhnp02+OmYBSnXlh
	7q0I2RHvs2RZlOAbd9bnWzPzeEA5PTeHfBqg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uN6pn-00000001pmy-0kRw;
	Thu, 05 Jun 2025 11:24:27 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [GIT PULL] uml 6.16-rc1
Date: Thu,  5 Jun 2025 11:20:57 +0200
Message-ID: <20250605092423.14973-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250605_022432_533358_4D0E7426 
X-CRM114-Status: GOOD (  15.44  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi Linus,

Looks like I'm getting into a habit of doing this rather
than Richard, who has been busy with other things :)

The only really new thing is the long-standing seccomp
work (originally from 2021!), even if it still isn't
enabled by default due to security concerns it can still
be used e.g. for tests.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 92a09c47464d040866cf2b4cd052bc60555185fb:

  Linux 6.15-rc5 (2025-05-04 13:55:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.16-rc1

for you to fetch changes up to e56a50ff7c12983aba710bd02a2c2ad401379e91:

  um: remove "extern" from implementation of sigchld_handler (2025-06-05 11:12:13 +0200)

----------------------------------------------------------------
Notable changes:

 - remove obsolete network transports

 - remove PCI IO port support

 - start adding seccomp-based process handling
   instead of ptrace

----------------------------------------------------------------
Arnd Bergmann (1):
      um: stop using PCI port I/O

Benjamin Berg (12):
      um: do not send SIGALRM to userspace in time-travel mode
      um: use proper care when taking mmap lock during segfault
      um: Move faultinfo extraction into userspace routine
      um: Add stub side of SECCOMP/futex based process handling
      um: Add helper functions to get/set state for SECCOMP
      um: Track userspace children dying in SECCOMP mode
      um: Implement kernel side of SECCOMP based process handling
      um: Add SECCOMP support detection and initialization
      um: pass FD for memory operations when needed
      um: fix SECCOMP 32bit xstate register restore
      um: fix unused variable warning
      um: remove "extern" from implementation of sigchld_handler

Jiapeng Chong (1):
      um: Remove duplicate arch.h header

Jiri Slaby (SUSE) (1):
      irqdomain: um: use irq_domain_create_linear() helper

Johannes Berg (1):
      um: chan_kern: use raw spinlock for irqs_to_free_lock

Lukas Bulwahn (1):
      MAINTAINERS: remove obsolete file entry in TUN/TAP DRIVER

Sami Tolvanen (1):
      um: Add cmpxchg8b_emu and checksum functions to asm-prototypes.h

Tiwei Bie (8):
      um: xterm: Add Wayland support
      um: xterm: Update options for gnome-terminal
      um: Add VFIO-based virtual PCI driver
      um: Remove obsolete legacy network transports
      um: vector: Eliminate the dependency on uml_net
      um: Remove legacy network transport infrastructure
      um: vector: Clean up and modernize log messages
      um: vector: Use mac_pton() for MAC address parsing

Uros Bizjak (2):
      um/asm: Rename rep_nop() to native_pause()
      um/asm: Replace "REP; NOP" with PAUSE mnemonic

Yongting Lin (1):
      um: Fix tgkill compile error on old host OSes

 .../virt/uml/user_mode_linux_howto_v2.rst          |  47 +-
 MAINTAINERS                                        |   3 +-
 arch/um/Kconfig                                    |   6 -
 arch/um/configs/i386_defconfig                     |   7 -
 arch/um/configs/x86_64_defconfig                   |   7 -
 arch/um/drivers/Kconfig                            | 204 +----
 arch/um/drivers/Makefile                           |  22 +-
 arch/um/drivers/chan_kern.c                        |  10 +-
 arch/um/drivers/daemon.h                           |  29 -
 arch/um/drivers/daemon_kern.c                      |  95 ---
 arch/um/drivers/daemon_user.c                      | 194 -----
 arch/um/drivers/net_kern.c                         | 889 ---------------------
 arch/um/drivers/net_user.c                         | 271 -------
 arch/um/drivers/slip.h                             |  21 -
 arch/um/drivers/slip_common.c                      |  55 --
 arch/um/drivers/slip_common.h                      | 106 ---
 arch/um/drivers/slip_kern.c                        |  93 ---
 arch/um/drivers/slip_user.c                        | 252 ------
 arch/um/drivers/slirp.h                            |  34 -
 arch/um/drivers/slirp_kern.c                       | 120 ---
 arch/um/drivers/slirp_user.c                       | 124 ---
 arch/um/drivers/umcast.h                           |  27 -
 arch/um/drivers/umcast_kern.c                      | 188 -----
 arch/um/drivers/umcast_user.c                      | 184 -----
 arch/um/drivers/vde.h                              |  32 -
 arch/um/drivers/vde_kern.c                         | 129 ---
 arch/um/drivers/vde_user.c                         | 125 ---
 arch/um/drivers/vector_kern.c                      |  48 +-
 arch/um/drivers/vfio_kern.c                        | 642 +++++++++++++++
 arch/um/drivers/vfio_user.c                        | 327 ++++++++
 arch/um/drivers/vfio_user.h                        |  44 +
 arch/um/drivers/virt-pci.c                         |  15 +-
 arch/um/drivers/xterm.c                            |  11 +-
 arch/um/include/asm/asm-prototypes.h               |   5 +
 arch/um/include/asm/irq.h                          |   5 +-
 arch/um/include/asm/mmu.h                          |   3 +
 arch/um/include/shared/common-offsets.h            |   4 +
 arch/um/include/shared/irq_user.h                  |   2 +
 arch/um/include/shared/net_kern.h                  |  69 --
 arch/um/include/shared/net_user.h                  |  52 --
 arch/um/include/shared/os.h                        |   4 +-
 arch/um/include/shared/skas/mm_id.h                |   9 +
 arch/um/include/shared/skas/skas.h                 |   1 +
 arch/um/include/shared/skas/stub-data.h            |  20 +-
 arch/um/kernel/Makefile                            |   1 -
 arch/um/kernel/ioport.c                            |  13 -
 arch/um/kernel/irq.c                               |   6 +
 arch/um/kernel/skas/mmu.c                          |  91 ++-
 arch/um/kernel/skas/stub.c                         | 132 ++-
 arch/um/kernel/skas/stub_exe.c                     | 159 +++-
 arch/um/kernel/time.c                              |  13 +-
 arch/um/kernel/trap.c                              | 130 ++-
 arch/um/os-Linux/Makefile                          |   2 +-
 arch/um/os-Linux/drivers/Makefile                  |  13 -
 arch/um/os-Linux/drivers/etap.h                    |  21 -
 arch/um/os-Linux/drivers/ethertap_kern.c           | 100 ---
 arch/um/os-Linux/drivers/ethertap_user.c           | 248 ------
 arch/um/os-Linux/drivers/tuntap.h                  |  21 -
 arch/um/os-Linux/drivers/tuntap_kern.c             |  86 --
 arch/um/os-Linux/drivers/tuntap_user.c             | 215 -----
 arch/um/os-Linux/file.c                            |  15 -
 arch/um/os-Linux/internal.h                        |   5 +-
 arch/um/os-Linux/process.c                         |  31 +
 arch/um/os-Linux/registers.c                       |   4 +-
 arch/um/os-Linux/sigio.c                           |   3 +-
 arch/um/os-Linux/signal.c                          |  19 +-
 arch/um/os-Linux/skas/mem.c                        | 101 ++-
 arch/um/os-Linux/skas/process.c                    | 488 ++++++++---
 arch/um/os-Linux/start_up.c                        | 195 ++++-
 arch/x86/um/asm/checksum.h                         |   3 +
 arch/x86/um/asm/processor.h                        |   8 +-
 arch/x86/um/os-Linux/mcontext.c                    | 218 ++++-
 arch/x86/um/ptrace.c                               |  76 +-
 arch/x86/um/shared/sysdep/kernel-offsets.h         |   2 +
 arch/x86/um/shared/sysdep/mcontext.h               |   9 +
 arch/x86/um/shared/sysdep/stub-data.h              |  23 +
 arch/x86/um/shared/sysdep/stub.h                   |   2 +
 arch/x86/um/shared/sysdep/stub_32.h                |  13 +
 arch/x86/um/shared/sysdep/stub_64.h                |  17 +
 arch/x86/um/tls_32.c                               |  26 +-
 80 files changed, 2683 insertions(+), 4361 deletions(-)
 delete mode 100644 arch/um/drivers/daemon.h
 delete mode 100644 arch/um/drivers/daemon_kern.c
 delete mode 100644 arch/um/drivers/daemon_user.c
 delete mode 100644 arch/um/drivers/net_kern.c
 delete mode 100644 arch/um/drivers/net_user.c
 delete mode 100644 arch/um/drivers/slip.h
 delete mode 100644 arch/um/drivers/slip_common.c
 delete mode 100644 arch/um/drivers/slip_common.h
 delete mode 100644 arch/um/drivers/slip_kern.c
 delete mode 100644 arch/um/drivers/slip_user.c
 delete mode 100644 arch/um/drivers/slirp.h
 delete mode 100644 arch/um/drivers/slirp_kern.c
 delete mode 100644 arch/um/drivers/slirp_user.c
 delete mode 100644 arch/um/drivers/umcast.h
 delete mode 100644 arch/um/drivers/umcast_kern.c
 delete mode 100644 arch/um/drivers/umcast_user.c
 delete mode 100644 arch/um/drivers/vde.h
 delete mode 100644 arch/um/drivers/vde_kern.c
 delete mode 100644 arch/um/drivers/vde_user.c
 create mode 100644 arch/um/drivers/vfio_kern.c
 create mode 100644 arch/um/drivers/vfio_user.c
 create mode 100644 arch/um/drivers/vfio_user.h
 delete mode 100644 arch/um/include/shared/net_kern.h
 delete mode 100644 arch/um/include/shared/net_user.h
 delete mode 100644 arch/um/kernel/ioport.c
 delete mode 100644 arch/um/os-Linux/drivers/Makefile
 delete mode 100644 arch/um/os-Linux/drivers/etap.h
 delete mode 100644 arch/um/os-Linux/drivers/ethertap_kern.c
 delete mode 100644 arch/um/os-Linux/drivers/ethertap_user.c
 delete mode 100644 arch/um/os-Linux/drivers/tuntap.h
 delete mode 100644 arch/um/os-Linux/drivers/tuntap_kern.c
 delete mode 100644 arch/um/os-Linux/drivers/tuntap_user.c
 create mode 100644 arch/x86/um/shared/sysdep/stub-data.h

