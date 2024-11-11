Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9CBD12D76
	for <linux-um@archiver.kernel.org>; Mon, 11 Nov 2024 06:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wpl1iR+0Y26CWXV/kUmKOepSogFAWZLSfMeJZXKOdEg=; b=DD0MmW3S5zPTGPJHuaUHeksaSF
	odDAJkNq2WUaBWfdxu530m8lDdgHybfAdb4ukF2rJjeN7RlUBjB2c/hoHEM+6pgJwukjJS2CUIBQO
	3xwZaxFB+Q8oLTqmeWjAT0UJRT0GXGYfflf/zttUL+pPDN5GxGUHzPQALoD79ZfZy0KnSziyMj8U3
	3gmcPmfmBLN/XRdKDNPrdDND6CLgsDQub9sRV41LjWSoZyuYV7vUF3y3BjC7X7EmrjBJ0nIOAFAzl
	KdA+V3956VjnxeXKDXbeDm5OoxXuUBIMOK/o4SuAVLCjyTygzii6CzfIfqeuaOEip39ThYJ2q8GoT
	+rdk28+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tANtc-0000000GU3w-1WWD;
	Mon, 11 Nov 2024 06:27:32 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tANtZ-0000000GU3N-2LhU
	for linux-um@lists.infradead.org;
	Mon, 11 Nov 2024 06:27:31 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-20c6f492d2dso45363675ad.0
        for <linux-um@lists.infradead.org>; Sun, 10 Nov 2024 22:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731306448; x=1731911248; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wpl1iR+0Y26CWXV/kUmKOepSogFAWZLSfMeJZXKOdEg=;
        b=PQUDv/kgdoXuV6qHa8+BqCPXjj4kccWgerOB4wLHN4aTt/Y0rNaV23Dw/n5qsaCCel
         YgoU/iXnFfLMzNP6B0YfqwUAKYnTLpHFXOIH5Ds/7nbNIeL+AUz3oWyq1xoQl5MdXvqP
         pMnWRF8oB5jG/ZRqWoDpQEck+NoRuflCRdnGk29PRuqDMJCHPnuuAvcRDUFuyUjNOC3O
         AfCLqSaBDSbKXgwECfMKZ7FlViHuLNbm6UZHimdpeXVw3aFbEGYk1nQm0lwmNEBpVTdJ
         DHDf095vnCT5KyLVwPqd7vyOfBcAaH6fHhR48SIEEZSywa6tb8uGrNmnHrZ9gavG2Opo
         E4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731306448; x=1731911248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wpl1iR+0Y26CWXV/kUmKOepSogFAWZLSfMeJZXKOdEg=;
        b=qfTeq5alohgEGZ+gY9sFiOj2L46jpNY3+yhttSigmv5Z0G0OfxcuAFuJmFxzrCfroB
         XPQF6/KndiL0gmQyrvfXG4XImcoUnEeY/km+MApgmPyg3MnTmGI9qDzPy+2BxVj60RIl
         dN2akJkzmVxc0CO9XsJ9eR3BGdgzmOanmJnQHcI8cmsUPDCPgsjptFOCMUoeFmmXULmJ
         2xQdPTHoWNaOeLpMGZNwwRpXkRXe4DE0YXHygZHio1ksvUwakLRdVVDqdo+0EinInq1d
         UeKdje6sFk1op8bdY248qahDqE1Wt6sigtSYBLH2Bin5mVONSbEERMtK6LouVfqhSeFV
         2UKA==
X-Gm-Message-State: AOJu0YyhHzPp4cXT6q52aYS+SkthqJPdyUiZTHe3LrRul2Q8FrKaTkIv
	68xTdmEcD5i/fTTwu7ofZZDfLMNsYw9UUnfWQsGwyPiutWNm6OwJ
X-Google-Smtp-Source: AGHT+IGm7o3j4RK+QcZOMtBG5aASUeD8QAzGXbyt3GZ0wLfpgUdltMXARApa6Q5bGEnOpv+ryHsFjg==
X-Received: by 2002:a17:902:cec7:b0:20b:b40b:3454 with SMTP id d9443c01a7336-21183327a44mr164016045ad.0.1731306448122;
        Sun, 10 Nov 2024 22:27:28 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc7e0fsm69226435ad.21.2024.11.10.22.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 22:27:27 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 3E27EDBA912; Mon, 11 Nov 2024 15:27:25 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [RFC PATCH v2 00/13] nommu UML
