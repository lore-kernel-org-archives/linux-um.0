Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5F9C3DA4A
	for <linux-um@archiver.kernel.org>; Mon, 20 Jan 2025 06:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Y6TgjTF2THJ1jELZdt1T4FYNsy44b3985ebYTO8U0LI=; b=rFe4QvvSKLhqOdZYygIurxl5e1
	r+fJpYuubo/345b3DajhfLQ17U+m18YSo/Ic899pCmVjC9hsl67g5qYeHK00Ed/qsGC3ThlK1+L6o
	UjPiVPus0HFMSoTJN0mbwcXobfxgyaH7lHOa/sHaYWGmMWMr2uom54WphnFd/ulfQ9M1gAAfH7npp
	bvYMECYpEZ/Whpe5FUnVwZXv/p9dSVYTfp+uclUNegneSJe35SUEXELhqm4PRmoXtgl2nC3152fn+
	39Ml4eCVqrNLAkLmJTAsm1TQO745oa7S19GH1/nWTIZcwhbjtqCZdvi6nGZ0a/3+GTnN3Wy2Gtvpl
	9iw1AMtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkqy-00000004nMB-1yBC;
	Mon, 20 Jan 2025 06:01:40 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkpm-00000004nB4-3w0o
	for linux-um@lists.infradead.org;
	Mon, 20 Jan 2025 06:00:28 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so5200445a91.1
        for <linux-um@lists.infradead.org>; Sun, 19 Jan 2025 22:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737352826; x=1737957626; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6TgjTF2THJ1jELZdt1T4FYNsy44b3985ebYTO8U0LI=;
        b=Q8U6+53CKYq0Ps6fxxk+aI+aMTZEBoKBdVwcE1Oskf+0/DsqKjHxQ8Qiy6e/P/PA63
         zJxFsTQ0zKKNS2Lt37uR5lGMEF40cfKRC+Mz/S3N1nYUfxCCTmNJotDu3NIxwv1FkaLz
         wlSzLbmrnY+jhy54g4w+R4sOwazx6dCxpzt7zr+ufhD3YYS9VMQv8Y32RkmbcXDudwRq
         VBSCBGpJpUfkmZVodAJKKI7yPoC6hRffVaIh5UHKwEmMy/S/8kH09zL2KI3qWE1Fyz3w
         EInG0okD/CZmg0NJax82FgYVqBh0pNz91xpCTalHYHLa01n7R2FlTMLe6EWRMlCn9Sjl
         kzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737352826; x=1737957626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6TgjTF2THJ1jELZdt1T4FYNsy44b3985ebYTO8U0LI=;
        b=oj8Ib5IcjTHaIJoON3UU47vuGUFjtmaRdemW5i173EDPM0Fge2JmvAmkzuHlMS94wc
         MUS5/lxmRXa/i/sxQi86mYPEeNq8HordJaZQVF2kaREb9bsXr8atQybSp5HnPMGwPvvu
         X9lHdhAGc4dqs2zerE9Aey64okcUwPiidYsPzQxpiVL8aB4kFN/icFcS2y1M6xSmkJss
         3R8CN3KrIXS6VXoAvovn2kq41vsf46D8vgSW2DmdxMZwoGwlyc7eNeZgDQiAoL92z+wl
         /ZDSCGDlVpHNwzpjC6XaPkzjzRw74CHmODP27rmhEweMcphFXAs3WdDZ/7S9dJKTI+Bl
         LNLg==
X-Gm-Message-State: AOJu0YxWnCGkQoz72g/+rgg6JlNaarmcNgycvTjo+WrM6ONgWfhXuhLt
	BcKFaqOA5l6Oxqy6ZEHvefpMLdBVuykMJqsz38ail40pq3hChV1CA8UCFg==
X-Gm-Gg: ASbGncvicXcLv5aD0PtK8iknjiN4oIf1PMtwh912fbGvMNSDoWhEoz1cK+SVlZlrDbB
	JbrxRBglpuxDsj4CPshbLjkHBn1SuUyZ4umhkwt91ES0Y184HxYm3gEzqRbmeWmT7Se+57oD+3O
	/I5lNZ08YOODf24UwbaqkDDs76UXDX9F1Tm0LRtrFXKC+cdjI4m5XrDd9re0pI5/Q0tkh5SDpyc
	ssN9q0ZMPh9yENpTSAkv7af9fxZj6KQE1KF0HzCXTe8avDI+qsbU4br6V4KrmxejIkIiyIyKgYJ
	rEFB8LpE3Y4RAdQEXZ0kxRBbGDXDIpT4hpUhlL1ttQ==
X-Google-Smtp-Source: AGHT+IFwSIEKy5VhOpTNspi9WATmukj8NqFLN9LygS45j+yCtqqvOUqE3IimYRAfClE8RqIEtpIAvA==
X-Received: by 2002:a17:90b:2e4b:b0:2ee:5bc9:75b5 with SMTP id 98e67ed59e1d1-2f782c51387mr16947521a91.4.1737352825566;
        Sun, 19 Jan 2025 22:00:25 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7085261dcsm7717108a91.0.2025.01.19.22.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 22:00:24 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id BA90FE27522; Mon, 20 Jan 2025 15:00:17 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v7 00/13] nommu UML
