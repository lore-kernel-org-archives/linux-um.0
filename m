Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7497AE8B383
	for <linux-um@archiver.kernel.org>; Wed,  4 Feb 2026 02:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kJkMVLe2+DCycBWmWyFKZjZwsfNmF8nUVM1iT9rHo9s=; b=I0FVfPV//TZWn09V1xGMy1lEkS
	8/MGVJi3LPDMH/d+qvDKhA22DrjWeaOfAXI4Y08tHMmqYCtbu5qhKpWeRcjRRCM/KWNC3RzXbwQYM
	PCE0lVwhvqpEEoMiTndAv9pfIZkcEE8CSMyVF8SQXnH6snm/PTuUDOFTs+++lHSwUjaep+Tn26hEe
	SEvyxuh9gh2QsfBSoUrOSLKoyOkx8VsZc/3DrW44uVqPvpHPsMXJbht165cH+BWg6NssU+b3EZN4V
	Zh6AN1M4Vy4amNvmmpk0hwmN5ihLOivujOCuENxollx20iHHEmSRs96WplkoUe+qPOWcqlOMI6KWU
	KF1L9VVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnScv-00000007m2U-3A3o;
	Wed, 04 Feb 2026 02:28:21 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnSct-00000007m1b-2POm
	for linux-um@lists.infradead.org;
	Wed, 04 Feb 2026 02:28:20 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2a09d981507so2834235ad.1
        for <linux-um@lists.infradead.org>; Tue, 03 Feb 2026 18:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770172098; x=1770776898; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kJkMVLe2+DCycBWmWyFKZjZwsfNmF8nUVM1iT9rHo9s=;
        b=ldClhlna3EzFTzXjCptUcVmFu6tjo/FG2Z0ViFjqVD6OO6rrG0jlT53ga/Yz71bTqB
         4fyBRiQJzuyN+vCb6ilXE9dbpW39TXpXhG/AtqNc+dIwEB6Ij7Fa6I/hBA69gXlfSaUE
         XPoqXZ9YN0Q/Tn0qn7V7quc0g7OyKRvF8ucsjb9QvP5KnPcrEQ0DxYQVyZPsyw6Wc8fb
         KgdZw1p3mo9E4xQSCcB9APQ+wFklYJ+8JRgbHz3uxuTl0oX+vBqS8TOUOAoLRRfhUDaM
         5/728hFuEGH5gg2RhcEemhd0xjh0kbFUAtUPl5e2EW2S4Lv8apeu5BGyZNAi0dZ6rNyP
         5Qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770172098; x=1770776898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJkMVLe2+DCycBWmWyFKZjZwsfNmF8nUVM1iT9rHo9s=;
        b=RO24uuegYAtZzsWcJzT6+KmlnUTt8C2NuGekxF8R4ue6BGFtV1AUT0vXJ+cyaXzg+W
         EnkUwOjQH87ATutgav45IY2Bbznr+ApwLixT5ABQscBnlmzUo/funNXBoVjBWq21Ql2V
         LA4UPzHkHheqDM90Dqx7idBRZJVYdq+4eqMRUMy6tj9E1lPbfwQW+Uh3uP4Pp9Uv5I2T
         YLfa3yrSE5QxiFW6J+M3ZPrZpjVefHi5S6TmsQGhIO6JOYHCeKuePuh08B524qu625Kr
         5DagTTg74W5CDm1ZHuBlQap/zZie6FLZp9t6Wh3vrC4C3m2njMbu2QpSgY+xp7FrT8qr
         zGZQ==
X-Gm-Message-State: AOJu0YwZbWBH9wFWjqDhe/TfbytalN9D2fgY7JFLQACxJXWXt1dJCy7Y
	yBRjWRq05wFWpyUOcAFmUilnNwmvTfcrx1xSfbcqSiiL2sbHVb5h1Bh0
