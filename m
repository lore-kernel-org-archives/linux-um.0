Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F7BE6C5FB
	for <linux-um@archiver.kernel.org>; Tue,  3 Dec 2024 04:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mm/iEzNPKD2i0Wok8MO1FkYQe90Cb/1iUAueuSBfNNM=; b=Q8cbncV1YVm6K3uN4qDTFt8s0b
	4Zim3X/hK96/8096uoD/oiMZ4wl7qotz88frCbns2B0NjVcBUoJX+C40iqeKuI1ktUXFKqJ2Jdwpn
	iJ761fR23lZkCuuFFr8gplkbte1r12ZlX3lvsrW+AX4xQ4w6XEISIz51H9CQhXdpDy0eupr+dWEud
	drjzaI50JtgbtVulc2jIU6oD3FgBObW4iF4CJ73hsh+viXqmObObFwK4mPty5tBz3ClCEnXgZ3Wkw
	z7ojD9QjojWCysR8VtlCAQ0EmjEGvefKh2h5hF/cRJ4ApAeqoxit49JFSPplEZ8Hyf7nDn1zjnmQH
	9QAJYDPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKRY-00000008DDK-0ZMK;
	Tue, 03 Dec 2024 04:23:24 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIKRV-00000008DCs-3Pp9
	for linux-um@lists.infradead.org;
	Tue, 03 Dec 2024 04:23:23 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-724e6c53fe2so3759995b3a.3
        for <linux-um@lists.infradead.org>; Mon, 02 Dec 2024 20:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733199800; x=1733804600; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mm/iEzNPKD2i0Wok8MO1FkYQe90Cb/1iUAueuSBfNNM=;
        b=FZNm8NcnjSRT9K3VUUy0A9dvgPp6/46uQXINRux4QEJmEdkrbXCtN72OtN5GIK5ToF
         ez6quACp/iazpD+jF/2lUvrv/sihbVGLpkPRlZXLfntOEBhuQZy81fxs4NdiBZm/9hE3
         41w30jmH/Mf9o/49REBgy2p5kB15uDypphyBjJnPsCkBUUa06YB/L9Yf43iAuD9ucHaQ
         6nDvJlPjiirXniQXC9UkdmIwrHprPeLi0TPnTT5ZplRvmpskcuJW7XT6y21kr4xh76Xg
         iwX0g2+HzbRXJ0AgrOQXgnyuBub966qDXzCewPoUemqbO/0MW0ZbsWanZlz3y5cwUCeS
         3lPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733199800; x=1733804600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mm/iEzNPKD2i0Wok8MO1FkYQe90Cb/1iUAueuSBfNNM=;
        b=g+juWFZWdHurkVTOz6/mWwUlrRkaQLaaCE9/9amyNyy9wDEzwgG9J9Hf8VwWv/Udo0
         zI331K8CbeeBwSxFaDPB6FLjie1+QelErIMfWQQg3AJeF5DFixsqcgs1RBAXLo6klQPp
         krn9ao0X+aGVqipiMbYFob7iY4PqEgnz8T6zVwig0+ZzLl/J7oIKuIFXEGMe3bYiXq5e
         ovzZkUH1MEGGXpeCxidoBMbo083tMrAVqWdCMmyZcvkVIccqW3O1PSqhBhEVLU/XoZ5j
         aezht/ZBZfzrBqDV6bf7aFjJ3niCzs5t48+PvmKhu3OYC/0xcTFWRooaEKTxPamD0g4l
         ew2g==
X-Gm-Message-State: AOJu0Yyw6/s6T1xQRywwdUs559qF+Yh5OkG8l/uk4D98ikpHFjQ7BTFm
	6p/7mMmZWhWlLpCjnDpINBBYT125xqmPSJviuSa6d/Q1OsMTy5gIK4jSDw==
X-Gm-Gg: ASbGncue0uDDn6xfsVkgMgIaEWyuGQj8OqE1N95n/cIAH1psYV92kXpHjEqHHV9ibk2
	x6slf/oQmtPRHkWzJecLOC6fRnlRaIMjsZ+g6wInDUHDwITbmSOXh/0diNkfNQ9YVppPELwf26N
	cmBBSPTmSwU388Z2lyUa+OYJRWuQuTHEDaJh2al6vNIHh2juoNdRmlHfK63wGUASkUR75UwMJat
	Tr7+1594svJ4LgAAfzsenbdj4KN21+Ls1geR7K45Th9KcH2ncIwfP5mmJ1ukLiuam5OmGrq7AxJ
	mx3dbkkJ8Gw71MdaLMqz