Date: Mon, 11 Nov 2024 15:27:00 +0900
Message-ID: <cover.1731290567.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1729770373.git.thehajime@gmail.com>
References: <cover.1729770373.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_222729_626426_8202AB32 
X-CRM114-Status: GOOD (  15.59  )
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

- prompt configured with /etc/profile is broken (variables are not
  expanded, ${HOSTNAME%%.*}:$PWD#)
- there are no mechanism implemented to cache for mapped memory of
  exec(2) thus, always read files from filesystem upon every exec,
  which makes slow on some benchmark (lmbench).

-- Hajime


RFC v2:
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
  fs: binfmt_elf_efpic: add architecture hook elf_arch_finalize_exec
  x86/um: nommu: elf loader for fdpic
  um: nommu: memory handling
  x86/um: nommu: syscall handling
  x86/um: nommu: syscall translation by zpoline
  um: nommu: prevent host syscalls from userspace by seccomp filter
  x86/um: nommu: process/thread handling
  um: nommu: configure fs register on host syscall invocation
  x86/um/vdso: nommu: vdso memory update
  x86/um: nommu: signal handling
  um: change machine name for uname output
  um: nommu: add documentation of nommu UML
  um: nommu: plug nommu code into build system

 Documentation/virt/uml/nommu-uml.rst    | 221 +++++++++++++++++++++++
 arch/um/Kconfig                         |  14 +-
 arch/um/Makefile                        |   6 +
 arch/um/configs/x86_64_nommu_defconfig  |  64 +++++++
 arch/um/include/asm/Kbuild              |   1 +
 arch/um/include/asm/futex.h             |   4 +
 arch/um/include/asm/mmu.h               |   8 +
 arch/um/include/asm/mmu_context.h       |  13 +-
 arch/um/include/asm/ptrace-generic.h    |   6 +
 arch/um/include/asm/tlbflush.h          |  22 +++
 arch/um/include/asm/uaccess.h           |   7 +-
 arch/um/include/shared/kern_util.h      |   3 +
 arch/um/include/shared/os.h             |  14 ++
 arch/um/kernel/Makefile                 |   3 +-
 arch/um/kernel/mem.c                    |  12 +-
 arch/um/kernel/physmem.c                |   6 +
 arch/um/kernel/process.c                |  33 +++-
 arch/um/kernel/skas/Makefile            |   4 +-
 arch/um/kernel/trap.c                   |  14 ++
 arch/um/kernel/um_arch.c                |   4 +
 arch/um/os-Linux/Makefile               |   5 +-
 arch/um/os-Linux/cpu.c                  |  50 ++++++
 arch/um/os-Linux/internal.h             |   5 +
 arch/um/os-Linux/main.c                 |   5 +
 arch/um/os-Linux/process.c              |  94 +++++++++-
 arch/um/os-Linux/signal.c               |  18 +-
 arch/um/os-Linux/skas/process.c         |   4 +
 arch/um/os-Linux/start_up.c             |   3 +
 arch/um/os-Linux/util.c                 |   3 +-
 arch/x86/um/Makefile                    |  18 ++
 arch/x86/um/asm/elf.h                   |  11 +-
 arch/x86/um/asm/module.h                |  24 ---
 arch/x86/um/asm/processor.h             |  12 ++
 arch/x86/um/do_syscall_64.c             | 108 ++++++++++++
 arch/x86/um/entry_64.S                  | 108 ++++++++++++
 arch/x86/um/shared/sysdep/syscalls_64.h |   6 +
 arch/x86/um/signal.c                    |  37 +++-
 arch/x86/um/syscalls_64.c               |  69 ++++++++
 arch/x86/um/vdso/um_vdso.c              |  20 +++
 arch/x86/um/vdso/vma.c                  |  14 ++
 arch/x86/um/zpoline.c                   | 223 ++++++++++++++++++++++++
 fs/Kconfig.binfmt                       |   2 +-
 fs/binfmt_elf_fdpic.c                   |  10 ++
 43 files changed, 1262 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/virt/uml/nommu-uml.rst
 create mode 100644 arch/um/configs/x86_64_nommu_defconfig
 create mode 100644 arch/um/os-Linux/cpu.c
 delete mode 100644 arch/x86/um/asm/module.h
 create mode 100644 arch/x86/um/do_syscall_64.c
 create mode 100644 arch/x86/um/entry_64.S
 create mode 100644 arch/x86/um/zpoline.c

-- 
2.43.0


