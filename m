Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF66BD735E5
	for <linux-um@archiver.kernel.org>; Fri, 29 Nov 2024 23:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:Message-ID:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eoxiM+cssfgQmROf7iDjv6Z5SOtmqu+FvdSnjJju9Tg=; b=3BXIAdz+GZLt9RU7BcvXFXkxZ8
	ExPToD2yBB7Td/J/FCzCTQVOhFmt58si/6sX/pe7Ckkz0cB3CqslpA1tr8qOmKZJQ44f7h/S2is8s
	FHo3jVFRGCQNqzzLri9iXb5OcfyQGrH/VgHq0CaWukbjX5LTy9p+rtjr/EcPkmh6Cv4F06rnc6MOn
	osOXSb/ZxoflxQ1iTgIDsDi7IPBBisaW/QES6SYG3bSo0BTpTPGaapZ8AM2LGYrbGjLJa4Ind6UPx
	z15L1K7UhzxbUiYflOVBc/qmAckk2+UdWIoLhNiZqdursai23Bhm10YG3uEZCH2xb1RUqL3E76BeL
	GlSJdVdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tHA4A-000000014sI-2DsX;
	Fri, 29 Nov 2024 23:06:26 +0000
Received: from mailout.nod.at ([116.203.167.152] helo=lithops.sigma-star.at)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tHA47-000000014rg-2MXt
	for linux-um@lists.infradead.org;
	Fri, 29 Nov 2024 23:06:24 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2BFC22F3325;
	Sat, 30 Nov 2024 00:06:22 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 5pBWlA9SbUrQ; Sat, 30 Nov 2024 00:06:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 864622F3327;
	Sat, 30 Nov 2024 00:06:21 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nkZMIfBnR2Fx; Sat, 30 Nov 2024 00:06:21 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5E2EF2F3325;
	Sat, 30 Nov 2024 00:06:21 +0100 (CET)
Date: Sat, 30 Nov 2024 00:06:21 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1155823186.11802667.1732921581257.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for v6.13-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF133 (Linux)/8.8.12_GA_3809)
Thread-Index: gf7mK4lP8xbhHza8ouj6OwxcU1Y1gA==
Thread-Topic: UML changes for v6.13-rc1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_150623_890892_54503723 
X-CRM114-Status: GOOD (  12.58  )
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

Linus,

The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b=
:

  Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-=
linus-6.13-rc1

for you to fetch changes up to bed2cc482600296fe04edbc38005ba2851449c10:

  hostfs: Fix the NULL vs IS_ERR() bug for __filemap_get_folio() (2024-11-1=
5 20:55:32 +0100)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Lots of cleanups, mostly from Benjamin Berg and Tiwei Bie
 - Removal of unused code
 - Fix for sparse warnings
 - Cleanup around stub_exe()

----------------------------------------------------------------
Benjamin Berg (30):
      um: Remove unused os_process_pc
      um: Remove unused os_process_parent
      um: Remove unused os_stop_process
      um: Remove unused os_getpgrp function
      um: Set HAVE_EFFICIENT_UNALIGNED_ACCESS for x86
      um: always use the internal copy of the FP registers
      um: remove auxiliary FP registers
      um: Add generic stub_syscall1 function
      um: use execveat to create userspace MMs
      um: Set parent death signal for userspace process
      um: Set parent death signal for winch thread/process
      um: Add compile time assert that stub fits on a page
      um: Calculate stub data address relative to stub code
      um: Limit TASK_SIZE to the addressable range
      um: Discover host_task_size from envp
      um: clear all memory in new userspace processes
      um: Switch to 4 level page tables on 64 bit
      um: insert scheduler ticks when userspace does not yield
      um: switch to regset API and depend on XSTATE
      um: fix sparse warnings from regset refactor
      um: fix sparse warnings in signal code
      um: set DONTDUMP and DONTFORK flags on KASAN shadow memory
      um: always include kconfig.h and compiler-version.h
      um: remove file sync for stub data
      um: remove duplicate UM_NSEC_PER_SEC definition
      um: remove broken double fault detection
      um: virtio_uml: send SET_MEM_TABLE message with the exact size
      um: virtio_uml: fix call_fd IRQ allocation
      um: virtio_uml: query the number of vqs if supported
      um: move thread info into task

