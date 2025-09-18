Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1525CAC597
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 07:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jStWRzRNYsxk+X2bNGHho3RfC0kIE4UPvb/cKZ6ftGc=; b=XnB3NhG3sfDP1hJEkcsFGfm3i7
	UHMe9S1ri4KQmoCCNRzfbzzn6C/T4HGTJqX8tpfb0D2I0rid8gEBRmi4ZFpXPgSonWSmY9OjOamZC
	34cCahOAedM7iqU7K3vg9Qg2n3NaJy2ySlR2xOz2urpyKArKJXNQRlJncmZI5r5JjGwvqBAwQ6aW6
	uzs/t0AiUC9cr+/zRsvslT7M3twU1BLKO7ZicudzCXnaAfNuF85dLOqKrPBQdkj2CbKoPirKQwNJw
	Tj6TMb9+aM+2s0rYQ+sm09rpeX+Ky78BW0qD1QS4/xojyQY/EgV8QvqKwg+ErTU3HNvC+S+VRr7iY
	hOb0fVpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Ef-0000000GZ2B-0jhj;
	Thu, 18 Sep 2025 07:39:21 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Ec-0000000GZ1J-3lWx
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 07:39:20 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-772301f8ae2so665038b3a.0
        for <linux-um@lists.infradead.org>; Thu, 18 Sep 2025 00:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181158; x=1758785958; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jStWRzRNYsxk+X2bNGHho3RfC0kIE4UPvb/cKZ6ftGc=;
        b=RMVDnTnd6Txos/2ufzIxMft4mufgN0a/tBBNLEB6j4hxYNpeY1qFqZEdw4x+eb49c/
         0h8fb2IFVLd9UVUzbtO5pQ6LSDAgAM4YRU99PrrOFSnqWKCKD9rYNN0fSubyrHJL6CZy
         LUkmsG0eqIipb+txukwzUnJ+IXyt9BPZK1xRN+TBDhZmZe9dE1tRiyAEY5zaYNIUgwGN
         evGxxvm56vcXTEUgHQ2vI73GQa3//FMffG1wHy28AMOlMy3JFzVXG44G+ExyX9HXUMD/
         wAQ7p8YHB3R/bOuhmMe4GXMrb4n9keOw30ZFZCkq8QrG9naWTwkKYSG0reVuw7gx1BDz
         gzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181158; x=1758785958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jStWRzRNYsxk+X2bNGHho3RfC0kIE4UPvb/cKZ6ftGc=;
        b=l6aI1zL2ZpSACq/3rSb8vXNPd5Up/6pVyhmKuyW0YmVLE/6D6zWFZkAhyFPmghWDni
         WV2Q5apzNM37UBFyGEEHRCZGlHfAiFfc73WstkDpichB7YjCZglTtcUxKdfhauzdVOej
         tkRMNH8aQCb4+xlE+1KQAztvXhfFt/OyuTfllUTo9PZdD3qqB4iU7NPeyCT0p0vO4uUo
         HlKIHrq8xhbTaVWMyiqEj+oKf3axA2T/kN28uBNf4j0m39cIr3/rbgmYhrOdkV74e0Zm
         KaZgwCohrx+n8kjK6QN8wzpeKJcQFmjVu+2zW0VeLRnxn59a2dgIpIwgVCCmFmF1jpoS
         UP2A==
X-Gm-Message-State: AOJu0Yy/jUuHK39b12aiNQkRUDyEcZni6vcxGjfSi9/FRnbMr3cPM0Tw
	53Ui6sRMFP/mmQxt4hrtM1vOOKI4lyXHGd1YqsdMjI5Jtsy+gY04iEvriL2bbQ==