Date: Mon, 20 Jan 2025 15:00:02 +0900
Message-ID: <cover.1737348399.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250119_220026_978065_8D6A1CD2 
X-CRM114-Status: GOOD (  20.34  )
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

This patchset is another spin of nommu mode addition to UML.  It doesn't
change a lot since the last version (v5), but contain clean ups.  It would
be nice to hear about your opinions on that.

There are still several limitations/issues which we already found;
here is the list of those issues.

- memory mapped by loadable modules are not distinguished from
  userspace memory.

-- Hajime

v7:
- properly handle FP register upon signal delivery [10/13]
- update benchmark result with new FP register handling [12/13]
- fix arch_has_single_step() for !MMU case [07/13]
- revert stack alignment as it is in uml/fixes tree [10/13]

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
  x86/um: clean up elf specific definitions
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
  um: nommu: add documentation of nommu UML
  um: nommu: plug nommu code into build system

 Documentation/virt/uml/nommu-uml.rst    | 177 ++++++++++++++++++++++
 MAINTAINERS                             |   1 +
 arch/um/Kconfig                         |  14 +-
 arch/um/Makefile                        |  10 ++
 arch/um/configs/x86_64_nommu_defconfig  |  64 ++++++++
 arch/um/include/asm/Kbuild              |   1 +
 arch/um/include/asm/futex.h             |   4 +
 arch/um/include/asm/mmu.h               |   8 +
 arch/um/include/asm/mmu_context.h       |   2 +
 arch/um/include/asm/ptrace-generic.h    |   8 +-
 arch/um/include/asm/uaccess.h           |   7 +-
 arch/um/include/shared/kern_util.h      |  12 ++
 arch/um/include/shared/os.h             |  16 ++
 arch/um/kernel/Makefile                 |   5 +-
 arch/um/kernel/mem-pgtable.c            |  55 +++++++
 arch/um/kernel/mem.c                    |  39 +----
 arch/um/kernel/process.c                |  25 ++++
 arch/um/kernel/skas/process.c           |  27 ----
 arch/um/kernel/um_arch.c                |   3 +
 arch/um/nommu/Makefile                  |   3 +
 arch/um/nommu/os-Linux/Makefile         |   7 +
 arch/um/nommu/os-Linux/signal.c         |  28 ++++
 arch/um/nommu/trap.c                    | 188 ++++++++++++++++++++++++
 arch/um/os-Linux/Makefile               |   8 +-
 arch/um/os-Linux/internal.h             |   5 +
 arch/um/os-Linux/mem.c                  |   4 +
 arch/um/os-Linux/process.c              | 149 ++++++++++++++++++-
 arch/um/os-Linux/seccomp.c              |  87 +++++++++++
 arch/um/os-Linux/signal.c               |  31 +++-
 arch/um/os-Linux/skas/process.c         | 132 -----------------
 arch/um/os-Linux/start_up.c             |  20 +++
 arch/um/os-Linux/util.c                 |   3 +-
 arch/x86/um/Makefile                    |   7 +-
 arch/x86/um/asm/elf.h                   |   8 +-
 arch/x86/um/asm/module.h                |  24 ---
 arch/x86/um/nommu/Makefile              |   8 +
 arch/x86/um/nommu/do_syscall_64.c       |  80 ++++++++++
 arch/x86/um/nommu/entry_64.S            | 113 ++++++++++++++
 arch/x86/um/nommu/os-Linux/Makefile     |   6 +
 arch/x86/um/nommu/os-Linux/mcontext.c   |  24 +++
 arch/x86/um/nommu/syscalls.h            |  16 ++
 arch/x86/um/nommu/syscalls_64.c         | 115 +++++++++++++++
 arch/x86/um/shared/sysdep/mcontext.h    |   4 +
 arch/x86/um/shared/sysdep/ptrace.h      |   2 +-
 arch/x86/um/shared/sysdep/syscalls_64.h |   6 +
 arch/x86/um/vdso/vma.c                  |  17 ++-
 fs/Kconfig.binfmt                       |   2 +-
 47 files changed, 1329 insertions(+), 246 deletions(-)
 create mode 100644 Documentation/virt/uml/nommu-uml.rst
 create mode 100644 arch/um/configs/x86_64_nommu_defconfig
 create mode 100644 arch/um/kernel/mem-pgtable.c
 create mode 100644 arch/um/nommu/Makefile
 create mode 100644 arch/um/nommu/os-Linux/Makefile
 create mode 100644 arch/um/nommu/os-Linux/signal.c
 create mode 100644 arch/um/nommu/trap.c
 create mode 100644 arch/um/os-Linux/seccomp.c
 delete mode 100644 arch/x86/um/asm/module.h
 create mode 100644 arch/x86/um/nommu/Makefile
 create mode 100644 arch/x86/um/nommu/do_syscall_64.c
 create mode 100644 arch/x86/um/nommu/entry_64.S
 create mode 100644 arch/x86/um/nommu/os-Linux/Makefile
 create mode 100644 arch/x86/um/nommu/os-Linux/mcontext.c
 create mode 100644 arch/x86/um/nommu/syscalls.h
 create mode 100644 arch/x86/um/nommu/syscalls_64.c


base-commit: 2d2b61ae38bd91217ea7cc5bc700a2b9e75b3937
-- 
2.43.0


