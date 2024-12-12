Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FBBE77183
	for <linux-um@archiver.kernel.org>; Thu, 12 Dec 2024 10:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sQwYoQRxtk72mDacERTk0Q0ihyeXCbadPMvvfNbHbaQ=; b=2wsNNE7ATgPOzxUoIMaAFfGWGV
	ApzoITiDN56JZmaXZsEcWxQnb4Ej/VKsTzSfHwbNRoqzTnmDPT0jlYX9u8/nyqrZc4cAzcfwJ6giR
	HB3+0ROiQhiPxh4UnK/0jQ5pULnv9FCglhj5C0CdCKd17AqUMafIW0JX9gs6sHQoeR51UXUbAXNwU
	bdoTHjX4xEDyzB3b+HwBhWuA6Z1jv8INAk2RrBj9tLN0Cg660cp7syLKK6BUIZfdv8yZmIh1Sw5cT
	42FS5n+qwmEs35ashKlhnvqS00kKe54ufN4MyyDx3WB5P59TLCmV/GayykJHJ5sbHh9jLmT0wWxCi
	tK06YLug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgDd-000000001P6-0Mlw;
	Thu, 12 Dec 2024 10:14:53 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgCm-00000000198-364J
	for linux-um@lists.infradead.org;
	Thu, 12 Dec 2024 10:14:02 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-21669fd5c7cso3348145ad.3
        for <linux-um@lists.infradead.org>; Thu, 12 Dec 2024 02:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733998440; x=1734603240; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sQwYoQRxtk72mDacERTk0Q0ihyeXCbadPMvvfNbHbaQ=;
        b=BzPPMFYagtcaAru7dH/90/uINwx64Xt8JMDZuBif/YZb0eo13Ufjf51GFKmklYWXmz
         iWkLskndXZ7yKW/mcIpsPBRjyDizSq+eQOvBTtGrWBig9gYCMrseswHdyzfCRJtn40NU
         susw6lxjs7WaLa3KRIQYM9jX2cTdsHZC+L0oPHJe/h6Ih36rDFhz5qPp68CVqlWG6DZa
         XYQ8Luhs3Wtpy/FaPAj7MvPD2V9qp0dGUuieix4de2aoRY7KIB9y5RtyfA4rp4xBRJbD
         oOhgMOrn0ZIuo+bwJEtDIXKzC9vf+KdvCm9oONd2E6tYAoHQtFU5tEUNjDDictrnbVQt
         z3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998440; x=1734603240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQwYoQRxtk72mDacERTk0Q0ihyeXCbadPMvvfNbHbaQ=;
        b=do79Q8JPyGTdYX2N84nTLj0O5z3pTUmXG9ZqTsH5s77IgI+Sv2TQt4KBiYPlee4a9y
         PrvjmI6qDks3BUZ9hpAokskzz6+knztNpLA4xDHRAjQe9FRjVxolqo3e3VctpVnH8MVu
         OF+ITgerC4p90oOEFTXSLqPMxYpjuXZPS0w5e5D6Lo739/GgBpDAteOAtrMrtrGspPPo
         mM/vgTL1zUAJSj01dgz8kiQ22FTtcZBagHK0k4x6VR+pHnKW+9lQxNnRbFGZOW9Daw5W
         /J5x6xJ7N6do2apM7fCx8TMRvjJsfOxUnMbnuVSXxQKVsNw4yhEuvwctZz5tehvH0PO5
         pVBg==
X-Gm-Message-State: AOJu0YxefpVsgHxkZwRXBfoHLjLgyjpDC5BOy3iINB2r/fVGrsbLvNFw
	SAezh0uA1+hdw9xoSv+kFS6d6h2soU2Fkegl+OlPZDwyHNTV0LqAd5OCIw==
X-Gm-Gg: ASbGnctGz0vCTccpj/oOXoRX8MItQgbASRkk0DWEupRDmRuQD7PbJ2CDUW2LC3O0+rk
	hBbRtq5V8Xduf5/mDOYW03h8GXFv+yE+Us4quNV1Fe10V9U/O0U7fSgNNQgW/6SV/tVs1VZ1ugM
	bvoPdnx4jGggYwwjXtk4wFdLzsGlG9BKI4hiSIFVOf5Sw+wvWFcYt4d4iDiznXkhwjq+8ZLVEQ5
	tN5GE0ZRVNonLBaiNBD0BbX7MOrQPIHgxryZdQwP2fZrGvp/QzmHFBTEPaOx83we7NgA6at0xkG
	vzJPFy93db5ReYGMwtFiL+LgHrc=
X-Google-Smtp-Source: AGHT+IEpeRhliQILOlYQQ+v9FOpxzTcYB41dF7y12N4dfgkvlpTncEKLKpPlgtf7vOogloLez2wDQg==
X-Received: by 2002:a17:903:234f:b0:215:b33b:e26d with SMTP id d9443c01a7336-2178ae5b5a3mr42860355ad.21.1733998439666;
        Thu, 12 Dec 2024 02:13:59 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9dafsm117355645ad.120.2024.12.12.02.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:13:58 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id EB0B4DDEEBC; Thu, 12 Dec 2024 19:13:56 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v5 00/13] nommu UML
Date: Thu, 12 Dec 2024 19:12:07 +0900
Message-ID: <cover.1733998168.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_021400_778618_E4691DCB 
X-CRM114-Status: GOOD (  16.69  )
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

v5:
- clean up stack manipulation code [05,06,07,10/13]

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
 48 files changed, 1428 insertions(+), 349 deletions(-)
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


base-commit: bed2cc482600296fe04edbc38005ba2851449c10
-- 
2.43.0


