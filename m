Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB03CCF9E3
	for <linux-um@archiver.kernel.org>; Sun,  2 Nov 2025 09:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CTo/fO8AwTUlnERfKnS0Hq9g4pzw1jJNDet5wuDWHQk=; b=W7LeZ6uxQgxAVKSgVH3KrW9bQ3
	tNIfLiYp7l3OOdIxDiNbfjxN179yasmJ0836ftkvxXVDn3oqBn7ucg3A2YK085etJE3msD/Wy2Qab
	CM7sQ7Vb5svDF8aF+PIH+3UIjUp42WUTSBlMgiUZfFv7Xfx2eV8bN/9woKFViSb1ZbBZcEgVApSuu
	xxc7FJhsRnxsTyCNl4cN9KdT9M2DGhRyfPPF3zziWvrXh2lB1h6Wbux1YTAbjl602+ahYZvB3za6e
	btmD2WhEpsL8qnyxktSlNzpAuva/VOitpsmZ4cA2nk7t6DQOCtrg1rr1ObBnWNAsUK+OSwKZGsJA8
	TVu5G5jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUie-00000008RlP-204D;
	Sun, 02 Nov 2025 09:49:52 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUib-00000008Rl1-49nJ
	for linux-um@lists.infradead.org;
	Sun, 02 Nov 2025 09:49:51 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-29558061c68so7681235ad.0
        for <linux-um@lists.infradead.org>; Sun, 02 Nov 2025 01:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762076989; x=1762681789; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CTo/fO8AwTUlnERfKnS0Hq9g4pzw1jJNDet5wuDWHQk=;
        b=msgGmTv3ieYfFNx2v1/V9jN8vacy27P60qzJrrPdKoUDdddbTZAalcE+IjY/C+RwL6
         5n/Wcacq6OHPs71lDmHg+yGwXUrvCo4ajsPfzcvNzhGiTWqTcacbZZFacce3V4GEl38e
         vYwQKFQjR5jLFrTOmFm0RveHwBSLT9cf28D483Nx7SKJisGsydZqkRwWDnh3Dq+ZoBB6
         zRP/XcQzzxIOr/0akf7nHPOqkWgPvyA1xUPHhHtX11kqaJKdWCyYImFz1UFDZtohtEVN
         r9l7lr/G948gH6C8HAHffDeKo5HaqsSwPoSDSFVwu1ADed2bcrDKOtkdwceiwQfkOFAu
         yqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762076989; x=1762681789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTo/fO8AwTUlnERfKnS0Hq9g4pzw1jJNDet5wuDWHQk=;
        b=hrBZ+Z1bfqVratZCsFq99GsDAzEykajUzX/jdX5Z9FgJugTXwWOg5RpL2V+Yfd0wEM
         qgQX2ZSVG9sGWfzs1/XdmfbfZUfixSFVUHRYf+fNa1Ip0jw1cxcJZRx/0Dp1L7BbKBOb
         QRUdszT8XR9graPVSnJqRf07u+y7inaToqqhKrvz9NDHz3w8uU2jXwl+D26iGHQsPRt7
         ADhDgGlX+XT+Myb+oynBdnQt4IdAjYojx1hYwO6SMzxaLMbhSNFgTGFE+hQKhiSgcMLv
         w3s/8Ep/tEvq/iRf/Vl/Q2mnSgrQAI6zGYyxchD1wDq5PR7VsSQazLzBONyjDIM4O3s1
         qTpw==
X-Gm-Message-State: AOJu0Yz0TfEwA0VgpKpB+ZtN8eH42b9SLg+uyGCUF5NCCO0snnO8D56v
	cn2kN0Gbqrwp69QmLhVcvK3mn6gK8AJJml2kCr2kTreJZ+dyet7yL3b/
X-Gm-Gg: ASbGncvAiJ37f687AQ6gLBp0EoiaUBXnwrRSvHGeb1CUwT06dYE/A9Dg5IiW6yLmyDK
	sVvS4JR4lg0bZB98R+JYEQvMLqKPkiWWu18qkjkWcAWs4emxnoGrJfPAIvH0wnhszkIzgkDLpJZ
	PukJoM1evvcUKMHvqNlj/XrJGYCRFs2Tf0bzW8IpPyw2C8aoMObrV/8bhqlsmy8wnqKslYgnNv5
	3gGkd4L8bxHmytp0t7Ewhk3kfYQnhE7tVq0F5TZ0ekPI0/jMBb809zoVAdsbR8HWW5UYFCy5+4Z
	/MOVZ7KOnFc55CbMYEX+2ghYcfeFdhCXHvk+Y2WeH67lM8RF7/z4Dbne6Pnkuhmqc8JUrYFl0CB
	PNOSLelGqbLx5WADUnMB5+C6gkToInh6L0Mgkfdt9u54CtV0KFVNJS4IettrZLSb9Dg0OwSGUVr
	hYLU3tcT23eaXJ8XyPKZQpobAE3qIKYPHVpxwtmmWVi+eKmA==
X-Google-Smtp-Source: AGHT+IG5uEZuIhw9XthpVR/gauM2QFGD0azbjoJ+g93MQt9Wwqr6xtlh/sIZ+JQcm6X627sSMbAf5A==
X-Received: by 2002:a17:903:41c7:b0:295:62d:4ffa with SMTP id d9443c01a7336-2951a3b12dfmr134893555ad.21.1762076988895;
        Sun, 02 Nov 2025 01:49:48 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b9b8f2b5403sm812430a12.17.2025.11.02.01.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:49:48 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 0F85011237FC; Sun,  2 Nov 2025 18:49:41 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 00/13] nommu UML
Date: Sun,  2 Nov 2025 18:49:25 +0900
Message-ID: <cover.1762075876.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_014950_038773_79BBE96F 
X-CRM114-Status: GOOD (  21.32  )
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
- CONFIG_SMP is disabled as host_fs handling doesn't work with thread
  local storage.

-- Hajime

v12:
- rebase with the latest uml/next branch
- disable SMP and tls as those doesn't work with host_fs handling ([11/13])

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

 Documentation/virt/uml/nommu-uml.rst   | 180 ++++++++++++++++++++++
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
 arch/um/os-Linux/skas/process.c        | 127 ----------------
 arch/um/os-Linux/start_up.c            |  25 ++-
 arch/um/os-Linux/util.c                |   3 +-
 arch/x86/um/Kconfig                    |   2 +-
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
 46 files changed, 1322 insertions(+), 223 deletions(-)
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


base-commit: 8e03c195cc4d82100291500f772f85c686653748
-- 
2.43.0


