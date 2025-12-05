Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A08D2F7C7
	for <linux-um@archiver.kernel.org>; Fri,  5 Dec 2025 09:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bWrtQGuJBaLGgq85BHV/z3C0DG/RDwFXuOvTvxgP9SY=; b=WtNVYgo9kvBU7IOeRYA8QRwbih
	628fwK37WJYXHEM+/8bmPS0O0a7An8wkPba7xT++JNUWnwCrhgTEQ2vTProPRz0Q/TxSuXGO8fYe2
	pWMQ5lD405Zw/O/6VhKnGWL+HzEd0oI9X6nT3N7714xfLeawR7oiLGvbK+7J8uVKJ7clOVsJ8X1of
	F4p8SoUXHTbZfagYM+SjrD7n/19Grdkf/+G0sUWyzbAApZmpzoFc5+duR3qE824WW7bGAww5KcpDK
	JYzlAjM1tV9r/dl4ilqb2Y8Ls4MlOIAMp+wUAaneb+oobLzobIRKy/QhEnQ3ZJhuJY+6MslvxeSv1
	Z2wrKtvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRRsZ-00000009HiN-1jwT;
	Fri, 05 Dec 2025 09:13:31 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRRsW-00000009HhD-1w9g
	for linux-um@lists.infradead.org;
	Fri, 05 Dec 2025 09:13:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=bWrtQGuJBaLGgq85BHV/z3C0DG/RDwFXuOvTvxgP9SY=; t=1764926008; x=1766135608; 
	b=eByra2PzpRatQ7alRPIFNPJNqVQRVkAh/fNpYJRAgMc56Tx3cCt/2EF/ImzCtNO9P3FbX/51c9u
	MuxEyQw0QyYlK+Nx37LFujiFMSlL1NavZ91uYhZykhFqv40ek8suefQBDjcFsak80m/lT7QRC6aLo
	QSvvkpvplv3F4cuHnd+VEUGEqNNzAcZg+UL513u8MWp/7S3w9wcwCxzWDa31TEq8nIy/36K+K3nWs
	7CxPo/hsBtvwlpd0+PQy6jbE1wEZde39Xi4AYPUjxXyzqJ3dc9g8BWKrKVzeIRqOZR1hgOD7hbjsW
	OUXK23XgAxdCIaO92zOlNkkukwoP52c/aN5A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vRRsO-00000005YeN-2bGo;
	Fri, 05 Dec 2025 10:13:20 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [GIT PULL] uml 6.19-rc1
Date: Fri,  5 Dec 2025 10:07:44 +0100
Message-ID: <20251205091317.8896-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251205_011328_804742_56B8D5F4 
X-CRM114-Status: GOOD (  15.16  )
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

UML updates this time are SMP and vDSO cleanups, along with
the usual churn. Stehen reported [1] a merge conflict between
this and the tip-fixes tree, but evidently that isn't in your
tree yet, at least right now when I tried it merged cleanly.