X-Gm-Gg: AZuq6aKAZ1plthOxn03eSGjJCQm6WGGBt29Hrhzw8I6CXd/oPBk6s2gN68ATmxM3R0t
	sQNnkmvKSHS2SUVn2kfB2uwl3tX/1EpAJ56AiQ32Fyzze0LA7lhwsqwypGpkUuqgVTSTAfFewGv
	MdHTUQobYCO12yHwPODy1N8lumA0yqEl5eHHEzINnUANUTvqicmu7i8gq3XgabH7qIF2A5t9oVV
	9WUnLqXdLDDVQLGcPvv5VfZVwJg0bxcJ6i3BLElr21xq/G112sX7G6ZbFUSHPZs/x0PH9LGwbdW
	/r9oIUaw79445uj2Bd1KS9yMcqO26bhuEyd3ETT1sv+TOWS/jHSwK2fgnGTr5l3ELVbORd2zHr1
	OOO20PY+VtT2ZHbOhbJTyVgkjD7tYIUtinVUJy7yf2tH+ONMhneiZVa79w6KKJvZabZHw013VmC
	Oho6k8Df1RkT9JpSAR5NgtqAoENUxY6AN3HxrfNj8OITbCnbhEReiInAIx/IrIiIlPKLyiw00+j
	2giUeGrMijbb+43
X-Received: by 2002:a17:903:3a8b:b0:2a8:ec3c:f326 with SMTP id d9443c01a7336-2a93397caadmr13191305ad.21.1770172098145;
        Tue, 03 Feb 2026 18:28:18 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933870b22sm7091985ad.26.2026.02.03.18.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 18:28:17 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id A8D2D1200C2F; Wed,  4 Feb 2026 11:28:15 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v14 00/13] nommu UML
Date: Wed,  4 Feb 2026 11:27:58 +0900
Message-ID: <cover.1770170302.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_182819_620970_DFFCC5B2 
X-CRM114-Status: GOOD (  23.58  )
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

This patchset is another spin of nommu mode addition to UML.  It would
be nice to hear about your opinions on that.

UML has been built with CONFIG_MMU since day 0.  The patchset
introduces the nommu mode on UML in a different angle in order to
cover broader code to be executed over UML.

More details are in the document which are included in this patchset.

There are still several limitations/issues which we already found;
here is the list of those issues.

- memory mapped by loadable modules are not distinguished from
  userspace memory.
- CONFIG_SMP is disabled as host_fs handling doesn't work with thread
  local storage.

-- Hajime

v14:
- rebase with the latest uml/next branch
- clean up fs register manipulation code ([07/13])
- fix compilation issue when time-travel mode is enabled ([02/13])
- refresh document to clarify the goals ([12/13])

v13:
- rebase with the latest uml/next branch, fixing a conflict ([06/13])
- https://lore.kernel.org/all/cover.1762588860.git.thehajime@gmail.com/

v12:
- rebase with the latest uml/next branch
- disable SMP and tls as those doesn't work with host_fs handling ([11/13])
- https://lore.kernel.org/all/cover.1762075876.git.thehajime@gmail.com/

v11:
- clean up userspace return routine and integrate to userspace() ([04/13])
- fix direction flag issue on using nolibc memcpy ([04/13])
- fix a crash issue when using usermode helper ([06/13])
- test with out-of-tree kunit-uapi patches (which uses umh)
 - https://lore.kernel.org/all/20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de/
 - https://lore.kernel.org/all/20250626195714.2123694-3-benjamin@sipsolutions.net/
- https://lore.kernel.org/all/cover.1758181109.git.thehajime@gmail.com/

v10:
- fix wrong comment on gs register handling ([09/13])
- remove unnecessary code of early syscall implementation ([04/13])
- https://lore.kernel.org/all/cover.1750594487.git.thehajime@gmail.com/

v9:
- rebase with the latest uml/next branch
- add performance numbers of new SECCOMP mode, and update results ([12/13])
- add a workaround for upstream change on MMU depedency to PCI drivers ([10/13])
- https://lore.kernel.org/all/cover.1750294482.git.thehajime@gmail.com/

