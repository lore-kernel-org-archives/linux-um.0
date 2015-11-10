Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56426AED.8030005@nod.at>
Date: Tue, 10 Nov 2015 23:08:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: [GIT PULL] UML updates for 4.4-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Linus,

the following changes since commit 6a13feb9c82803e2b815eca72fa7a9f5561d7861:

  Linux 4.3 (2015-11-01 16:05:25 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.4-rc1

for you to fetch changes up to 2eb5f31bc4ea24bb293e82934cfa1cce9573304b:

  um: Switch clocksource to hrtimers (2015-11-06 22:54:49 +0100)

----------------------------------------------------------------
This pull request includes the following UML changes:
* A new hrtimer based clocksource by Anton Ivanov
* ptrace() enhancments by Richard Weinberger
* random cleanups and bug fixes all over the place

----------------------------------------------------------------
Anton Ivanov (1):
      um: Switch clocksource to hrtimers

Richard Weinberger (7):
      um: Define PTRACE_OLDSETOPTIONS
      um: Store syscall number after syscall_trace_enter()
      um: Get rid of open coded NR_SYSCALLS
      um: Remove dead code from x86_64 syscall stub
      um: Remove dead symbol from i386 syscall stub
      um: Simplify STUB_DATA loading
      um: Report host OOM more nicely

Saurabh Sengar (1):
      um: net: replace GFP_KERNEL with GFP_ATOMIC when spinlock is held

 arch/um/Makefile                        |   2 +-
 arch/um/drivers/net_kern.c              |  17 ++-
 arch/um/include/asm/ptrace-generic.h    |   2 +
 arch/um/include/shared/os.h             |  19 ++-
 arch/um/include/shared/skas/stub-data.h |   7 +-
 arch/um/include/shared/timer-internal.h |  13 ++
 arch/um/kernel/process.c                |   8 +-
 arch/um/kernel/skas/clone.c             |   6 +-
 arch/um/kernel/skas/mmu.c               |   3 +
 arch/um/kernel/skas/syscall.c           |  21 +--
 arch/um/kernel/time.c                   |  73 ++++++----
 arch/um/kernel/tlb.c                    |  16 +-
 arch/um/os-Linux/internal.h             |   1 -
 arch/um/os-Linux/main.c                 |   7 +-
 arch/um/os-Linux/process.c              |   6 +
 arch/um/os-Linux/signal.c               |  41 +++---
 arch/um/os-Linux/skas/process.c         |  55 +++----
 arch/um/os-Linux/time.c                 | 249 ++++++++++++++++----------------
 arch/x86/um/stub_32.S                   |   1 -
 arch/x86/um/stub_64.S                   |  18 +--
 20 files changed, 296 insertions(+), 269 deletions(-)
 create mode 100644 arch/um/include/shared/timer-internal.h
 delete mode 100644 arch/um/os-Linux/internal.h