[1] https://lore.kernel.org/lkml/20251204125841.4fd60214@canb.auug.org.au/

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa:

  Linux 6.18-rc3 (2025-10-26 15:59:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-linux-6.19-rc1

for you to fetch changes up to a3209bb94b36351f11e0d9e72ac44e5dd777a069:

  um: Disable KASAN_INLINE when STATIC_LINK is selected (2025-12-01 11:54:50 +0100)

----------------------------------------------------------------
Apart from the usual small churn, we have

 - initial SMP support (only kernel)

 - major vDSO cleanups (and fixes for 32-bit)

----------------------------------------------------------------
Christophe Leroy (CS GROUP) (1):
      um: Disable KASAN_INLINE when STATIC_LINK is selected

David Gow (1):
      um: Don't rename vmap to kernel_vmap

Johannes Berg (3):
      um: init cpu_tasks[] earlier
      um/hostfs: define HOSTFS_ATTR_* via asm-offsets
      um: move asm-offsets generation into a single file

Kuninori Morimoto (1):
      um: drivers: virtio: use string choices helper

Thomas Weißschuh (15):
      x86/um/vdso: Fix prototype of clock_gettime()
      x86/um/vdso: Use prototypes from generic vDSO headers
      x86/um/vdso: Panic when vDSO can not be allocated
      x86/um/vdso: Drop VDSO64-y from Makefile
      um: Avoid circular dependency on asm-offsets in pgtable.h
      um: Split out default elf_aux_platform
      x86/um: Move ELF_PLATFORM fallback to x86-specific code
      um: Split out default elf_aux_hwcap
      x86/um: Do not inherit vDSO from host
      x86/um: Drop gate area handling
      um: Remove fixaddr_user_init()
      um: Remove redundant range check from __access_ok_vsyscall()
      um: Remove __access_ok_vsyscall()
      x86/um: Remove FIXADDR_USER_START and FIXADDR_USE_END
      um: Always set up AT_HWCAP and AT_PLATFORM

Tiwei Bie (12):
      um: Make host_task_size a local variable
      um: Use PAGE_ALIGN() for address alignment
      um: Replace UML_ROUND_UP() with PAGE_ALIGN()
      um: Remove file-based iomem emulation support
      um: Do not disable kmalloc in initial_thread_cb()
      um: Turn signals_* into thread-local variables
      um: Determine sleep based on need_resched()
      um: Define timers on a per-CPU basis
      um: Add initial SMP support
      um: vdso: Remove getcpu support on x86
      asm-generic: percpu: Add assembly guard
      um: Enable SMP support on x86

 .../core/generic-idle-thread/arch-support.txt      |   2 +-
 arch/um/Kconfig                                    |  53 ++++-
 arch/um/Makefile                                   |  12 +-
 arch/um/drivers/Makefile                           |   1 -
 arch/um/drivers/mmapper_kern.c                     | 135 ------------
 arch/um/drivers/virtio_uml.c                       |   4 +-
 arch/um/include/asm/current.h                      |   5 +-
 arch/um/include/asm/hardirq.h                      |  24 +-
 arch/um/include/asm/irqflags.h                     |   4 +-
 arch/um/include/asm/kasan.h                        |   4 -
 arch/um/include/asm/mmu.h                          |  10 +
 arch/um/include/asm/page.h                         |   4 -
 arch/um/include/asm/pgtable.h                      |   8 +-
 arch/um/include/asm/smp.h                          |  15 +-
 arch/um/include/asm/uaccess.h                      |   9 +-
 arch/um/include/linux/smp-internal.h               |  17 ++
 arch/um/include/linux/time-internal.h              |   3 +
 arch/um/include/shared/as-layout.h                 |   1 -
 arch/um/include/shared/common-offsets.h            |  20 --
 arch/um/include/shared/kern_util.h                 |   5 +-
 arch/um/include/shared/longjmp.h                   |   3 +-
 arch/um/include/shared/mem_user.h                  |  13 --
 arch/um/include/shared/os.h                        |  24 +-
 arch/um/include/shared/skas/mm_id.h                |   5 +
 arch/um/include/shared/skas/skas.h                 |   2 +
 arch/um/include/shared/smp.h                       |  20 ++
 arch/um/kernel/Makefile                            |   1 +
 arch/um/kernel/asm-offsets.c                       |  44 +++-
 arch/um/kernel/irq.c                               |  27 ++-
 arch/um/kernel/ksyms.c                             |   2 +-
 arch/um/kernel/mem.c                               | 111 +---------
 arch/um/kernel/physmem.c                           |  71 ------
 arch/um/kernel/process.c                           |  18 +-
 arch/um/kernel/skas/mmu.c                          |  33 ++-
 arch/um/kernel/skas/process.c                      |  19 +-
 arch/um/kernel/smp.c                               | 242 +++++++++++++++++++++
 arch/um/kernel/time.c                              |  58 +++--
 arch/um/kernel/tlb.c                               |   5 +-
 arch/um/kernel/trap.c                              |   2 +-
 arch/um/kernel/um_arch.c                           |  49 +++--
 arch/um/os-Linux/Makefile                          |   6 +-
 arch/um/os-Linux/elf_aux.c                         |  37 +---
 arch/um/os-Linux/internal.h                        |  13 ++
 arch/um/os-Linux/main.c                            |   6 +-
 arch/um/os-Linux/process.c                         |  20 ++
 arch/um/os-Linux/signal.c                          |  46 +++-
 arch/um/os-Linux/skas/process.c                    |  46 ++--
 arch/um/os-Linux/smp.c                             | 148 +++++++++++++
 arch/um/os-Linux/start_up.c                        |  54 +----
 arch/um/os-Linux/time.c                            |  78 +++++--
 arch/um/os-Linux/user_syms.c                       |   6 -
 arch/x86/um/Kconfig                                |   7 +-
 arch/x86/um/Makefile                               |   5 +-
 arch/x86/um/asm/elf.h                              |  39 +---
 arch/x86/um/asm/spinlock.h                         |   8 +
 arch/x86/um/elfcore.c                              |  78 -------
 arch/x86/um/mem_32.c                               |  50 -----
 arch/x86/um/shared/sysdep/kernel-offsets.h         |  17 --
 arch/x86/um/vdso/Makefile                          |   7 +-
 arch/x86/um/vdso/um_vdso.c                         |  30 +--
 arch/x86/um/vdso/vdso.lds.S                        |   2 -
 arch/x86/um/vdso/vma.c                             |  12 +-
 fs/hostfs/hostfs.h                                 |  34 +--
 include/asm-generic/percpu.h                       |   3 +
 64 files changed, 972 insertions(+), 865 deletions(-)
 delete mode 100644 arch/um/drivers/mmapper_kern.c
 create mode 100644 arch/um/include/linux/smp-internal.h
 delete mode 100644 arch/um/include/shared/common-offsets.h
 create mode 100644 arch/um/include/shared/smp.h
 create mode 100644 arch/um/kernel/smp.c
 create mode 100644 arch/um/os-Linux/smp.c
 create mode 100644 arch/x86/um/asm/spinlock.h
 delete mode 100644 arch/x86/um/elfcore.c
 delete mode 100644 arch/x86/um/mem_32.c
 delete mode 100644 arch/x86/um/shared/sysdep/kernel-offsets.h