David Gow (1):
      um: Fix misaligned stack in stub_exe

Johannes Berg (5):
      um: make stub_exe _start() pure inline asm
      um: restore process name
      um: remove fault_catcher infrastructure
      um: remove PATH_MAX use
      um: fix stub exe build with CONFIG_GCOV

Masahiro Yamada (1):
      um: remove dependency on undefined CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS

Nathan Chancellor (2):
      um: Fix passing '-n' to linker for stub_exe
      um: Disable auto variable initialization for stub_exe.c

Shaojie Dong (1):
      um: Remove double zero check

Thomas Wei=C3=9Fschuh (1):
      um: vdso: Always reject undefined references in during linking

Tiwei Bie (26):
      um: Remove the redundant declaration of high_physmem
      um: Fix potential integer overflow during physmem setup
      um: Remove highmem leftovers
      um: Fix the definition for physmem_size
      um: Fix the return value of elf_core_copy_task_fpregs
      um: Remove 3-level page table support on i386
      um: Remove UML specific debug parameter
      um: Do not propagate mem parameter to kernel
      um: Do not propagate uml_dir parameter to kernel
      um: Do not propagate dtb parameter to kernel
      um: Do not propagate noreboot parameter to kernel
      hostfs: Do not propagate hostfs parameter to kernel
      um: hostaudio: Do not propagate dsp parameter to kernel
      um: hostaudio: Do not propagate mixer parameter to kernel
      um: Do not propagate initrd parameter to kernel
      um: Abandon the _PAGE_NEWPROT bit
      um: Rename _PAGE_NEWPAGE to _PAGE_NEEDSYNC
      um: Add os_set_pdeathsig helper function
      um: Set parent-death signal for ubd io thread/process
      um: Set parent-death signal for write_sigio thread/process
      um: Use os_set_pdeathsig helper in winch thread/process
      um: ubd: Initialize ubd's disk pointer in ubd_add
      um: ubd: Do not use drvdata in release
      um: net: Do not use drvdata in release
      um: vector: Do not use drvdata in release
      um: Always dump trace for specified task in show_stack

