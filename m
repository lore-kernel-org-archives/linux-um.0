Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E831C25B7D
	for <linux-um@archiver.kernel.org>; Fri, 24 May 2024 21:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:Message-ID:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2EUA3J1arkoV6v7aKefqQ84Fx6SWAbJS2ETQPj87gAI=; b=tkF27suQ599bd4J0+PCkKjvbQA
	X+23RTzDWldQCfV9nRWRIWvCzwW8v0BFRYMFnwcnthtSKWCMnJzIQWVHVRFT51Idx8eRY9Pl2rDPh
	hPXgp4hpAGJYYbJhitxWcSnBS8TiIoIXn2wkRN0JTlMsYY0sdy2k5Ov1csyWr2QRflgVjhsZLHC4Y
	8Bmvw3H2ibc5drqJwD0hyx0XbmpcN2xfzAxPZNSHlwmJE2R6zmUW2WeCsrPQR4HzUR1vGUUGLseu1
	96ytMBpeRqzz7jsz6pjWdQh86xyQDXo9/QS0IrB6AUbQD0lrUvt7VDMbHY/fUIr+P82P341+ZxAy+
	O+qpQ5fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAcQl-00000009v9W-1K1z;
	Fri, 24 May 2024 21:26:27 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAcQh-00000009v8Z-4C90
	for linux-um@lists.infradead.org;
	Fri, 24 May 2024 21:26:25 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3ABEF6195FCA;
	Fri, 24 May 2024 23:26:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id cmVIACII7s2V; Fri, 24 May 2024 23:26:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C4E036195FCC;
	Fri, 24 May 2024 23:26:12 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nBDwiu23_hNP; Fri, 24 May 2024 23:26:12 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id A9C4F6195FCA;
	Fri, 24 May 2024 23:26:12 +0200 (CEST)
Date: Fri, 24 May 2024 23:26:12 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-um <linux-um@lists.infradead.org>
Message-ID: <291644210.144818.1716585972644.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for v6.10-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: xBd1AgElQDu67oKGTzsCTOWQJc5Ing==
Thread-Topic: UML changes for v6.10-rc1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_142624_353472_04D3A535 
X-CRM114-Status: UNSURE (   8.43  )
X-CRM114-Notice: Please train this message.
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

The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f=
:

  Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-=
linus-6.10-rc1

