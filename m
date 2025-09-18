Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1518CAC59A
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 05:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Q5V8UEUER87fn48X10+kB+MMWv7ifqYEY+xUtS9BYOU=; b=W8kCIa9nHGAMMcQ59j9dWXFIRT
	i6skpkdo1x2wbALAKx0z+jsxYdwMbvaKOEiYoWep6ICfOYxlMqI0P3P63p4hqMXIPaVEmO8FJckkH
	7H1xCy1EnYM1CVMg5VxQ1rADlD4oaC5ana70TBP7aHpL+xYQDifbE7uUHubCKvf05WtSbpF1f+Rpa
	khZfpWszMxGkt7ZiKR+guEm4Hq97dqlLRdrsZQ4DNL7U+DyJaJPRdX5fJUDNBQ3VbLBMNbAw/6ay6
	EUf5s2AU2DgbCt8MFmytaXQdcI6nUzz/nhLUToisrJgEA9XKNEgmzbgBApfsoNSO/ncjVU+bWxbQ2
	2v9FWjAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70Q-0000000GI5m-21OP;
	Thu, 18 Sep 2025 05:16:30 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70L-0000000GI35-1Bda
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 05:16:29 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-b54d23714adso400010a12.0
        for <linux-um@lists.infradead.org>; Wed, 17 Sep 2025 22:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172583; x=1758777383; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5V8UEUER87fn48X10+kB+MMWv7ifqYEY+xUtS9BYOU=;
        b=CTrY+G/d26Z+cwnM4nk+YQJiwOHZyNDL5dETMNPjgHBZc/LSZhfmNEYM/Eurwu8OO6
         VjYglS8N+vWR9ueg89/PAWO2O1y52GPY+Qn2n3KF3aQt5HyLPOj5XMOPPnOJcCNPxlDh
         m3Gzyivk8A6xezCoqaJCL/0yvzDbf8P8himIgTm0xwAgpZgw4J9i7WTL67tslw6FR0Bd
         Wm4BwYY0iKSoVZNwa3OZ/7y7hdpAZlWdTQe4BaZ5mDS0mrSXhN0Em3cc6Oy7+4JDrj6B
         CNBVKzFE0XFQRTHtHQIWesLxe8uEc8+vYhmxCcUGjPj6kgGk1eDm/Ztf1NDYHT+6So+W
         mJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172583; x=1758777383;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5V8UEUER87fn48X10+kB+MMWv7ifqYEY+xUtS9BYOU=;
        b=WwlqfpKyM8Pq7WzxNcJfq5ba6rYM2bPXoR4n0HFTxKP+lixoF2hE5YiN2r8Vynnnu4
         Xyz/X1s2817aJBWzm/cnK/Wt92RY1YXNzIL5lYypm8XWwrYJmrReyUQZ3oE66l1LHn5Y
         1o1IMwQi4wHvUFRMvnlt0+RCyOpisMzL+jx+JlLa+3o8gDi+yZwlfNtvw0LBthFpDj+Z
         pC2LhPUTVVIETV40NQWetCZLI4pEACXKch33ApG7V6LOUD14Th3sizZou1MgRDNGtray
         UnVMK7YNhXCnIMtGz9AQJWtDyo74PRpYl7o6o6HBu2HY3FZ/6nDyY+HTFpwJhul8bQXq
         qfZw==
X-Gm-Message-State: AOJu0YyovFWMIGsVc9OYBzBqoJF8ljpnidpp5ffzaBNWHvoivEwe86Vy
	T/TWniqoswrFddEULCcyyKU+3KJsua4V43F0eHt3jP5Umdh8r7qVXxcN
X-Gm-Gg: ASbGncvaBQytyJ+EyZoC5chJv7TVE1CYKIxVeC36RWXmjz8kAHbhjDAJ5O+1+WDDQia
	gZUdyocRExs/A7tu1ZQIJmvUi8HeKJ2kd8NGwAZ3FySazTHBTzt9TazO6T9PL8TJK1At933npnd
	ShzMmQpa31VkhS+DdOKsKOuWmpCwq9ja5vzuQtTPRIaa0Ywo5ZFG8pi0Mpcis0XhzljHSTQFZ6M
	TgQFqfAvUuArAGPRfJY0KmAdleYuGFBVlog9rjDvV7XAOuK6wBlqRGCjVQbPedqmwrsZo2du75C
	LnJL7kEqjgCuu7MCHewEhq2uIGPohdDTkmV7/fK6z2g6ZmOt+uWXpZtabUUERtpIb0KxoCkm8nq
	aK6Vm0Ie1vUpeCZhTDqs0j/My0DUyIuxmwhu7Rdof3ERnq2GuaABb4xxnuNC0+WGOxSh1UV6Wec
	JpgbsddbxJTTUO+S8+TJ/DRQ==