v8:
- rebase with the latest uml/next branch
- clean up segv_handler to align with the latest uml ([9/12])
- https://lore.kernel.org/all/cover.1745980082.git.thehajime@gmail.com/

v7:
- properly handle FP register upon signal delivery [10/13]
- update benchmark result with new FP register handling [12/13]
- fix arch_has_single_step() for !MMU case [07/13]
- revert stack alignment as it is in uml/fixes tree [10/13]
- https://lore.kernel.org/all/cover.1737348399.git.thehajime@gmail.com/

v6:
- rebase to the latest uml/next tree
- more clean up on mmu/nommu for signal handling [10/13]
- rename functions of mcontext routines [06,10/13]
- added Acked-by tag for binfmt_elf_fdpic [02/13]
- https://lore.kernel.org/linux-um/cover.1736853925.git.thehajime@gmail.com/

v5:
- clean up stack manipulation code [05,06,07,10/13]
- https://lore.kernel.org/linux-um/cover.1733998168.git.thehajime@gmail.com/

v4:
- add arch/um/nommu, arch/x86/um/nommu to contain !MMU specific codes
- remove zpoline patch
- drop binfmt_elf_fdpic patch
- reduce ifndef CONFIG_MMU if possible
- split to elf header cleanup patch [01/13]
- fix kernel test robot warnings [06/13]
- fix coding styles [07/13]
- move task_top_of_stack definition [05/13]
- https://lore.kernel.org/linux-um/cover.1733652929.git.thehajime@gmail.com/

v3:
- https://lore.kernel.org/linux-um/cover.1733199769.git.thehajime@gmail.com/
- add seccomp-based syscall hook in addition to zpoline [06/13]
- remove RFC, add a line to MAINTAINERS file
- fix kernel test robot warnings [02/13,08/13,10/13]
- add base-commit tag to cover letter
- pull the latest uml/next
- clean up SIGSEGV handling [10/13]
- detect fsgsbase availability with elf aux vector [08/13]
- simplify vdso code with macros [09/13]

RFC v2:
- https://lore.kernel.org/linux-um/cover.1731290567.git.thehajime@gmail.com/
- base branch is now uml/linux.git instead of torvalds/linux.git.
- reorganize the patch series to clean up
- fixed various coding styles issues
- clean up exec code path [07/13]
- fixed the crash/SIGSEGV case on userspace programs [10/13]
- add seccomp filter to limit syscall caller address [06/13]
- detect fsgsbase availability with sigsetjmp/siglongjmp [08/13]
- removes unrelated changes
- removes unneeded ifndef CONFIG_MMU
- convert UML_CONFIG_MMU to CONFIG_MMU as using uml/linux.git
- proposed a patch of maple-tree issue (resolving a limitation in RFC v1)
  https://lore.kernel.org/linux-mm/20241108222834.3625217-1-thehajime@gmail.com/

RFC:
- https://lore.kernel.org/linux-um/cover.1729770373.git.thehajime@gmail.com/

