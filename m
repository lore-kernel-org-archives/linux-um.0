Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A628C71157
	for <linux-um@archiver.kernel.org>; Thu, 19 Jun 2025 01:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GLucpOXvaa4URh0gkHTacedQvpWCpnoQbI3w1+Ojf5s=; b=qmDI+mUmDwd6YIi/OYQnGke0AO
	T6zJib+iFXNkRDLyT2FI7mqqoOZ4is8geV6vOK6+hkgOP/iAaY2iDEQPZwmxJSbv99dTaZEJ7lbP5
	816c55rUVZm26NnHBJen80FC7EFWBbxFb5N3ZO9/q4g+siJZDmOoaI/fBfxAwDWdWMG3lG1ISus27
	Br3m7+thLlRI6k5q5Wuw8YVaCsyC743XSe0ZZZL2iMkl6gC6XluDUiE8ZyYOHadMKj+mqFdmxxXGI
	uDDokEq1BE0gk14uPcpjbpie8kkT/rpaDiakKAxkK0G8R2RLz7bVKxn7l+apYWFTlIBNFR/2Wg8gD
	CdsXUqIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS3hn-0000000BgWf-0uhT;
	Thu, 19 Jun 2025 01:04:39 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS3hk-0000000BgWE-3zIF
	for linux-um@lists.infradead.org;
	Thu, 19 Jun 2025 01:04:38 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-74865da80c4so109319b3a.3
        for <linux-um@lists.infradead.org>; Wed, 18 Jun 2025 18:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750295076; x=1750899876; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GLucpOXvaa4URh0gkHTacedQvpWCpnoQbI3w1+Ojf5s=;
        b=PrSNtw4MVntMeej1qHMYjcL2ZDQOmBvj/sfmobgeZMLxv8CaDqxvo9KdZnAYcPW59n
         xdMXtMqHC3zJwYCLdhSQrMh8YX3JUXgI9PXwbuI4N3sMA0PaoB93L0ugMM/YfbYHTAnk
         uI2QG6SHKEnoJAsFoHRpoUi+onlYDrtP7s8VztOFH8G/HqPvOCzYO49DDWMWM42DHAaa
         jNPr5tLAMUh69C4E7gqXaxF4XFWHwlsdw7jrvd4dMTKvakNDH3wSLgOByknngTa3A5ff
         MEcWo+OyzTdYZH9MCFd+JinLK/iJf2bHWdb1bNvXF7n0NtJIa2CugzNtiJc3mhgX7MB9
         fqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750295076; x=1750899876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLucpOXvaa4URh0gkHTacedQvpWCpnoQbI3w1+Ojf5s=;
        b=u1kRQwhzULqtVRU4gRyZxxtvm66fPaZKEEWkEUFL8en5F13isRl+bUdX4aLXIs8cX7
         ZVW6LNJ1pC0pFymyv02nHpV+9AAORAq0ZC49cezqOO3vplAtA9Jjz6z+Jzb8FyYoXX48
         w4RP6U67w4JDcsym1F4cxAjO2QXtRSMGLn7SBKYyPjfvi/Yolg+2qRZQDhMPSKRQ8Lq6
         Ho8e/8k9tGmVR59Jj9qtX5Kc/x2rRIcIK0aGER3CoroJ87yE8kOTSxftGEX6qBRkasrm
         lmQAPeSCOr7c1zqWGCH6fNiX3Blr31d8eB6ZGeVsoFSq5voWvbe9UfJwJNRxSZ/pATIx
         9dEA==
X-Gm-Message-State: AOJu0YyRA/2ztFjzWhwYl1JuWraWTKPCP5CizQkcgPJnXuI5yyYoAcpr
	bB1lPVdyAvO1SlKh2kDzCVg8p3DMSXba5hR7oLPsttfBNLMF9x5CdYea
X-Gm-Gg: ASbGncvcdbfpQToUkmUQKIUSmzUQ9WoWu5ONkDuu/xRSpOkVwFbzjotPg6NYlH4JxkV
	77jrArd0YLVUqgoQKhOaQ12v/georCrIOvE5JJDv1K2nlq+Z4g1HM9SjBzVXw2PNmTUexNU6bih
	yoy323w34JGZ4buz3ycQ5DZ8NufwcdZnjwmTUL9spGXe0fauKnEVX0S5C9XtaeyIJvtmyNol/Rj
	tzPfa5U4LkcMpo6EkKeSRbHtfhVTdlmMXyfuck/H2Wl7wvi74fPmHAu3hTx9MhpAIXoo6V9rj5n
	Bp7ec+wyIyBMpeX+ON/FrQlGsg4M9S6fQSUaXH6M05zJKXI0gOkGDWFndX5dFZA8cK4wDT6kNGC
	jmX3BTAGUOoH3eanNuaCponNmsy7Mx48vgPKXGK2cRZU=
X-Google-Smtp-Source: AGHT+IG6MFY9DkpD7kK44rBOQDepsenRjIZZchu6cctr0wOFSPPBWOJ6NPgY3oxDIP9/ASry+1fF+Q==
X-Received: by 2002:a05:6a00:b95:b0:740:9abe:4d94 with SMTP id d2e1a72fcca58-7489d00473bmr28379714b3a.21.1750295075499;
        Wed, 18 Jun 2025 18:04:35 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748e7efcf8fsm2520391b3a.69.2025.06.18.18.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 18:04:34 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id DCC36ED6528; Thu, 19 Jun 2025 10:04:27 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 00/13] nommu UML