X-Google-Smtp-Source: AGHT+IExqSlvopxdnNEELLzMkxZ5Iirbo+6+7otHyx0171ZVf2y29k669aNGN8l6ZT7IPTg8xoTibg==
X-Received: by 2002:a17:903:3d10:b0:24b:1585:6350 with SMTP id d9443c01a7336-2697c82d7e6mr28125565ad.11.1758172583013;
        Wed, 17 Sep 2025 22:16:23 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698019821dsm12852045ad.64.2025.09.17.22.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:22 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 525141061EE0; Thu, 18 Sep 2025 14:16:15 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 00/14] nommu UML
Date: Thu, 18 Sep 2025 14:15:53 +0900
Message-ID: <cover.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_221625_329235_683C753A 
X-CRM114-Status: GOOD (  21.86  )
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

There are still several limitations/issues which we already found;
here is the list of those issues.

- memory mapped by loadable modules are not distinguished from
  userspace memory.

-- Hajime

v11:
- clean up userspace return routine and integrate to userspace() ([04/13])
- fix direction flag issue on using nolibc memcpy ([04/13])
- fix a crash issue when using usermode helper ([06/13])
- test with out-of-tree kunit-uapi patches (which uses umh)
 - https://lore.kernel.org/all/20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de/
 - https://lore.kernel.org/all/20250626195714.2123694-3-benjamin@sipsolutions.net/

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

Hajime Tazaki (14):
  x86/um: nommu: elf loader for fdpic
  um: decouple MMU specific code from the common part
  um: nommu: memory handling
  x86/um: nommu: syscall handling
  um: nommu: seccomp syscalls hook
  fixup seccomp
  x86/um: nommu: process/thread handling
  um: nommu: configure fs register on host syscall invocation
  x86/um/vdso: nommu: vdso memory update
  x86/um: nommu: signal handling
  um: nommu: a work around for MMU dependency to PCI driver
  um: change machine name for uname output
  um: nommu: add documentation of nommu UML
  um: nommu: plug nommu code into build system

 Documentation/virt/uml/nommu-uml.rst   | 180 ++++++++++++++++++++++
 MAINTAINERS                            |   1 +
 arch/um/Kconfig                        |  14 +-
 arch/um/Makefile                       |  10 ++
 arch/um/configs/x86_64_nommu_defconfig |  54 +++++++
 arch/um/include/asm/dma.h              |  13 ++
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
 arch/um/kernel/process.c               |  25 +++
 arch/um/kernel/skas/process.c          |  25 ---
 arch/um/kernel/um_arch.c               |   3 +
 arch/um/nommu/Makefile                 |   3 +
 arch/um/nommu/os-Linux/Makefile        |   7 +
 arch/um/nommu/os-Linux/seccomp.c       |  87 +++++++++++
 arch/um/nommu/os-Linux/signal.c        |  24 +++
 arch/um/nommu/trap.c                   | 201 +++++++++++++++++++++++++
 arch/um/os-Linux/Makefile              |   3 +-
 arch/um/os-Linux/mem.c                 |   4 +
 arch/um/os-Linux/process.c             | 138 ++++++++++++++++-
 arch/um/os-Linux/signal.c              |  11 +-
 arch/um/os-Linux/skas/process.c        | 126 ----------------
 arch/um/os-Linux/start_up.c            |  25 ++-
 arch/um/os-Linux/util.c                |   3 +-
 arch/x86/um/Makefile                   |   7 +-
 arch/x86/um/asm/elf.h                  |   8 +-
 arch/x86/um/asm/syscall.h              |   6 +
 arch/x86/um/nommu/Makefile             |   8 +
 arch/x86/um/nommu/do_syscall_64.c      |  75 +++++++++
 arch/x86/um/nommu/entry_64.S           | 114 ++++++++++++++
 arch/x86/um/nommu/os-Linux/Makefile    |   6 +
 arch/x86/um/nommu/os-Linux/mcontext.c  |  26 ++++
 arch/x86/um/nommu/syscalls.h           |  18 +++
 arch/x86/um/nommu/syscalls_64.c        | 121 +++++++++++++++
 arch/x86/um/shared/sysdep/mcontext.h   |   5 +
 arch/x86/um/shared/sysdep/ptrace.h     |   2 +-
 arch/x86/um/vdso/vma.c                 |  17 ++-
 fs/Kconfig.binfmt                      |   2 +-
 45 files changed, 1312 insertions(+), 209 deletions(-)
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


base-commit: e66ae377fe219c98d3d5b8a0d35da4413a5390ca
-- 
2.43.0


