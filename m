Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDBCCE8E6B
	for <linux-um@archiver.kernel.org>; Thu, 24 Oct 2024 12:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=A6epXU4AFBXf5QHM4id+mcOkIwg3Mlsyho9foAHi3aU=; b=hhtkU2/cUCEiR4NqaNBiisNuxa
	OaM2ZJDVhn9Lrrr/JeGS2kUNVr4Xiev3BdkuTHmLL0DIbWWMmG28pyDvwrXWjvzWoQ60sW2vk1Av7
	M9s6zqkBeLj9MFplo7IAT8MD081bHzoT2n43BB4W/aBAT6OcLojTjT2FgxWjMEPkpbloU5Gsr5mRB
	Nx/PE/X37jgkPmEJdMge7TAva9NVwr5RvICCgwDRv+YwC/fXRcL8RZFaTRz1dkST6aoARX4lsU9l1
	vV7Xe/QF0sK0JzBhJdqRMssGw7LP7Zy0ouQ+PC9SQlO0E3ch3s7YQ1BpNY6MsZMMXjJGWTccmYHQF
	WU+f656A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wgS-00000000IoT-1VuP;
	Thu, 24 Oct 2024 12:11:20 +0000
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3wep-00000000IQw-0rfc
	for linux-um@lists.infradead.org;
	Thu, 24 Oct 2024 12:09:41 +0000
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso417467a12.1
        for <linux-um@lists.infradead.org>; Thu, 24 Oct 2024 05:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729771778; x=1730376578; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6epXU4AFBXf5QHM4id+mcOkIwg3Mlsyho9foAHi3aU=;
        b=lxl/WXAp7am9LtzeDan9g9kO+p3Y0wH//b1wjj80Ui6I5LKb5BPo6rVRiyezlrppJq
         einDi90UqbmlVwFXAsZe+zSn2Zg7qzidH01+gPOEyBKV9ZQjyOUyd86r5lt13ILPbgUg
         gVWCMLFFTZem+3xOm93M8FIVTPg3hNrYOw8eq558ToV7/21JJOxd7Mz9K/cx7Lr0sYSB
         e5UInAH4uwbGKuyyQw4oo/vNrJ5nh1v5E2QbA5Majj4lXuZojpwOeYVWTrK4SKzEfozD
         /hc/7nfQjAMVyanv6jK/0OE18mLmWXKGpzrxDfdIMQvY4BijET+kvzPnCcx730zHyFpM
         eBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729771778; x=1730376578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A6epXU4AFBXf5QHM4id+mcOkIwg3Mlsyho9foAHi3aU=;
        b=nCp2ZrtX2gwof8L/rCe5dc92FAjUhBPyPyQ8Bv2k2jcABlX3mUdjW0bWXhxR0aMbgi
         YB8VCNMT2squF3zSf5dHkE0UtTF5twZMzYqKweyUOHC4YXKgHmKOODplYazLWvVvDS9T
         BZS2q5q/HdIhNg9Vhh4NJMgrFaHafPGiFPbUW4EPvZ2Hud+CqSETim3oGezLmaOTySyX
         v3sOby/XgKCzZxrILNhAY2ZAJWlTqw6p0zuopuqwNbiHExhgJc0dAAzwasoGWtcltIbM
         agm1NWtdq/dHV4RoaMqsO4X8zPpOSGTETssFS1CiBLL5qcwLhXsa7DxbekmTyWC3r4pK
         CCsg==
X-Gm-Message-State: AOJu0YwJoNgdZnnnRYq5st2Bu0GiiNM6Cr9j6FMN/mlO5H/qXdsS6xBL
	W0iC7T6dWmCH7T3w8WPdzdJ/cb11AyontVp6gOF/Dz1/qwGYxIyN