Date: Thu, 19 Jun 2025 10:04:04 +0900
Message-ID: <cover.1750294482.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250618_180436_994632_EFC22A08 
X-CRM114-Status: GOOD (  20.74  )
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

v9:
- rebase with the latest uml/next branch
- add performance numbers of new SECCOMP mode, and update results ([12/13])
- add a workaround for upstream change on MMU depedency to PCI drivers ([10/13])

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
  um: nommu: a work around for MMU dependency to PCI driver
  um: change machine name for uname output
  um: nommu: add documentation of nommu UML
  um: nommu: plug nommu code into build system

 Documentation/virt/uml/nommu-uml.rst    | 180 ++++++++++++++++++++++
 MAINTAINERS                             |   1 +
 arch/um/Kconfig                         |  14 +-
 arch/um/Makefile                        |  10 ++
 arch/um/configs/x86_64_nommu_defconfig  |  54 +++++++
 arch/um/include/asm/dma.h               |  13 ++
 arch/um/include/asm/futex.h             |   4 +
 arch/um/include/asm/mmu.h               |   8 +
 arch/um/include/asm/mmu_context.h       |   2 +
 arch/um/include/asm/ptrace-generic.h    |   8 +-
 arch/um/include/asm/uaccess.h           |   7 +-
 arch/um/include/shared/kern_util.h      |   6 +
 arch/um/include/shared/os.h             |  16 ++
 arch/um/kernel/Makefile                 |   5 +-
 arch/um/kernel/mem-pgtable.c            |  55 +++++++
 arch/um/kernel/mem.c                    |  38 +----
 arch/um/kernel/process.c                |  25 +++
 arch/um/kernel/skas/process.c           |  27 ----
 arch/um/kernel/um_arch.c                |   3 +
 arch/um/nommu/Makefile                  |   3 +
 arch/um/nommu/os-Linux/Makefile         |   7 +
 arch/um/nommu/os-Linux/signal.c         |  29 ++++
 arch/um/nommu/trap.c                    | 194 ++++++++++++++++++++++++
 arch/um/os-Linux/Makefile               |   8 +-
 arch/um/os-Linux/internal.h             |   5 +
 arch/um/os-Linux/mem.c                  |   4 +
 arch/um/os-Linux/process.c              | 144 +++++++++++++++++-
 arch/um/os-Linux/seccomp.c              |  87 +++++++++++
 arch/um/os-Linux/signal.c               |   8 +
 arch/um/os-Linux/skas/process.c         | 132 ----------------
 arch/um/os-Linux/start_up.c             |  25 ++-
 arch/um/os-Linux/util.c                 |   3 +-
 arch/x86/um/Makefile                    |   7 +-
 arch/x86/um/asm/elf.h                   |   8 +-
 arch/x86/um/nommu/Makefile              |   8 +
 arch/x86/um/nommu/do_syscall_64.c       |  80 ++++++++++
 arch/x86/um/nommu/entry_64.S            | 113 ++++++++++++++
 arch/x86/um/nommu/os-Linux/Makefile     |   6 +
 arch/x86/um/nommu/os-Linux/mcontext.c   |  24 +++
 arch/x86/um/nommu/syscalls.h            |  16 ++
 arch/x86/um/nommu/syscalls_64.c         | 115 ++++++++++++++
 arch/x86/um/shared/sysdep/mcontext.h    |   5 +
 arch/x86/um/shared/sysdep/ptrace.h      |   2 +-
 arch/x86/um/shared/sysdep/syscalls_64.h |   6 +
 arch/x86/um/vdso/vma.c                  |  17 ++-
 fs/Kconfig.binfmt                       |   2 +-
 46 files changed, 1318 insertions(+), 216 deletions(-)
 create mode 100644 Documentation/virt/uml/nommu-uml.rst
 create mode 100644 arch/um/configs/x86_64_nommu_defconfig
 create mode 100644 arch/um/kernel/mem-pgtable.c
 create mode 100644 arch/um/nommu/Makefile
 create mode 100644 arch/um/nommu/os-Linux/Makefile
 create mode 100644 arch/um/nommu/os-Linux/signal.c
 create mode 100644 arch/um/nommu/trap.c
 create mode 100644 arch/um/os-Linux/seccomp.c
 create mode 100644 arch/x86/um/nommu/Makefile
 create mode 100644 arch/x86/um/nommu/do_syscall_64.c
 create mode 100644 arch/x86/um/nommu/entry_64.S
 create mode 100644 arch/x86/um/nommu/os-Linux/Makefile
 create mode 100644 arch/x86/um/nommu/os-Linux/mcontext.c
 create mode 100644 arch/x86/um/nommu/syscalls.h
 create mode 100644 arch/x86/um/nommu/syscalls_64.c


base-commit: cfc4ca8986bb1f6182da6cd7bb57f228590b4643
-- 
2.43.0