Hajime Tazaki (13):
  x86/um: nommu: elf loader for fdpic
  um: decouple MMU specific code from the common part
  um: nommu: memory handling
  x86/um: nommu: syscall handling
  um: nommu: seccomp syscalls hook
  x86/um: nommu: process/thread handling
  um: nommu: configure fs register on host syscall invocation
  x86/um/vdso: nommu: vdso memory update
  x86/um: nommu: signal handling
  um: change machine name for uname output
  um: nommu: disable SMP on nommu UML
  um: nommu: add documentation of nommu UML
  um: nommu: plug nommu code into build system

 Documentation/virt/uml/nommu-uml.rst   | 181 ++++++++++++++++++++++
 MAINTAINERS                            |   1 +
 arch/um/Kconfig                        |  14 +-
 arch/um/Makefile                       |  10 ++
 arch/um/configs/x86_64_nommu_defconfig |  54 +++++++
 arch/um/include/asm/futex.h            |   4 +
 arch/um/include/asm/mmu.h              |   8 +
 arch/um/include/asm/mmu_context.h      |   2 +
 arch/um/include/asm/ptrace-generic.h   |   8 +-
 arch/um/include/asm/uaccess.h          |   7 +-
 arch/um/include/shared/kern_util.h     |   6 +
 arch/um/include/shared/os.h            |  16 ++
 arch/um/kernel/Makefile                |   5 +-
 arch/um/kernel/mem-pgtable.c           |  55 +++++++
 arch/um/kernel/mem.c                   |  38 +----
 arch/um/kernel/process.c               |  38 +++++
 arch/um/kernel/skas/process.c          |  37 -----
 arch/um/kernel/um_arch.c               |   3 +
 arch/um/nommu/Makefile                 |   3 +
 arch/um/nommu/os-Linux/Makefile        |   7 +
 arch/um/nommu/os-Linux/seccomp.c       |  87 +++++++++++
 arch/um/nommu/os-Linux/signal.c        |  24 +++
 arch/um/nommu/trap.c                   | 201 +++++++++++++++++++++++++
 arch/um/os-Linux/Makefile              |   3 +-
 arch/um/os-Linux/internal.h            |   8 +
 arch/um/os-Linux/mem.c                 |   4 +
 arch/um/os-Linux/process.c             | 139 ++++++++++++++++-
 arch/um/os-Linux/signal.c              |  11 +-
 arch/um/os-Linux/skas/process.c        | 128 +---------------
 arch/um/os-Linux/start_up.c            |  25 ++-
 arch/um/os-Linux/util.c                |   3 +-
 arch/x86/um/Kconfig                    |   2 +-
 arch/x86/um/Makefile                   |   4 +
 arch/x86/um/asm/elf.h                  |   8 +-
 arch/x86/um/asm/syscall.h              |   6 +
 arch/x86/um/nommu/Makefile             |   8 +
 arch/x86/um/nommu/do_syscall_64.c      |  49 ++++++
 arch/x86/um/nommu/entry_64.S           | 114 ++++++++++++++
 arch/x86/um/nommu/os-Linux/Makefile    |   6 +
 arch/x86/um/nommu/os-Linux/mcontext.c  |  26 ++++
 arch/x86/um/nommu/syscalls.h           |  19 +++
 arch/x86/um/nommu/syscalls_64.c        |  86 +++++++++++
 arch/x86/um/shared/sysdep/mcontext.h   |   5 +
 arch/x86/um/shared/sysdep/ptrace.h     |   2 +-
 arch/x86/um/syscalls_64.c              |   2 +-
 arch/x86/um/vdso/vma.c                 |  17 ++-
 fs/Kconfig.binfmt                      |   2 +-
 47 files changed, 1263 insertions(+), 223 deletions(-)
 create mode 100644 Documentation/virt/uml/nommu-uml.rst
 create mode 100644 arch/um/configs/x86_64_nommu_defconfig
 create mode 100644 arch/um/kernel/mem-pgtable.c
 create mode 100644 arch/um/nommu/Makefile
 create mode 100644 arch/um/nommu/os-Linux/Makefile
 create mode 100644 arch/um/nommu/os-Linux/seccomp.c
 create mode 100644 arch/um/nommu/os-Linux/signal.c
 create mode 100644 arch/um/nommu/trap.c
 create mode 100644 arch/x86/um/nommu/Makefile
 create mode 100644 arch/x86/um/nommu/do_syscall_64.c
 create mode 100644 arch/x86/um/nommu/entry_64.S
 create mode 100644 arch/x86/um/nommu/os-Linux/Makefile
 create mode 100644 arch/x86/um/nommu/os-Linux/mcontext.c
 create mode 100644 arch/x86/um/nommu/syscalls.h
 create mode 100644 arch/x86/um/nommu/syscalls_64.c


base-commit: 68e25613ed4d06c987a42b0589f54ce88c13477c
-- 
2.43.0


