Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [GIT PULL] UML updates for 4.13-rc1
Message-ID: <8e7e782b-c155-63b0-072d-56a010b55adb@nod.at>
Date: Sat, 15 Jul 2017 15:54:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Linus,

The following changes since commit 32c1431eea4881a6b17bd7c639315010aeefa452:

  Linux 4.12-rc5 (2017-06-11 16:48:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.13-rc1

for you to fetch changes up to 61e8d462457f202bf0c6393133425ad387825e22:

  um: Correctly check for PTRACE_GETRESET/SETREGSET (2017-07-10 22:58:06 +0200)

----------------------------------------------------------------
This pull request contains mostly fixes for UML:
- First round of fixes for PTRACE_GETRESET/SETREGSET
- A printf vs. printk cleanup
- Minor improvements

----------------------------------------------------------------
Florian Fainelli (2):
      um: Avoid longjmp/setjmp symbol clashes with libpthread.a
      um: Allow building and running on older hosts

Logan Gunthorpe (1):
      um: add dummy ioremap and iounmap functions

Masami Hiramatsu (6):
      um: Use printk instead of printf in make_uml_dir
      um: Add os_info() for pre-boot information messages
      um: Use os_info for the messages on normal path
      um: Add os_warn() for pre-boot warning/error messages
      um: Use os_warn to print out pre-boot warning/error messages
      um: console: Ignore console= option

Richard Weinberger (1):
      um: Correctly check for PTRACE_GETRESET/SETREGSET

Thomas Meyer (5):
      um: userspace - be more verbose in ptrace set regs error
      um: stub-data.h: remove superfluous include
      um: Add kerneldoc for segv_handler
      um: Add kerneldoc for userspace_tramp() and start_userspace()
      um: v2: Use generic NOTES macro

 arch/um/Makefile                        |  4 ++++
 arch/um/drivers/stdio_console.c         |  3 +++
 arch/um/include/asm/common.lds.S        |  2 +-
 arch/um/include/asm/io.h                | 17 ++++++++++++++
 arch/um/include/shared/os.h             |  4 ++++
 arch/um/include/shared/skas/stub-data.h |  2 --
 arch/um/kernel/physmem.c                | 10 ++++----
 arch/um/kernel/trap.c                   | 10 ++++++++
 arch/um/kernel/um_arch.c                | 16 +++++++------
 arch/um/kernel/umid.c                   |  4 ++--
 arch/um/os-Linux/execvp.c               |  2 +-
 arch/um/os-Linux/main.c                 |  9 ++++----
 arch/um/os-Linux/mem.c                  | 28 +++++++++++-----------
 arch/um/os-Linux/skas/process.c         | 41 ++++++++++++++++++++++++++++++---
 arch/um/os-Linux/start_up.c             | 28 +++++++++++-----------
 arch/um/os-Linux/umid.c                 | 19 ++++++++-------
 arch/um/os-Linux/util.c                 | 34 +++++++++++++++++++++++++++
 arch/x86/um/os-Linux/registers.c        | 12 ++++++----
 arch/x86/um/setjmp_32.S                 | 16 ++++++-------
 arch/x86/um/setjmp_64.S                 | 16 ++++++-------
 arch/x86/um/user-offsets.c              |  6 ++++-
 21 files changed, 201 insertions(+), 82 deletions(-)
 create mode 100644 arch/um/include/asm/io.h