for you to fetch changes up to 919e3ece7f5aaf7b5f3c54538d5303b6eeeb053b:

  um: virtio_uml: Convert to platform remove callback returning void (2024-=
04-30 14:19:03 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Fixes for -Wmissing-prototypes warnings and further cleanup
- Remove callback returning void from rtc and virtio drivers
- Fix bash location

----------------------------------------------------------------
Duoming Zhou (1):
      um: Fix return value in ubd_init()

Johannes Berg (5):
      um: signal: move pid variable where needed
      um: slirp: remove set but unused variable 'pid'
      um: vector: fix bpfflash parameter evaluation
      um: vector: remove unused len variable/calculation
      um: process: remove unused 'n' variable

Roberto Sassu (1):
      um: Add winch to winch_handlers before registering winch IRQ

Tiwei Bie (16):
      um: Make local functions and variables static
      um: Fix the declaration of vfree
      um: Remove unused functions
      um: Fix the return type of __switch_to
      um: Add missing headers
      um: Move declarations to proper headers
      um: Fix -Wmissing-prototypes warnings for text_poke*
      um: Fix -Wmissing-prototypes warnings for __warp_* and foo
      um: Stop tracking host PID in cpu_tasks
      um: Fix -Wmissing-prototypes warnings for (rt_)sigreturn
      um: Fix the -Wmissing-prototypes warning for __switch_mm
      um: Fix the -Wmissing-prototypes warning for get_thread_reg
      um: Fix the declaration of kasan_map_memory
      um: Add an internal header shared among the user code
      um: Fix -Wmissing-prototypes warnings for __vdso_*
      um: Remove unused do_get_thread_area function

Uwe Kleine-K=C3=B6nig (2):
      um: rtc: Convert to platform remove callback returning void
      um: virtio_uml: Convert to platform remove callback returning void

Yueh-Shun Li (1):
      um: Makefile: use bash from the environment

 arch/um/Makefile                           |  2 +-
 arch/um/drivers/line.c                     | 14 ++++----
 arch/um/drivers/pcap_kern.c                |  4 +--
 arch/um/drivers/rtc_kern.c                 |  5 ++-
 arch/um/drivers/slirp_user.c               |  3 +-
 arch/um/drivers/ubd_kern.c                 |  4 +--
 arch/um/drivers/ubd_user.c                 |  2 +-
 arch/um/drivers/vector_kern.c              |  6 ++--
 arch/um/drivers/virtio_uml.c               |  5 ++-
 arch/um/include/asm/kasan.h                |  1 -
 arch/um/include/asm/mmu.h                  |  2 --
 arch/um/include/asm/processor-generic.h    |  1 -
 arch/um/include/asm/ptrace-generic.h       |  3 ++
 arch/um/include/shared/as-layout.h         |  1 -
 arch/um/include/shared/kern_util.h         |  3 ++
 arch/um/include/shared/skas/mm_id.h        |  2 ++
 arch/um/include/shared/um_malloc.h         |  2 +-
 arch/um/kernel/kmsg_dump.c                 |  2 +-
 arch/um/kernel/mem.c                       |  2 ++
 arch/um/kernel/physmem.c                   |  3 +-
 arch/um/kernel/process.c                   | 52 +++++++-------------------=
----
 arch/um/kernel/ptrace.c                    |  3 --
 arch/um/kernel/reboot.c                    |  1 +
 arch/um/kernel/skas/mmu.c                  |  1 +
 arch/um/kernel/skas/process.c              |  5 +--
 arch/um/kernel/time.c                      |  7 ++--
 arch/um/kernel/tlb.c                       |  7 +---
 arch/um/kernel/um_arch.c                   |  1 +
 arch/um/kernel/um_arch.h                   |  2 ++
 arch/um/os-Linux/drivers/ethertap_kern.c   |  2 +-
 arch/um/os-Linux/drivers/tuntap_kern.c     |  2 +-
 arch/um/os-Linux/elf_aux.c                 |  1 +
 arch/um/os-Linux/internal.h                | 20 ++++++++++++
 arch/um/os-Linux/main.c                    |  8 +++--
 arch/um/os-Linux/mem.c                     |  2 ++
 arch/um/os-Linux/signal.c                  |  4 +--
 arch/um/os-Linux/skas/mem.c                |  3 +-
 arch/um/os-Linux/skas/process.c            |  1 +
 arch/um/os-Linux/start_up.c                |  4 +--
 arch/x86/um/asm/ptrace.h                   |  6 ++++
 arch/x86/um/bugs_32.c                      |  1 +
 arch/x86/um/bugs_64.c                      |  1 +
 arch/x86/um/elfcore.c                      |  1 +
 arch/x86/um/fault.c                        |  1 +
 arch/x86/um/os-Linux/mcontext.c            |  1 +
 arch/x86/um/os-Linux/registers.c           |  2 +-
 arch/x86/um/os-Linux/tls.c                 |  1 +
 arch/x86/um/ptrace_32.c                    |  2 --
 arch/x86/um/shared/sysdep/archsetjmp.h     |  7 ++++
 arch/x86/um/shared/sysdep/kernel-offsets.h |  3 ++
 arch/x86/um/signal.c                       | 14 ++++----
 arch/x86/um/tls_32.c                       | 19 +----------
 arch/x86/um/user-offsets.c                 |  3 ++
 arch/x86/um/vdso/um_vdso.c                 | 10 ++++--
 54 files changed, 136 insertions(+), 129 deletions(-)
 create mode 100644 arch/um/os-Linux/internal.h

