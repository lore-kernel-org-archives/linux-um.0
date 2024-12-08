Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91F8E77173
	for <linux-um@archiver.kernel.org>; Sun,  8 Dec 2024 10:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CcLCMDV5mpX342yrBYtIpivnDZMLoruC/LwBmFQjXuw=; b=GkOJnEu3tMSOPZ5I9U7TUFgQjO
	XH7xl2GJAq6EG3zcT8k93ILD5cl098JFkD0Xnqbz9cCPVbUejDeQHZ2d41UOUdJAWJqvaMRi7wth4
	CJsuvNGHQndXmwDI+eNAPyM1evq20cCquE+ekxcnWRMVQc/5DISeKu333YctM5QgYdx1QZmsY7+1M
	xijUgp5WbVTM2L6r9IrCduwmwomx3UJ4wcE46qSA4S6Dp6VkOkD82oOScUQNBnVfew838ip1RvP+P
	dPONWKgVI3hjCjZ+ge9aNYxv7l38wXikF+X5Zmi3B+JOr8lRh1URiK42Ispoaw+8U4qxVfpOf+dGV
	bzw/wm2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEIU-000000057J6-477X;
	Sun, 08 Dec 2024 10:13:54 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEIS-000000057IA-295b
	for linux-um@lists.infradead.org;
	Sun, 08 Dec 2024 10:13:53 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-21628b3fe7dso11288835ad.3
        for <linux-um@lists.infradead.org>; Sun, 08 Dec 2024 02:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733652831; x=1734257631; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CcLCMDV5mpX342yrBYtIpivnDZMLoruC/LwBmFQjXuw=;
        b=AFUPtx1frjCQiHdaCgiK+NDleoJW0tpRVRrLX8elzi6br6qZ+3/pF3BNzAAiWdTak1
         F8IehLIMty80Hax+u4xTHCaQSvvGg9aAf/PqAnwG+/cwm2cJANWxYVJ02QYGJP7R9Int
         ro0ECMQdoVMY+WMAQaINKQY8yPXebkvlwXb5ykDtIcLc6SJYTPZLs5xOyVq/sR56q0Pi
         +k9E508J7n4GhzZjjvkaYGLQAFkDEP/Ip8g/rZBLisUwn4SeE8FlU/fgvmnC4iDWIBzX
         bSSibRdSXpwwjOCoO09R9Fb2JP0oYV61+tXySQXfGHd065a+JIkU8UZ8x8OQKmjrXEbC
         iJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733652831; x=1734257631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CcLCMDV5mpX342yrBYtIpivnDZMLoruC/LwBmFQjXuw=;
        b=b6A1YaSvjakBbTGQx0xS8mYsnfhsSGyPErqcdZZsPyafrhcAhW8Gms/EZUwLU9Gzi4
         u2RGQ37AHXxBfWQgZY4JIXp53ZRdfJV9OCCTvi8TuT/P3GLa2UeLHEOuaFNbkuEv7V4G
         Du7MgU4p6mlOeYYcMn2lB8RNTJ9rIud0DS6QF2PPKqanWZZDtrgVkppSwRogc0h0HoR+
         p5PpiZkyGkBFmzgKJcNvED32RlzQSMw6pxTHy1shfO6u3pICbIIiU/jbqhCa5BAd5Y9y
         giFFlVmOeAJ9evIw+5PLH01W7KilmyfcCVKfdivhVMaiR3Qy4OJ/9xzGHpy1Aoeotzmn
         8jqw==
X-Gm-Message-State: AOJu0Yz2E3uA6fXoFlBVwnqGlIDuAht/eCjuXiLPcI4076U9Ez1yFybO
	wdu8uHCKWQJMoUb6jmYY3Jx7tzNRG5XFV860kv1dxmdOiZwjcnUYyYJt5g==
X-Gm-Gg: ASbGncv5rOx0VteQbRkGUy6ly488JR8pZmBhw/l3xgedX+cXr02nfRfxzoNiCcb8dKn
	hw6ArlUSXO4jt8q6cpKl2vfdaVEEMeICP3OG7Lino+3Aksatqq+jxpQ837k9g5ofmEnlxNZGhlg
	oKBp8Jk6gBuu8OKXIH7Hec2vgCqVgQ4ejZiaCnkOeLwYBDKXjxKV6rGZ7+RbXxti0QvPIgQrH1w
	b5uYvNdYztWF+yDfO0zOFFUdbkVIkO7lytD4SM05nty/j7QyWMuvkHje0ZtNNWOJ2gHPqNTEKK+
	OzWHUmmcnSVdxEJrHlol
