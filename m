Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467B9C3ABAD
	for <linux-um@archiver.kernel.org>; Wed, 30 Apr 2025 04:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yisMRp57N4S0wfYh8oqiHXWJMZDekJ9wSMzIJzMXX/Y=; b=VkMuKKUFIxT/zT/GVubaCuSH05
	8XXubV94lwiTVP+TrJCtQt8tBVAS7N62A2R5hHHmCTZuooTU7mMiSEJO0RJFMhD8fNktftHM6gEzv
	FD1BeknHtLeSBoFPlsiTe4XSgNScy5kBdn3P/uHqubl0Y25jqKZIaFPQyMuxR0y2+fkWhxFN4owJK
	DtJQ7tmUffanT5TSPOWHQ2LytHWodlV2Wte6A+51rouQCBia+PJGmRLpIuBviI2GAiAUFbORJ33WX
	BRecK+hXjEHF69g2kBRR34PxP6fZ/IgtLVqHRzWzHcYmL1Pr3z52//UUiCAOkhyoF0ICqNtwEV87k
	MZMTjl4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9z4A-0000000BffW-1mrA;
	Wed, 30 Apr 2025 04:29:02 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9z2j-0000000BfOo-2Spw
	for linux-um@lists.infradead.org;
	Wed, 30 Apr 2025 04:27:35 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-223fd89d036so85387775ad.1
        for <linux-um@lists.infradead.org>; Tue, 29 Apr 2025 21:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745987252; x=1746592052; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yisMRp57N4S0wfYh8oqiHXWJMZDekJ9wSMzIJzMXX/Y=;
        b=AQ5U49fDiQv0EPexjDqpuMrP6zs5Tgu0pK+6vBxUNIZEKovrA6tTfxGKCnjULClnJT
         qpYk0zWy/fpWIluUdpC7z006Gm6C9N4VpiSlaN8BMAD0HrS06gR1/UhE2n24ZSQDh9FM
         pFjP2FWHrWFpxtg/zSluYc4PUAfdL2JpaUnQiQaO+9kYFIqCIfgXMmdGkxbQodrPnmLu
         8Sh3sgBjJU5djfzrq/94CvL0lrDZe93uNCztbVG3YTRBjnz9OMyQHfjWKCzQYOg/l0lI
         gJRDhXaQLIazCiUT+JnP7mNokTHQREqDGiqoYP7PgEglx9MdDw0JtzrRc94Za8C6YYcF
         /D0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745987252; x=1746592052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yisMRp57N4S0wfYh8oqiHXWJMZDekJ9wSMzIJzMXX/Y=;
        b=JVJ1NNfkh996xcwsUwx8NgZjcwG/bGabaB3TbVqgKmDiKXGLOO7N1t6waHLg1HYbX3
         yAZ8bkNwWJq69n1esVQR1x84gB4wkVzokAa+wdCSrWxc1XsFAMZXlp+KfdK5yWGJw5sY
         Mw7swl0UsZW2uBl3vYqYC+3n8WdD8L8AmS/QcxBVhdJuJNCJXDTScROi7GX3Vzc5Jl5I
         rKCX2NU8DMKrm5FHwJgeu+7AjgIShx0ncFu0RmBVYp2FkjH8hpUCbtimHONc8vjUwdAm
         f+f9YJb4irfD/E+2HFloFqY0MCib4+v95zuEOdZuUkYmPjqJ0ibIK1KlCKyt/+lXjwdc
         c+Vw==
X-Gm-Message-State: AOJu0YzzxHChFAJqy3vPX/Y53j6COWXQIVfwMb0BkEUd+NXXlqiTcBlB
	RPQVheSEMkFyqT9OLcNSC+RGyRVFohdgDi00oDNuDS7v284kjMSr
X-Gm-Gg: ASbGncvhUabYthbD3hT+HelkIAoxoqhifjR3RBdGaW0NVnfDPYXgHpkwdNLO/onnbO3
	ZlZ7e/jSB1Sjvo8gGbZ0X7lEkgfxfXkyQ95DrmEEfcGckXgzXV/C1QwiFiDE1zrczQJhSvM8D/b
	ylK8VfOnukjgdmd3n8WByX05QDUU3C2K+FxK9JgClrGGekgzzSsMhXre0MMcK5CGKWlvTys0I0C
	qSGv4Jedeq+xsiSWC53f52ldH08wCJWk8qhZc6QMP0UrQ8m3PdmfZ7FljlCE4k8DY3zNV2xw82/
	DF1xIhEkaKu0lkTefmmkTd7gQHXYpO+3tmo7tyUeul46Z5cfYqob+kH5WYXExVBj2EGpH4h/0m9
	YL/jg/M+XyRJ4TMDc6AKBJg==
X-Google-Smtp-Source: AGHT+IGz+n4eA0EfImRh+nJJwNNRW/jRDDM+weYXGUXjyWriWtExutVfGVYvVxhjAZdB3/oAoBwgQg==
X-Received: by 2002:a17:902:e546:b0:229:1717:882a with SMTP id d9443c01a7336-22df5764855mr15094535ad.4.1745987252183;
        Tue, 29 Apr 2025 21:27:32 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db50e7b50sm112281735ad.130.2025.04.29.21.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 21:27:31 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 02A30E94812; Wed, 30 Apr 2025 13:27:28 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 00/12] nommu UML
Date: Wed, 30 Apr 2025 13:27:06 +0900
Message-ID: <cover.1745980082.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_212733_675113_019E709F 
X-CRM114-Status: GOOD (  19.76  )
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

v8:
- rebase with the latest uml/next branch
- clean up segv_handler to align with the latest uml ([9/12])

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

Hajime Tazaki (12):
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

 Documentation/virt/uml/nommu-uml.rst    | 177 +++++++++++++++++++++
 MAINTAINERS                             |   1 +
 arch/um/Kconfig                         |  14 +-
 arch/um/Makefile                        |  10 ++
 arch/um/configs/x86_64_nommu_defconfig  |  64 ++++++++
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
 arch/um/os-Linux/process.c              | 149 +++++++++++++++++-
 arch/um/os-Linux/seccomp.c              |  87 +++++++++++
 arch/um/os-Linux/signal.c               |   8 +
 arch/um/os-Linux/skas/process.c         | 132 ----------------
 arch/um/os-Linux/start_up.c             |  20 +++
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
 arch/x86/um/shared/sysdep/mcontext.h    |   4 +
 arch/x86/um/shared/sysdep/ptrace.h      |   2 +-
 arch/x86/um/shared/sysdep/syscalls_64.h |   6 +
 arch/x86/um/vdso/vma.c                  |  17 ++-
 fs/Kconfig.binfmt                       |   2 +-
 45 files changed, 1313 insertions(+), 214 deletions(-)
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


base-commit: 33c9da5dfb18c2ff5a88d01aca2cf253cd0ac3bc
-- 
2.43.0


