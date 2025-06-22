Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392E0C7EE3A
	for <linux-um@archiver.kernel.org>; Sun, 22 Jun 2025 21:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kWA3StPiWkAfs4FcE2soHgzcqqw9xVR9Ej4dw8gKLE4=; b=cRNGL2eT++TCUcQN0a6shKs2ZJ
	tkQiumocu1kEtrXOhTeqCFuPnc1gsE0eBLB1mm2C7ch1j/0llc753I5ErzH0FGDjIWX17gzZwh1WD
	4GpMBRW59CS17lsbfuSWsvF4FqHZRxCOg0kwHBoSdvcxBTYMbtrL1Mer3ZSkdyexESOHJZl/oJ6s+
	Iv2t2OAgZNBSl1mNHsJXqshWEcz3ve21doJp/KgjGC+4/x7Du5skAEzLWuyJSYSHPUSNc8Fn9/mWr
	lYuqczlAFb88dVjTAhLZADwnlGI1Slv+DcUcMgyDIcenGia0iNhAIAVhXB7p1pOBbstbI1Rf6TIWp
	TFhTwTZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSKF-00000001F3i-0b32;
	Sun, 22 Jun 2025 21:34:07 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSJX-00000001Eqc-2t1L
	for linux-um@lists.infradead.org;
	Sun, 22 Jun 2025 21:33:24 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-31393526d0dso2305893a91.0
        for <linux-um@lists.infradead.org>; Sun, 22 Jun 2025 14:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750628002; x=1751232802; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kWA3StPiWkAfs4FcE2soHgzcqqw9xVR9Ej4dw8gKLE4=;
        b=Wl1EsgHbgadCq79zeqCK26975wqEpKukY8NA7oKhO2iqgDp20vLOcGtIXUdFQW81j7
         0MMNlUJB2KylQi+Qw1h6Vsp+mkfvMqtAzt4NpMCkwTbAzD+YCpKQKJNzylecQ+ak8+Ps
         jLjQb14vyZVvHDmOKNqLNEt/yNfkvuiQ2hmz1ViWxbT2KHmZtsAJGgvru9KmIig6apYV
         aPAVeyoUeioujFJqRTkMDV29SABFzDMUxG8ngua9tVfgCG3ckaJ3owCPx60Ajo+yhlCB
         D8CXr9+LN0UVPyYtu9RGDLxW+7/tScNODThPRsUkHjdgr3mCmm0Sh+Ohcj+c0G3GWQB7
         NwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750628002; x=1751232802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWA3StPiWkAfs4FcE2soHgzcqqw9xVR9Ej4dw8gKLE4=;
        b=FBQA1M916TT+gBpHohpiC6f3s87f9hAkXH5K2in84s2GZSlXAc+PKbjtYqcA+ajTUZ
         /dbDnLTcN7UMOJXAp4RZscjysNSZKpWlGgYyp5VbZVCtarnSQfsJYEy98UtvIzhzQzel
         tY6WMGEdeSBRNLV474kAcvDlG3OLjc0hPQD57qVckdhWQqegXaRq2axkk9q46S+Cp5sI
         YOjSkiyLWQNC7KeW7nQThLxcC1BGiTYs+hmLVs/gOTJ8PhL8ZpCxxHPKyBr63dF425jT
         a5EGWMulIWwJqFti2paj9r2ds77S9qt6jkzZAXLSp/GAi5nV1Lo5oSCBGd/d6oStX3I9
         wtLw==
X-Gm-Message-State: AOJu0YyIburUkl2uPw8LnlA5UHm3oOWf7xjn5LYjD0D/4eIyTut9Xk6t
	q++/adKi6rEfyIJ5sjDsUoIdKvTWL++H5AQy05TlJbj+nfmEdXXEQmmO
X-Gm-Gg: ASbGncsFwHnTKihkdanlGc3Q07vVVQIIy40zTIOhEaQeB4mbwyfhAiGtD73UrZ1Wl55
	MI8RJicYHxRN9LwONzXoBp+2iKLfuKxx+yjqgWcfDTlkkNsF7E0MPXm8riLV4nDCBdFLLO9Rs14
	YxC6k/YxZEgXbPoYOohJTLOpTc3bd3h/+Og69mpqEzTE7f4hmEZan2wbIvBNBm9r64UGj+aqucy
	hN2Q2JlRxtg2s+fl+xMvk4Okw1RoQzDHT/YKYaPLeT+Fz7TuqdBVhiDIMUAst1tEqYlHhiPsibK
	G2D3mEJBzey/3Qs0YphF7enFhMDbQa157rd0VGgDFf2dmhZqp2WJnzozxdLvlZw5/w4Lxyj42wj
	J0XgI+EiMjhYlhHJaWJvPjCGpJeoF0QyG
X-Google-Smtp-Source: AGHT+IFpzxz28YJ7KUHpAeQcZWN/pVFUI5GcIqdDZHFqQtYD02f9HFVJDuPRXmKToeMZcqJl9FFJng==
X-Received: by 2002:a17:90b:5148:b0:313:b78:dc14 with SMTP id 98e67ed59e1d1-3159d57b142mr17909263a91.0.1750628002435;
        Sun, 22 Jun 2025 14:33:22 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a331babsm8982152a91.46.2025.06.22.14.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 14:33:21 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 9657AEF1EA4; Mon, 23 Jun 2025 06:33:14 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 00/13] nommu UML
Date: Mon, 23 Jun 2025 06:32:58 +0900
Message-ID: <cover.1750594487.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_143323_748588_0BF4854C 
X-CRM114-Status: GOOD (  20.55  )
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

v10:
- fix wrong comment on gs register handling ([09/13])
- remove unnecessary code of early syscall implementation ([04/13])

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
 arch/x86/um/nommu/do_syscall_64.c       |  68 +++++++++
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
 46 files changed, 1306 insertions(+), 216 deletions(-)
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