ZhangPeng (1):
      hostfs: Fix the NULL vs IS_ERR() bug for __filemap_get_folio()

 arch/um/Kconfig                                    |  24 +-
 arch/um/Makefile                                   |   7 +-
 arch/um/Makefile-skas                              |  14 +-
 arch/um/configs/i386_defconfig                     |   1 -
 arch/um/drivers/chan_user.c                        |   2 +
 arch/um/drivers/hostaudio_kern.c                   |   2 +
 arch/um/drivers/net_kern.c                         |   2 +-
 arch/um/drivers/ubd_kern.c                         |   5 +-
 arch/um/drivers/vector_kern.c                      |   3 +-
 arch/um/drivers/vhost_user.h                       |   4 +-
 arch/um/drivers/virtio_uml.c                       |  51 +++-
 arch/um/include/asm/Kbuild                         |   1 -
 arch/um/include/asm/current.h                      |  23 ++
 arch/um/include/asm/page.h                         |  34 +--
 arch/um/include/asm/pgalloc.h                      |  11 +-
 arch/um/include/asm/pgtable-2level.h               |   2 +-
 .../asm/{pgtable-3level.h =3D> pgtable-4level.h}     |  59 ++--
 arch/um/include/asm/pgtable.h                      |  83 ++---
 arch/um/include/asm/processor-generic.h            |   7 +-
 arch/um/include/asm/thread_info.h                  |  18 --
 arch/um/include/asm/tlbflush.h                     |   4 +-
 arch/um/include/shared/as-layout.h                 |  10 +-
 arch/um/include/shared/common-offsets.h            |  15 -
 arch/um/include/shared/kern_util.h                 |   1 -
 arch/um/include/shared/mem_user.h                  |   5 +-
 arch/um/include/shared/os.h                        |  15 +-
 arch/um/include/shared/registers.h                 |   6 -
 arch/um/include/shared/skas/stub-data.h            |  12 +-
 arch/um/include/shared/timetravel.h                |   5 +-
 arch/um/include/shared/user.h                      |   2 +-
 arch/um/kernel/dtb.c                               |   1 +
 arch/um/kernel/dyn.lds.S                           |   5 +-
 arch/um/kernel/initrd.c                            |   1 +
 arch/um/kernel/irq.c                               | 112 -------
 arch/um/kernel/mem.c                               |  20 +-
 arch/um/kernel/physmem.c                           |  39 +--
 arch/um/kernel/process.c                           |  24 +-
 arch/um/kernel/skas/.gitignore                     |   2 +
 arch/um/kernel/skas/Makefile                       |  38 ++-
 arch/um/kernel/skas/mmu.c                          |  28 +-
 arch/um/kernel/skas/process.c                      |   4 +-
 arch/um/kernel/skas/stub.c                         |  10 -
 arch/um/kernel/skas/stub_exe.c                     |  95 ++++++
 arch/um/kernel/skas/stub_exe_embed.S               |  11 +
 arch/um/kernel/sysrq.c                             |   8 +-
 arch/um/kernel/time.c                              |  20 ++
 arch/um/kernel/tlb.c                               |  74 ++---
 arch/um/kernel/trap.c                              |  16 -
 arch/um/kernel/um_arch.c                           |  75 ++---
 arch/um/kernel/uml.lds.S                           |   2 -
 arch/um/os-Linux/Makefile                          |   2 +
 arch/um/os-Linux/file.c                            |   6 -
 arch/um/os-Linux/main.c                            |  23 +-
 arch/um/os-Linux/mem.c                             |  14 +-
 arch/um/os-Linux/process.c                         |  88 +-----
 arch/um/os-Linux/registers.c                       |  11 +-
 arch/um/os-Linux/sigio.c                           |   1 +
 arch/um/os-Linux/signal.c                          |  55 +---
 arch/um/os-Linux/skas/mem.c                        |  21 --
 arch/um/os-Linux/skas/process.c                    | 231 +++++++++-----
 arch/um/os-Linux/umid.c                            |   2 +
 arch/um/os-Linux/util.c                            |   4 +-
 arch/x86/um/Kconfig                                |  12 +-
 arch/x86/um/Makefile                               |   2 +-
 arch/x86/um/asm/elf.h                              |   2 +
 arch/x86/um/asm/ptrace.h                           |  10 +
 arch/x86/um/os-Linux/Makefile                      |   2 +-
 arch/x86/um/os-Linux/registers.c                   | 145 +++------
 arch/x86/um/os-Linux/task_size.c                   | 151 ---------
 arch/x86/um/ptrace.c                               | 267 ++++++++++++++++
 arch/x86/um/ptrace_32.c                            |  84 ++----
 arch/x86/um/ptrace_64.c                            |  43 +--
 arch/x86/um/shared/sysdep/ptrace.h                 |   8 +-
 arch/x86/um/shared/sysdep/ptrace_32.h              |   4 -
 arch/x86/um/shared/sysdep/ptrace_64.h              |   4 -
 arch/x86/um/shared/sysdep/ptrace_user.h            |   6 -
 arch/x86/um/shared/sysdep/stub_32.h                |  18 +-
 arch/x86/um/shared/sysdep/stub_64.h                |  27 +-
 arch/x86/um/signal.c                               | 336 +++++++----------=
----
 arch/x86/um/user-offsets.c                         |   8 -
 arch/x86/um/vdso/Makefile                          |   5 +-
 arch/x86/um/vdso/checkundef.sh                     |  11 -
 fs/hostfs/hostfs_kern.c                            |   5 +-
 83 files changed, 1227 insertions(+), 1394 deletions(-)
 create mode 100644 arch/um/include/asm/current.h
 rename arch/um/include/asm/{pgtable-3level.h =3D> pgtable-4level.h} (60%)
 create mode 100644 arch/um/kernel/skas/.gitignore
 create mode 100644 arch/um/kernel/skas/stub_exe.c
 create mode 100644 arch/um/kernel/skas/stub_exe_embed.S
 delete mode 100644 arch/x86/um/os-Linux/task_size.c
 create mode 100644 arch/x86/um/ptrace.c
 delete mode 100644 arch/x86/um/vdso/checkundef.sh

