Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56255A75.4060200@nod.at>
Date: Mon, 19 Oct 2015 23:02:45 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: [GIT PULL] UML fixes for 4.3-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Linus,

the following changes since commit 7379047d5585187d1288486d4627873170d0005a:

  Linux 4.3-rc6 (2015-10-18 16:08:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.3-rc6

for you to fetch changes up to 56b88a3bf97a39d3f4f010509917b76a865a6dc8:

  um: Fix kernel mode fault condition (2015-10-19 22:53:37 +0200)

----------------------------------------------------------------
This pull request contains four overdue UML regression fixes

----------------------------------------------------------------
Hans-Werner Hilse (1):
      um: Do not rely on libc to provide modify_ldt()

Richard Weinberger (3):
      um: Fix out-of-tree build
      um: Fix waitpid() usage in helper code
      um: Fix kernel mode fault condition

 arch/um/Makefile          | 4 ++--
 arch/um/kernel/trap.c     | 2 +-
 arch/um/os-Linux/helper.c | 6 +++---
 arch/x86/um/ldt.c         | 5 ++++-
 4 files changed, 10 insertions(+), 7 deletions(-)