X-Google-Smtp-Source: AGHT+IFX7H90m4oOrdyLuZqmpyalsi0M78YqIq+At6LAqVr8NKz14yZWJb6FnY65hUtlCpRWh0BJgw==
X-Received: by 2002:a05:6a20:cd0e:b0:1d9:3456:b760 with SMTP id adf61e73a8af0-1d989d438d9mr1682109637.49.1729771777351;
        Thu, 24 Oct 2024 05:09:37 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1312ceesm7811187b3a.30.2024.10.24.05.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 05:09:36 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id F0DBED51247; Thu, 24 Oct 2024 21:09:34 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org,
	jdike@addtoit.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: thehajime@gmail.com,
	ricarkol@google.com
Subject: [RFC PATCH 00/13] nommu UML
Date: Thu, 24 Oct 2024 21:09:08 +0900
Message-ID: <cover.1729770373.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_050939_282150_539D44EB 
X-CRM114-Status: GOOD (  32.09  )
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

There are several limitations/issues which we already found; here is
the list of those issues.

- prompt configured with /etc/profile is broken (variables are not
  expanded, ${HOSTNAME%%.*}:$PWD#)
- there are no mechanism implemented to cache for mapped memory of
  exec(2) thus, always read files from filesystem upon every exec,
  which makes slow on some benchmark (lmbench).
- a crash on userspace programs crashes a UML kernel, not signaling
  with SIGSEGV to the program.
- commit c27e618 (during v6.12-rc1 merge) introduces invalid access to
  a vma structure for our case, which updates the internal procedure
  of maple_tree subsystem.  We're trying to fix issue but still a
  random process on exit(2) crashes.

UML has been built with CONFIG_MMU since day 0.  The feature
introduces the nommu mode in a different angle from what Linux Kernel
Library tried.


What is it for ?
================

- Alleviate syscall hook overhead implemented with ptrace(2)
- To exercises nommu code over UML (and over KUnit)
- Less dependency to host facilities


How it works ?
==============

To illustrate how this feature works, the below shows how syscalls are
called under nommu/UML environment.

- boot kernel, setup zpoline trampoline code (detailed later) at address 0x0
- (userspace starts)
- calls vfork/execve syscalls
- during execve, more specifically during load_elf_fdpic_binary()
  function, kernel translates `syscall/sysenter` instructions with `call
  *%rax`, which usually point to address 0 to NR_syscalls (around
  512), where trampoline code was installed during startup.
- when syscalls are issued by userspace, it jumps to *%rax, slides
  until `nop` instructions end, and jump to hooked function,
  `__kernel_vsyscall`, which is an entrypoint for syscall under nommu
  UML environment.
- call handler function in sys_call_table[] and follow how UML syscall
  works.
- return to userspace


What are the differences from MMU-full UML ?
============================================

The current nommu implementation adds 3 different functions which
MMU-full UML doesn't have:

- kernel address space can directly be accessible from userspace
  - so, uaccess() always returns 1
  - generic implementation of memcpy/strcpy/futex is also used
- alternate syscall entrypoint without ptrace
- translation of syscall/sysenter instructions to a trampoline code
  and syscall hooks

With those modifications, it allows us to use unmodified userspace
binaries with nommu UML.


History
=======

This feature was originally introduced by Ricardo Koller at Open
Source Summit NA 2020, then integrated with the syscall translation
functionality with the clean up to the original code.

Building and run
================

```
% make ARCH=um x86_64_nommu_defconfig
% make ARCH=um
```

will build UML with CONFIG_MMU=n applied.

Kunit tests can run with the following command:

```
% ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_MMU=n
```

To run a typical Linux distribution, we need nommu-aware userspace.
We can use a stock version of Alpine Linux with nommu-built version of
busybox and musl-libc.


Preparing root filesystem
=========================

nommu UML requires to use a specific standard library which is aware
of nommu kernel.  We have tested custom-build musl-libc and busybox,
both of which have built-in support for nommu kernels.

There are no available Linux distributions for nommu under x86_64
architecture, so we need to prepare our own image for the root
filesystem.  We use Alpine Linux as a base distribution and replace
busybox and musl-libc on top of that.  The following are the step to
prepare the filesystem for the quick start.

```
     container_id=$(docker create ghcr.io/thehajime/alpine:3.20.3-um-nommu)
     docker start $container_id
     docker wait $container_id
     docker export $container_id > alpine.tar
     docker rm $container_id

     mnt=$(mktemp -d)
     dd if=/dev/zero of=alpine.ext4 bs=1 count=0 seek=1G
     sudo chmod og+wr "alpine.ext4"
     yes 2>/dev/null | mkfs.ext4 "alpine.ext4" || true
     sudo mount "alpine.ext4" $mnt
     sudo tar -xf alpine.tar -C $mnt
     sudo umount $mnt
```

This will create a file image, `alpine.ext4`, which contains busybox
and musl with nommu build on the Alpine Linux root filesystem.  The
file can be specified to the argument `ubd0=` to the UML command line.

```
  ./vmlinux eth0=tuntap,tap100,0e:fd:0:0:0:1,172.17.0.1 ubd0=./alpine.ext4 rw mem=1024m loglevel=8 init=/sbin/init
```

We plan to upstream apk packages for busybox and musl so that we can
follow the proper procedure to set up the root filesystem.


Quick start with docker
=======================

There is a docker image that you can quickly start with a simple step.

```
  docker run -it -v /dev/shm:/dev/shm --rm ghcr.io/thehajime/alpine:3.20.3-um-nommu
```

This will launch a UML instance with an pre-configured root filesystem.

Benchmark
=========

The below shows an example of performance measurement conducted with
lmbench and (self-crafted) getpid benchmark (with v6.12-rc3 linus tree).

### lmbench (usec)

||native|um|um-nommu|
|--|--|--|--|
|select-10    |0.5645|28.3738|0.2647|
|select-100   |2.3872|28.8385|1.1021|
|select-1000  |20.5527|37.6364|9.4264|
|syscall      |0.1735|26.8711|0.1037|
|read         |0.3442|28.5771|0.1370|
|write        |0.2862|28.7340|0.1236|
|stat         |1.9236|38.5928|0.4640|
|open/close   |3.8308|66.8451|0.7789|
|fork+sh      |1176.4444|8221.5000|21443.0000|
|fork+execve  |533.1053|3034.5000|4894.3333|

### do_getpid bench (nsec)

||native|um|um-nommu|
|--|--|--|--|
|getpid | 180 | 31579 | 101|


Limitations
===========

generic nommu limitations
-------------------------
Since this port is a kernel of nommu architecture so, the
implementation inherits the characteristics of other nommu kernels
(riscv, arm, etc), described below.

- vfork(2) should be used instead of fork(2)
- ELF loader only loads PIE (position independent executable) binaries
- processes share the address space among others
- mmap(2) offers a subset of functionalities (e.g., unsupported
  MMAP_FIXED)

Thus, we have limited options to userspace programs.  We have tested
Alpine Linux with musl-libc, which has a support nommu kernel.

access to mmap_min_addr
----------------------
As the mechanism of syscall translations relies on an ability to
write/read memory address zero (0x0), we need to configure host kernel
with the following command:

```
% sh -c "echo 0 > /proc/sys/vm/mmap_min_addr"
```

supported architecture
----------------------
The current implementation of nommu UML only works on x86_64 SUBARCH.
We have not tested with 32-bit environment.

target of syscall translation
-----------------------------
The syscall translation only applies to the executable and interpreter
of ELF binary files which are processed by execve(2) syscall for the
moment: other libraries such as linked library and dlopen-ed one
aren't translated; we may be able to trigger the translation by
LD_PRELOAD.

Note that with musl-libc in Alpine Linux which we've been tested, most
of syscalls are implemented in the interpreter file
(ld-musl-x86_64.so) and calling syscall/sysenter instructions from the
linked/loaded libraries might be rare.  But it is definitely possible
so, a workaround with LD_PRELOAD is effective.


Further readings about NOMMU UML
================================

- NOMMU UML (original code by Ricardo Koller)
https://static.sched.com/hosted_files/ossna2020/ec/kollerr_linux_um_nommu.pdf

- zpoline: syscall translation mechanism
https://www.usenix.org/conference/atc23/presentation/yasukata
Please review the following changes for suitability for inclusion. If you have
any objections or suggestions for improvement, please respond to the patches. If
you agree with the changes, please provide your Acked-by.

The following changes since commit c2ee9f594da826bea183ed14f2cc029c719bf4da:

  KVM: selftests: Fix build on on non-x86 architectures (2024-10-21 15:49:33 -0700)

are available in the Git repository at:

  https://github.com/thehajime/linux 82a7ee8b31c51edb47e144922581824a3b5e371d
  https://github.com/thehajime/linux/tree/um-nommu-v6.12-rc4-rfc

Hajime Tazaki (13):
  fs: binfmt_elf_efpic: add architecture hook elf_arch_finalize_exec
  x86/um: nommu: elf loader for fdpic
  um: nommu: memory handling
  x86/um: nommu: syscall handling
  x86/um: nommu: syscall translation by zpoline
  x86/um: nommu: process/thread handling
  um: nommu: configure fs register on host syscall invocation
  x86/um/vdso: nommu: vdso memory update
  x86/um: nommu: signal handling
  x86/um: nommu: stack save/restore on vfork
  um: change machine name for uname output
  um: nommu: add documentation of nommu UML
  um: nommu: plug nommu code into build system

 Documentation/virt/uml/nommu-uml.rst    | 219 +++++++++++++++++++++++
 arch/um/Kconfig                         |  13 +-
 arch/um/Makefile                        |   6 +
 arch/um/configs/x86_64_nommu_defconfig  |  64 +++++++
 arch/um/include/asm/futex.h             |   4 +
 arch/um/include/asm/mmu.h               |   8 +
 arch/um/include/asm/mmu_context.h       |  14 +-
 arch/um/include/asm/ptrace-generic.h    |  17 ++
 arch/um/include/asm/tlbflush.h          |  23 ++-
 arch/um/include/asm/uaccess.h           |   7 +-
 arch/um/include/shared/common-offsets.h |   3 +
 arch/um/include/shared/os.h             |   9 +
 arch/um/kernel/Makefile                 |   3 +-
 arch/um/kernel/exec.c                   |   8 +
 arch/um/kernel/mem.c                    |  13 ++
 arch/um/kernel/physmem.c                |   6 +
 arch/um/kernel/process.c                |  34 +++-
 arch/um/kernel/skas/Makefile            |   3 +-
 arch/um/kernel/trap.c                   |   4 +
 arch/um/os-Linux/main.c                 |   5 +
 arch/um/os-Linux/process.c              |  22 +++
 arch/um/os-Linux/skas/process.c         |   4 +
 arch/um/os-Linux/start_up.c             |  47 +++++
 arch/um/os-Linux/time.c                 |   3 +-
 arch/um/os-Linux/util.c                 |   3 +-
 arch/x86/um/Makefile                    |  18 ++
 arch/x86/um/asm/elf.h                   |  12 +-
 arch/x86/um/asm/module.h                |  19 +-
 arch/x86/um/asm/processor.h             |  12 ++
 arch/x86/um/do_syscall_64.c             | 113 ++++++++++++
 arch/x86/um/entry_64.S                  | 110 ++++++++++++
 arch/x86/um/shared/sysdep/syscalls_64.h |   4 +
 arch/x86/um/signal.c                    |  26 +++
 arch/x86/um/syscalls_64.c               |  67 +++++++
 arch/x86/um/vdso/um_vdso.c              |  20 +++
 arch/x86/um/vdso/vma.c                  |  16 +-
 arch/x86/um/zpoline.c                   | 228 ++++++++++++++++++++++++
 fs/Kconfig.binfmt                       |   2 +-
 fs/binfmt_elf_fdpic.c                   |  10 ++
 39 files changed, 1164 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/virt/uml/nommu-uml.rst
 create mode 100644 arch/um/configs/x86_64_nommu_defconfig
 create mode 100644 arch/x86/um/do_syscall_64.c
 create mode 100644 arch/x86/um/entry_64.S
 create mode 100644 arch/x86/um/zpoline.c

-- 
2.43.0


