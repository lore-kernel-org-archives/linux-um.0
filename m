Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3F1CCFA1A
	for <linux-um@archiver.kernel.org>; Sat,  8 Nov 2025 08:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bVrmTToxfLVUJdta9yLS+cfGmvlWhwp6IxQjV7bDryo=; b=KW8W6dh2851PX+q3eIviz0vjLn
	g6V6eZP20cwu2JQRZRDTPWogIhYH39gmLppj4teE8BoACRC/RAGEOQea1oPTE5LX4JjYPwsA1i1GA
	h73pwPNvupskcoIpUM54tRnINgOC2Z87M+XMb+nzvHoqq1FBXVyf36NMcd4RBqqtDqzyqEqZ7yOLP
	73MXtfhHq5EViUOPVSW66JYZLoSFhaAkq7PeCkkJStu2x5D02W6knxHgqi6yY8ke0l8/onJuBHwjc
	VeHiPdxcjofqXzJbI1sP5HZJe3TWWxMJiNrWtcxAbI0pjMc9ZdnhUhkJKcMGgzkuTXLx0rpwUn/Ol
	HVqo2JyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxN-00000002ipO-3ehL;
	Sat, 08 Nov 2025 08:05:57 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHdxL-00000002ioC-0UXl
	for linux-um@lists.infradead.org;
	Sat, 08 Nov 2025 08:05:56 +0000
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-343684a06b2so608211a91.1
        for <linux-um@lists.infradead.org>; Sat, 08 Nov 2025 00:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589154; x=1763193954; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bVrmTToxfLVUJdta9yLS+cfGmvlWhwp6IxQjV7bDryo=;
        b=J0GXBtfY70kI81mcp9/r45nvLChFxhogkUgGA5QVpckqIA2i8fyeoRuMKX/6zkTEyo
         ChhsAKiMKC2sN8jYp6Sz4oPcBsaR9EC5x60IFZvshJNA7GqRw8/1Z3DiJmkPmugjKm7X
         U5oH+eUobpy/95H6q7aWmO+YuchZ4O8VBR8vSUVFhgHX17vo7c3aGzVo+gOW+YAZFGfI
         YRFr1Rqu1UkABnnIBdNpaj2AU9hP+NbWzyBB1gbwpT73/lW6vTFgP/dzLcZgwmshAZ1N
         6Io+CiNDord32/8RiGbcxLlUYN0Q8sTPE1mWCF6ediQKBp9nQJPRViLaY7f+bWMDyMXN
         F0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589154; x=1763193954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVrmTToxfLVUJdta9yLS+cfGmvlWhwp6IxQjV7bDryo=;
        b=iP6UA9F5XUZIdkVQzJRqgmg7TsbCOmC1hJOYTH2fFFn8l3d7Six6YC+/M12X4rgUKA
         WmzmcZst1uucg3Y4ma11FiCPx54E/Y5DhTOf53G3hiN1smhCfcdCmav6Vccy3aUBIv5n
         YAqHsx+GQJMNNBhjnpaS+hURvMc5pvPkdb5XhzEtiQOeytHQCKOYg/WSOT6F9v/NcZN1
         mzSsLGziGYyI4opT/5pxN2oDDe5q6gZQ8UTjMzw2OE72kYlH+34YfrNa4XNUd2VFDNeL
         i5att8zXRW4yz6yrqE+UdjVhtO+xdJQAUBF+Ca9yN33wvdg+b34D+fscGXTJ37ZxAJwU
         2d0w==
X-Gm-Message-State: AOJu0YwmKLU0oBEcpPzQ3g7U+n/EclDPNoIUlm+DYZYrnBFI7zBuLEiI
	amKoOYJnBgn1CYScRVgyvZ7IeT+3FlZZe7hLh70qpHLf0VNB8rfid7Sv
X-Gm-Gg: ASbGncsd1XQZidK+NIxEFpZ6OtElUMGxQmJsMazklxqQY2MAwdSvZQmmZ6N6GIk1//N
	tqpAg+FuA+gdOQLhV3n1mTiwKP1xwo3l+AOmgxka4rw3FzgTmYqldaJyl16xQZXqHQxq/4IM1z3
	+6ErW+ih6DzAAzJtGDu/Kk7ZH34fE5RMuhAqULw40ICYyhc6888b6tfZS0m3+btUUvWtvl2noLZ
	2Xu1aebw1kKCQTibGIwpti6yAAWcBut+fN+cbq2CMGIij/MLylfNkvnuIKKBr3hREoQ8AlECkFH
	NVJibf3hRiS41KeSCIt6u6f8dOogsrKzTKUHsZvHe/aPkYo/FpD0QZxkHGvApiJvKS22fXMJpQd
	He796bWXw8wqx/iCmGNI2K3Bb6vvnLwTyM/Dweitnf+sdt1QAVZ8w3gPBU6p6gKgtznkuXo+NDD
	8WPnnC/s+5rmE35LyZ11mJr9eg85MC826rPc8aYCBQteRb2Q==
X-Google-Smtp-Source: AGHT+IGXnolar7zmjl8A40jhYHOAiihHc85hfdRPHtpFpd3YevpTqY89YO9BiLV/lCPDKV1hb6Ppvw==
X-Received: by 2002:a17:90b:350d:b0:340:c261:f9f3 with SMTP id 98e67ed59e1d1-3436cb8a0bdmr2291860a91.14.1762589153717;
        Sat, 08 Nov 2025 00:05:53 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343727dcf3dsm993051a91.19.2025.11.08.00.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:05:52 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 310AE11388C4; Sat,  8 Nov 2025 17:05:51 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 00/13] nommu UML
Date: Sat,  8 Nov 2025 17:05:35 +0900
Message-ID: <cover.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251108_000555_167154_6B4AC7A7 
X-CRM114-Status: GOOD (  21.03  )
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

v13:
- rebase with the latest uml/next branch, fixing a conflict ([06/13])

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


base-commit: 293f71435d14f5b5c46fc3398695fa265c69363d
-- 
2.43.0