X-Google-Smtp-Source: AGHT+IG9TPeB8MZvKtGFY9pR07KFj6e9gUfWqVCZ+AhrGv5aRoylSsZfOpXz6+SV2uCiGl4K/ZkBVw==
X-Received: by 2002:a05:6a00:2e97:b0:71e:6489:d06 with SMTP id d2e1a72fcca58-7257f963923mr1833951b3a.0.1733199800221;
        Mon, 02 Dec 2024 20:23:20 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7254176f4e9sm9427357b3a.45.2024.12.02.20.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 20:23:19 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 14C53DD39F7; Tue,  3 Dec 2024 13:23:16 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v3 00/13] nommu UML
Date: Tue,  3 Dec 2024 13:22:59 +0900
Message-ID: <cover.1733199769.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731290567.git.thehajime@gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_202321_853328_A864D366 
X-CRM114-Status: GOOD (  17.72  )
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

- there are no mechanism implemented to cache for mapped memory of
  exec(2) thus, always read files from filesystem upon every exec,
  which makes slow on some benchmark (lmbench).
- memory mapped by loadable modules are not distinguished from
  userspace memory.

-- Hajime

v3:
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
  fs: binfmt_elf_efpic: add architecture hook elf_arch_finalize_exec
  x86/um: nommu: elf loader for fdpic
  um: nommu: memory handling
  x86/um: nommu: syscall handling
  x86/um: nommu: syscall translation by zpoline
  um: nommu: syscalls handler from userspace by seccomp filter
  x86/um: nommu: process/thread handling
  um: nommu: configure fs register on host syscall invocation
  x86/um/vdso: nommu: vdso memory update
  x86/um: nommu: signal handling
  um: change machine name for uname output
  um: nommu: add documentation of nommu UML
  um: nommu: plug nommu code into build system

 Documentation/virt/uml/nommu-uml.rst    | 230 +++++++++++++++++++++++
 MAINTAINERS                             |   1 +
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
 arch/um/include/shared/kern_util.h      |   2 +
 arch/um/include/shared/os.h             |  15 ++
 arch/um/kernel/Makefile                 |   3 +-
 arch/um/kernel/mem.c                    |  12 +-
 arch/um/kernel/physmem.c                |   6 +
 arch/um/kernel/process.c                |  33 +++-
 arch/um/kernel/skas/Makefile            |   4 +-
 arch/um/kernel/trap.c                   |  16 ++
 arch/um/kernel/um_arch.c                |   4 +
 arch/um/os-Linux/main.c                 |   5 +
 arch/um/os-Linux/process.c              |  96 +++++++++-
 arch/um/os-Linux/signal.c               |  38 +++-
 arch/um/os-Linux/skas/process.c         |   4 +
 arch/um/os-Linux/start_up.c             |  20 ++
 arch/um/os-Linux/util.c                 |   3 +-
 arch/x86/um/Makefile                    |  18 ++
 arch/x86/um/asm/elf.h                   |  11 +-
 arch/x86/um/asm/module.h                |  24 ---
 arch/x86/um/asm/processor.h             |  12 ++
 arch/x86/um/do_syscall_64.c             | 109 +++++++++++
 arch/x86/um/entry_64.S                  | 108 +++++++++++
 arch/x86/um/os-Linux/mcontext.c         |  22 +++
 arch/x86/um/shared/sysdep/mcontext.h    |   4 +
 arch/x86/um/shared/sysdep/syscalls_64.h |   6 +
 arch/x86/um/signal.c                    |  37 +++-
 arch/x86/um/syscalls_64.c               |  69 +++++++
 arch/x86/um/vdso/um_vdso.c              |  41 ++--
 arch/x86/um/vdso/vma.c                  |  14 ++
 arch/x86/um/zpoline.c                   | 238 ++++++++++++++++++++++++
 fs/Kconfig.binfmt                       |   2 +-
 fs/binfmt_elf_fdpic.c                   |  10 +
 include/linux/elf-fdpic.h               |   3 +
 44 files changed, 1307 insertions(+), 58 deletions(-)
 create mode 100644 Documentation/virt/uml/nommu-uml.rst
 create mode 100644 arch/um/configs/x86_64_nommu_defconfig
 delete mode 100644 arch/x86/um/asm/module.h
 create mode 100644 arch/x86/um/do_syscall_64.c
 create mode 100644 arch/x86/um/entry_64.S
 create mode 100644 arch/x86/um/zpoline.c


base-commit: bed2cc482600296fe04edbc38005ba2851449c10
-- 
2.43.0


