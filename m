Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3541CE77188
	for <linux-um@archiver.kernel.org>; Tue, 14 Jan 2025 11:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KzIoqUFnfn18Jicgrsuc63i7gGyP5+jCxoMSmhVj+0s=; b=L+scFWjjOzyj47Gil92lXaqp/8
	WB7I1ukHp38c7uTfOSbc48fCDVP6uCrSMY7BdnQF15p7CJC49/C434U9JLyf6u5zkJLL/22eCObVZ
	1rIaFmJfJNIvYbzGhkSkHHJbctqQ6eputBleYJqTNXC2aN0Zd4rzoZX8bepRlzQ0v5lkwgvMB1AnI
	yaO+wcvE6ODixdRoF0IjO7e/ks6JxMAagBbjBgAtMqO2qwf2nDEBAeq0HuRBTwQ4tx7Jxa6bG8AQU
	v9y4q2C/f/2b8ApLbS+MxvigcewzXrDjsqQt7OAcy8nSjiK5iVAtOaTo5khZl0kVWUNQEjLiOU0b7
	xxod11Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf9Z-00000008GIj-3OTG;
	Tue, 14 Jan 2025 11:32:13 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf8N-00000008G0K-1at4
	for linux-um@lists.infradead.org;
	Tue, 14 Jan 2025 11:31:00 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-21661be2c2dso91382305ad.1
        for <linux-um@lists.infradead.org>; Tue, 14 Jan 2025 03:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736854258; x=1737459058; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KzIoqUFnfn18Jicgrsuc63i7gGyP5+jCxoMSmhVj+0s=;
        b=V4YOzJ5Agmj+76mS4v4S7UGGa+yk5A2lFiLDHfZYtbccP3Fl6j/UjVLAe3pdq4zgb9
         Ve3WfAhZGP+q9wBUcheJKNo54uSpQ0K4C5f6Lm712/oYGamqN4nUEqIPwPArMVp6XHKO
         sYalUF1+RbclDTn9IEHv/Lh2KRjO8XOVF75o1gzcP124ypPNeGptsFxlMp9rlYa6z+jr
         QbqdfIANQ/ov5nZS+xVJpbPtp5OfN8TgGiDLC9gEnIQv/e6OK/N2EXn9/Y0RjreCiwOO
         A1rjn55Zv/kdmuiKia2GABYUIE5rvkLAmOQet5ArmwDA3BblcE+1hi5tZCOq8QdzyDcZ
         9EEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736854258; x=1737459058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KzIoqUFnfn18Jicgrsuc63i7gGyP5+jCxoMSmhVj+0s=;
        b=Yi7cSnCIRCNh/CZrYVL7omDC8/iTcmm1sh++mXDEgmw4+Se05ns2i9LvQpVtGTlDdh
         2hiUM1mN8J+VM1EpDBCv4ujtS9jYbYPSj2DaWWG1twmCAs6k8GX8K1229b6iaKEQXD4N
         hgDEqnKb/HhqgWsTucWNaXaHGdsK+Se0thS7gzls2i/qudkqHLaQ7/fMNRx9wzwr3ldH
         EQIUxuvc7+x0KZVWfdRzVfhospd4Ph0ZLQ+9wsd/mlA9r5FIATgThtuYAK6m/t18To+G
         GzP2VCIvzA9+Lqi4cfRS50f7Qe3vhfPgEOpAqtePBnT8ottlrfz8xhJsksVHXZqF7vA9
         4V6g==
X-Gm-Message-State: AOJu0Yx/2f84bl/8RMaE56spZM5oQroKTxU9t/LOBSxDviY3v5d4SMZE
	lVynTfhSxGVR6RFcLZKrAGDlPYwCQUQVfJRJp9Vx32DO8DSrV3mb0pGoqA==
X-Gm-Gg: ASbGncuWzI8EUIIYtp9clgfie5c8bLAGAVNBKwvN8vcK01X3mW4WKb4xVUi0kwe31f4
	hpl8iljH0jtMSMEYolqH7tI1xSFOnqvXlGkJgAlrPExW1DCahdr/sM4Zxx0/5HE8D3iKK4ikz2Y
	zNpv9oX6Jjehw1m6W3xBTDLtQGwIWT6HYuoutI4+nieZoLLFoMdp4jz/vgkIu6nTzNxMkB3uAI2
	u/I+qPb2g2f5l+nUetzfUhlZWqUNi/NOdfBRGzPdbwVzoRpS6mNpOfzE+HCAwtOjj8yQ8cgUnoh
	f9M7lAb4z70ScYIQQdTo6SLCMbMR
X-Google-Smtp-Source: AGHT+IFI1+uYb2igIIeMpX95sd+zTjjUC5QdNsIbrTr4VY+eGboabpM2sMABN3hEUG1R1Mt1lg8DsQ==
X-Received: by 2002:a17:90b:35c7:b0:2ee:e961:303d with SMTP id 98e67ed59e1d1-2f548f3f994mr34768335a91.35.1736854257849;
        Tue, 14 Jan 2025 03:30:57 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f5593feaebsm9285747a91.13.2025.01.14.03.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 03:30:57 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 1162AE1AB4C; Tue, 14 Jan 2025 20:30:54 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v6 00/13] nommu UML
Date: Tue, 14 Jan 2025 20:30:38 +0900
Message-ID: <cover.1736853925.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_033059_425517_D6EC0519 
X-CRM114-Status: GOOD (  19.63  )
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

v6:
- rebase to the latest uml/next tree
- more clean up on mmu/nommu for signal handling [10/13]
- rename functions of mcontext routines [06,10/13]
- added Acked-by tag for binfmt_elf_fdpic [02/13]

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
 arch/um/include/asm/ptrace-generic.h    |   6 +
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
 arch/x86/um/nommu/do_syscall_64.c       |  74 ++++++++++
 arch/x86/um/nommu/entry_64.S            | 113 ++++++++++++++
 arch/x86/um/nommu/os-Linux/Makefile     |   6 +
 arch/x86/um/nommu/os-Linux/mcontext.c   |  24 +++
 arch/x86/um/nommu/syscalls.h            |  16 ++
 arch/x86/um/nommu/syscalls_64.c         | 115 +++++++++++++++
 arch/x86/um/shared/sysdep/mcontext.h    |   4 +
 arch/x86/um/shared/sysdep/syscalls_64.h |   6 +
 arch/x86/um/signal.c                    |   7 +
 arch/x86/um/vdso/vma.c                  |  17 ++-
 fs/Kconfig.binfmt                       |   2 +-
 47 files changed, 1328 insertions(+), 244 deletions(-)
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


