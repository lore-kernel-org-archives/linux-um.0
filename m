Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AA2C4706C
	for <linux-um@archiver.kernel.org>; Sat, 13 Jan 2024 20:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:Message-ID:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gzTO+KctU/Oo5R+aMGpFM6bnejJUyAdug5yE0t9dLeU=; b=xVRggtZpuEYrmhbgPhnktpsoVW
	xxv9Pj6WI+L7RZxEn1hFwX1L7pYi6r7ohmbOztQJ5490/oIvBbDVWb/2hYs4uN+6dexie+OT5RrYb
	5yOgJ6IXqVc2moLx+xzdzSLXupFFWoqhxYEZpUA9GlH857u2Rh7aH2K5VfAFMocYWfwovxvSwluJz
	ek00fKxPU/a6sPliUenlWRr7OD/XXr+f7bjhuJSygSQiqb7nHzBQVatMGrQioH2ud1xFOuTORujBJ
	sCpcpasUu/n1hqLFUba2NwkfXDvZ4SHQLayKZt1neev3fQ2AT9FUSwz44MtnveM+FMAebTR8l+DpM
	ws3r3iYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOkm5-005fMC-0l;
	Sat, 13 Jan 2024 20:38:37 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rOkm0-005fKy-3A
	for linux-um@lists.infradead.org;
	Sat, 13 Jan 2024 20:38:34 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 6129064103FF;
	Sat, 13 Jan 2024 21:38:25 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id QIpaonAs35a3; Sat, 13 Jan 2024 21:38:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 03BA163434F8;
	Sat, 13 Jan 2024 21:38:25 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Y492wK1HQJKy; Sat, 13 Jan 2024 21:38:24 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id E13A164103FF;
	Sat, 13 Jan 2024 21:38:24 +0100 (CET)
Date: Sat, 13 Jan 2024 21:38:24 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <618175332.231559.1705178304902.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML updates for v6.8-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: idAAwHz3fxN2fDnKC6CSXjTnRbLUJQ==
Thread-Topic: UML updates for v6.8-rc1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240113_123833_349901_5CEF18E6 
X-CRM114-Status: UNSURE (   8.08  )
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

The following changes since commit 861deac3b092f37b2c5e6871732f3e11486f7082=
:

  Linux 6.7-rc7 (2023-12-23 16:25:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/uml-for-=
linus-6.8-rc1

for you to fetch changes up to 83aec96c631e0fa75cfe6d6a1b113a32151aaa88:

  um: Mark 32bit syscall helpers as clobbering memory (2024-01-05 16:28:57 =
+0100)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Clang coverage support
- Many cleanups from Benjamin Berg
- Various minor fixes

----------------------------------------------------------------
Anton Ivanov (2):
      um: Fix naming clash between UML and scheduler
      um: document arch_futex_atomic_op_inuser

Benjamin Berg (11):
      um: Drop support for hosts without SYSEMU_SINGLESTEP support
      um: Drop NULL check from start_userspace
      um: Make errors to stop ptraced child fatal during startup
      um: Don't use vfprintf() for os_info()
      um: Do not use printk in SIGWINCH helper thread
      um: Reap winch thread if it fails
      um: Do not use printk in userspace trampoline
      um: Always inline stub functions
      um: Rely on PTRACE_SETREGSET to set FS/GS base registers
      um: Remove unused register save/restore functions
      um: Mark 32bit syscall helpers as clobbering memory

Johannes Berg (2):
      um: mmu: remove stub_pages
      um: time-travel: fix time corruption

Micha=C5=82 Winiarski (2):
      arch: um: Add Clang coverage support
      Documentation: kunit: Add clang UML coverage example

Nathan Chancellor (1):
      um: net: Fix return type of uml_net_start_xmit()

Vincent Whitchurch (1):
      um: virt-pci: fix platform map offset

 Documentation/dev-tools/kunit/running_tips.rst |  11 +++
 arch/um/Makefile-skas                          |   5 ++
 arch/um/drivers/chan_user.c                    |  42 +++++----
 arch/um/drivers/line.c                         |  13 +--
 arch/um/drivers/net_kern.c                     |   2 +-
 arch/um/drivers/virt-pci.c                     |   2 +-
 arch/um/include/asm/mmu.h                      |   1 -
 arch/um/include/asm/processor-generic.h        |   1 -
 arch/um/include/shared/kern_util.h             |   5 +-
 arch/um/include/shared/os.h                    |   3 -
 arch/um/include/shared/ptrace_user.h           |  41 ---------
 arch/um/include/shared/registers.h             |   2 -
 arch/um/kernel/process.c                       |  14 +--
 arch/um/kernel/ptrace.c                        |   2 -
 arch/um/kernel/signal.c                        |  12 ---
 arch/um/kernel/skas/uaccess.c                  |   4 +-
 arch/um/kernel/time.c                          |  32 +++++--
 arch/um/os-Linux/helper.c                      |   6 +-
 arch/um/os-Linux/registers.c                   |  20 -----
 arch/um/os-Linux/skas/process.c                | 117 ++++++++-------------=
----
 arch/um/os-Linux/start_up.c                    | 111 ++++-----------------=
--
 arch/um/os-Linux/util.c                        |  19 +++-
 arch/x86/um/asm/elf.h                          |   4 +-
 arch/x86/um/asm/processor_64.h                 |   3 -
 arch/x86/um/os-Linux/Makefile                  |   1 -
 arch/x86/um/os-Linux/prctl.c                   |  12 ---
 arch/x86/um/ptrace_32.c                        |  24 -----
 arch/x86/um/ptrace_64.c                        |  26 ------
 arch/x86/um/shared/sysdep/ptrace_32.h          |   4 -
 arch/x86/um/shared/sysdep/ptrace_user.h        |  12 ++-
 arch/x86/um/shared/sysdep/stub_32.h            |  39 +++++----
 arch/x86/um/shared/sysdep/stub_64.h            |  17 ++--
 arch/x86/um/syscalls_64.c                      |  62 +++----------
 arch/x86/um/tls_64.c                           |   2 +-
 34 files changed, 212 insertions(+), 459 deletions(-)
 delete mode 100644 arch/x86/um/os-Linux/prctl.c

