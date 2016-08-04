Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [GIT PULL] UML updates for v4.8-rc1
Message-ID: <57A39D1A.9030708@nod.at>
Date: Thu, 4 Aug 2016 21:52:58 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Linus,

The following changes since commit 523d939ef98fd712632d93a5a2b588e477a7565e:

  Linux 4.7 (2016-07-24 12:23:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.8-rc1

for you to fetch changes up to 8a545f185145e3c09348cd74326268ecfc6715a3:

  hostfs: Freeing an ERR_PTR in hostfs_fill_sb_common() (2016-08-04 00:18:10 +0200)

----------------------------------------------------------------
Beside of various fixes this pull request contains also patches
to have features such was Kcov, kmemleak and
TRACE_IRQFLAGS_SUPPORT on UML.

----------------------------------------------------------------

Amitoj Kaur Chawla (1):
      um: Eliminate null test after alloc_bootmem

Dan Carpenter (1):
      hostfs: Freeing an ERR_PTR in hostfs_fill_sb_common()

Daniel Wagner (1):
      um: Use asm-generic/irqflags.h

Richard Weinberger (4):
      um: Setup physical memory in setup_arch()
      um: Select HAVE_DEBUG_KMEMLEAK
      um: Fix possible deadlock in sig_handler_common()
      um: Enable TRACE_IRQFLAGS_SUPPORT

Vegard Nossum (1):
      um: Support kcov

 arch/um/Kconfig.common         |  5 +++--
 arch/um/include/asm/irqflags.h | 18 +++++++-----------
 arch/um/kernel/Makefile        |  5 +++++
 arch/um/kernel/initrd.c        |  2 --
 arch/um/kernel/um_arch.c       |  8 ++++----
 arch/um/os-Linux/Makefile      |  3 +++
 arch/um/os-Linux/signal.c      |  5 +++--
 arch/x86/um/vdso/Makefile      |  3 +++
 fs/hostfs/hostfs_kern.c        |  7 ++++---
 9 files changed, 32 insertions(+), 24 deletions(-)