X-Google-Smtp-Source: AGHT+IFkdADqNnXhdGM0pknaMCvkXz4A2RYnblLCmgamyHxuU6OEvnjw+5lJj89AImyMO15QAgPpeg==
X-Received: by 2002:a17:902:e751:b0:216:26f1:530b with SMTP id d9443c01a7336-21626f15afamr77042835ad.51.1733652830695;
        Sun, 08 Dec 2024 02:13:50 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21618e6a605sm37035605ad.26.2024.12.08.02.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 02:13:49 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id F33D9DDB017; Sun,  8 Dec 2024 19:13:42 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v3 00/13] nommu UML
Date: Sun,  8 Dec 2024 19:13:11 +0900
Message-ID: <cover.1733652793.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_021352_571344_9146A1D6 
X-CRM114-Status: GOOD (  16.85  )
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

This is a series of patches of nommu arch addition to UML.  It would
be nice to ask comments/opinions on this.

There are still several limitations/issues which we already found;
here is the list of those issues.

- memory mapped by loadable modules are not distinguished from
  userspace memory.

-- Hajime

v4:
- add arch/um/nommu, arch/x86/um/nommu to contain !MMU specific codes
- remove zpoline patch
- drop binfmt_elf_fdpic patch
- reduce ifndef CONFIG_MMU if possible
- split to elf header cleanup patch [01/13]
- fix kernel test robot warnings [06/13]
- fix coding styles [07/13]
- move task_top_of_stack definition [05/13]

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
 arch/um/include/asm/ptrace-generic.h    |   6 +
 arch/um/include/asm/uaccess.h           |   7 +-
 arch/um/include/shared/kern_util.h      |   8 +
 arch/um/include/shared/mem.h            |   8 +
 arch/um/include/shared/os.h             |  16 ++
 arch/um/kernel/Makefile                 |   5 +-
 arch/um/kernel/mem-pgtable.c            | 175 ++++++++++++++++++++++
 arch/um/kernel/mem.c                    | 152 +------------------
 arch/um/kernel/process.c                |  25 ++++
 arch/um/kernel/skas/process.c           |  27 ----
 arch/um/kernel/um_arch.c                |   3 +
 arch/um/nommu/Makefile                  |   3 +
 arch/um/nommu/os-Linux/Makefile         |   7 +
 arch/um/nommu/os-Linux/signal.c         |  15 ++
 arch/um/nommu/trap.c                    | 188 ++++++++++++++++++++++++
 arch/um/os-Linux/Makefile               |   8 +-
 arch/um/os-Linux/internal.h             |   5 +
 arch/um/os-Linux/mem.c                  |   4 +
 arch/um/os-Linux/process.c              | 149 ++++++++++++++++++-
 arch/um/os-Linux/seccomp.c              |  87 +++++++++++
 arch/um/os-Linux/signal.c               |  12 ++
 arch/um/os-Linux/skas/process.c         | 132 -----------------
 arch/um/os-Linux/start_up.c             |  20 +++
 arch/um/os-Linux/util.c                 |   3 +-
 arch/x86/um/Makefile                    |   7 +-
 arch/x86/um/asm/elf.h                   |   8 +-
 arch/x86/um/asm/module.h                |  24 ---
 arch/x86/um/nommu/Makefile              |   8 +
 arch/x86/um/nommu/do_syscall_64.c       | 100 +++++++++++++
 arch/x86/um/nommu/entry_64.S            | 111 ++++++++++++++
 arch/x86/um/nommu/os-Linux/Makefile     |   6 +
 arch/x86/um/nommu/os-Linux/mcontext.c   |  26 ++++
 arch/x86/um/nommu/process.c             |  35 +++++
 arch/x86/um/nommu/signal.c              |  43 ++++++
 arch/x86/um/nommu/syscalls.h            |  16 ++
 arch/x86/um/nommu/syscalls_64.c         | 115 +++++++++++++++
 arch/x86/um/shared/sysdep/mcontext.h    |   4 +
 arch/x86/um/shared/sysdep/signal.h      |  22 +++
 arch/x86/um/shared/sysdep/syscalls_64.h |   7 +
 arch/x86/um/signal.c                    |  17 ++-
 arch/x86/um/vdso/vma.c                  |  17 ++-
 fs/Kconfig.binfmt                       |   2 +-
 51 files changed, 1564 insertions(+), 350 deletions(-)
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
 create mode 100644 arch/x86/um/nommu/process.c
 create mode 100644 arch/x86/um/nommu/signal.c
 create mode 100644 arch/x86/um/nommu/syscalls.h
 create mode 100644 arch/x86/um/nommu/syscalls_64.c
 create mode 100644 arch/x86/um/shared/sysdep/signal.h


base-commit: bed2cc482600296fe04edbc38005ba2851449c10
-- 
2.43.0


