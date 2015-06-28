Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <558FF6B5.3070301@nod.at>
Date: Sun, 28 Jun 2015 15:29:25 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: [GIT PULL] UML updates for 4.2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Linus,

the following changes since commit ba155e2d21f6bf05de86a78dbe5bfd8757604a65:

  Linux 4.1-rc5 (2015-05-24 18:22:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.2-rc1

for you to fetch changes up to da028d5e5463dabb6ede2f5e3f6cced1283988cc:

  um: Don't pollute kernel namespace with uapi (2015-06-25 22:44:11 +0200)

----------------------------------------------------------------
This pull request includes the following UML changes:
* removal of hppfs
* initial support for musl libc
* uaccess cleanup
* random cleanups and bug fixes all over the place

----------------------------------------------------------------
Chen Gang (1):
      um: kernel: ksyms: Export symbol syscall() for fixing modpost issue

Hans-Werner Hilse (3):
      um: Do not use __ptr_t type for stack_t's .ss pointer
      um: Do not use stdin and stdout identifiers for struct members
      um: Include sys/types.h for makedev(), major(), minor()

Nicolas Iooss (3):
      um: Create asm/sections.h
      um: Use char[] for linker script address declarations
      um/os-Linux: Use char[] for syscall_stub declarations

Richard Weinberger (14):
      um: Move syscall() declaration into os.h
      um: Remove hppfs
      um: Cleanup mem_32/64.c headers
      um: Add asm/elf.h to vma.c
      um: Add uaccess.h to syscalls_64.c
      um: Add uaccess.h to ldt.c
      um: Rework uaccess code
      um: Fix warning in setup_signal_stack_si()
      um: Catch unprotected user memory access
      um: Stop abusing __KERNEL__
      um: Remove copy&paste code from init.h
      um: Handle tracehook_report_syscall_entry() result
      um: Fix mconsole dependency
      um: Don't pollute kernel namespace with uapi

 arch/um/Kconfig.um                     |  16 +-
 arch/um/Makefile                       |   7 +-
 arch/um/drivers/harddog_user.c         |  18 +-
 arch/um/drivers/mconsole.h             |   2 +-
 arch/um/drivers/net_user.c             |   6 +-
 arch/um/drivers/slip_user.c            |  14 +-
 arch/um/drivers/slirp_user.c           |  16 +-
 arch/um/include/asm/Kbuild             |   1 -
 arch/um/include/asm/ptrace-generic.h   |   3 +-
 arch/um/include/asm/sections.h         |   9 +
 arch/um/include/asm/thread_info.h      |   2 +-
 arch/um/include/asm/uaccess.h          | 176 ++------
 arch/um/include/shared/init.h          |  24 +-
 arch/um/include/shared/os.h            |   2 +
 arch/um/include/shared/user.h          |   2 +-
 arch/um/kernel/ksyms.c                 |   2 +
 arch/um/kernel/physmem.c               |   7 +-
 arch/um/kernel/ptrace.c                |   7 +-
 arch/um/kernel/skas/mmu.c              |   7 +-
 arch/um/kernel/skas/syscall.c          |   6 +-
 arch/um/kernel/skas/uaccess.c          |  47 +-
 arch/um/kernel/trap.c                  |   5 +
 arch/um/kernel/um_arch.c               |   4 +-
 arch/um/os-Linux/drivers/tuntap_user.c |   6 +-
 arch/um/os-Linux/file.c                |   1 +
 arch/um/os-Linux/signal.c              |   8 +-
 arch/um/os-Linux/skas/mem.c            |   6 +-
 arch/um/os-Linux/skas/process.c        |   8 +-
 arch/x86/um/asm/checksum.h             |   1 +
 arch/x86/um/asm/elf.h                  |   2 -
 arch/x86/um/asm/processor.h            |   2 +
 arch/x86/um/asm/segment.h              |   8 +
 arch/x86/um/ldt.c                      |   1 +
 arch/x86/um/mem_32.c                   |   3 +-
 arch/x86/um/mem_64.c                   |   3 +-
 arch/x86/um/ptrace_32.c                |   1 +
 arch/x86/um/ptrace_64.c                |   1 +
 arch/x86/um/shared/sysdep/tls.h        |   6 +-
 arch/x86/um/signal.c                   |   3 +-
 arch/x86/um/syscalls_64.c              |   1 +
 arch/x86/um/tls_32.c                   |   1 +
 arch/x86/um/tls_64.c                   |   1 +
 arch/x86/um/vdso/vma.c                 |   1 +
 fs/Makefile                            |   1 -
 fs/hppfs/Makefile                      |   6 -
 fs/hppfs/hppfs.c                       | 766 ---------------------------------
 46 files changed, 155 insertions(+), 1065 deletions(-)
 create mode 100644 arch/um/include/asm/sections.h
 delete mode 100644 fs/hppfs/Makefile
 delete mode 100644 fs/hppfs/hppfs.c