X-Gm-Gg: ASbGnctIGfkooqi3PEQkGLd1uBdfQ68VSI+k+sLoZdO996wVGsGCAVb06ch9ktpT0Hz
	U+wHY95n55srMS+6C6IYbiPcGrK/ppl9/SiFKOdxlb+EU3aba7sthJfVYg+pmtqS6wbNNmFbc95
	jrekGqvj0CiWLBbQNC1WP4KlW0r+WcE1Tg+jjTkDE93t8NqvqNOOKiUOKohO4f1cTHZFBmhYlCH
	Zajm5/0QRNeZijL5Pr2iWumMBQtTaz/3XNbBmQ6fT6QEB3GDHL50TuP3yNXTzz1ksg14Dv62Ga0
	rqu/1d+75WGlkjGsuRwJkfC1jXe7ZoMc/MZhCEHhFtlQNZPx5GWsRFM0AsKhomC1azX69fxqevr
	LkPSPG8AbWQvyFwtpi9rm2Gl0lrr1ESIr+QbTpOmrLULUTJ0zANVojgMPtozOaVNzkE15Kc9Nhi
	067J80ZJVDqvl5Z1asaU6ysg==
X-Google-Smtp-Source: AGHT+IHQmiPxhPbN9GzliabZxstIkW3EABHZh4MIlCfOq+gcLYwzlRp75BZsSfEKT1g65JzPC200gQ==
X-Received: by 2002:a05:6a00:1f10:b0:77d:7b79:a622 with SMTP id d2e1a72fcca58-77d7b79aa0emr922983b3a.14.1758181157945;
        Thu, 18 Sep 2025 00:39:17 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc245e29sm1493766b3a.24.2025.09.18.00.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:39:17 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 0B91310620FA; Thu, 18 Sep 2025 16:39:15 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v11 00/13] nommu UML
Date: Thu, 18 Sep 2025 16:38:55 +0900
Message-ID: <cover.1758181109.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_003918_942439_C96E90CD 
X-CRM114-Status: GOOD (  21.71  )
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

v11:
- clean up userspace return routine and integrate to userspace() ([04/13])
- fix direction flag issue on using nolibc memcpy ([04/13])
- fix a crash issue when using usermode helper ([06/13])
- test with out-of-tree kunit-uapi patches (which uses umh)
 - https://lore.kernel.org/all/20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de/
 - https://lore.kernel.org/all/20250626195714.2123694-3-benjamin@sipsolutions.net/

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
  um: nommu: a work around for MMU dependency to PCI driver
  um: change machine name for uname output
  um: nommu: add documentation of nommu UML
  um: nommu: plug nommu code into build system

 Documentation/virt/uml/nommu-uml.rst   | 180 ++++++++++++++++++++++
 MAINTAINERS                            |   1 +
 arch/um/Kconfig                        |  14 +-
 arch/um/Makefile                       |  10 ++
 arch/um/configs/x86_64_nommu_defconfig |  54 +++++++
 arch/um/include/asm/dma.h              |  13 ++
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
 arch/um/kernel/process.c               |  25 +++
 arch/um/kernel/skas/process.c          |  25 ---
 arch/um/kernel/um_arch.c               |   3 +
 arch/um/nommu/Makefile                 |   3 +
 arch/um/nommu/os-Linux/Makefile        |   7 +
 arch/um/nommu/os-Linux/seccomp.c       |  87 +++++++++++
 arch/um/nommu/os-Linux/signal.c        |  24 +++
 arch/um/nommu/trap.c                   | 201 +++++++++++++++++++++++++
 arch/um/os-Linux/Makefile              |   3 +-
 arch/um/os-Linux/mem.c                 |   4 +
 arch/um/os-Linux/process.c             | 138 ++++++++++++++++-
 arch/um/os-Linux/signal.c              |  11 +-
 arch/um/os-Linux/skas/process.c        | 126 ----------------
 arch/um/os-Linux/start_up.c            |  25 ++-
 arch/um/os-Linux/util.c                |   3 +-
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
 45 files changed, 1312 insertions(+), 209 deletions(-)
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


base-commit: e66ae377fe219c98d3d5b8a0d35da4413a5390ca
-- 
2.43.0


