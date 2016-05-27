Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [GIT PULL] UML updates for v4.7-rc1
Message-ID: <57489CF4.9030801@nod.at>
Date: Fri, 27 May 2016 21:16:04 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Linus,

The following changes since commit 44549e8f5eea4e0a41b487b63e616cb089922b99:

  Linux 4.6-rc7 (2016-05-08 14:38:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.7-rc1

for you to fetch changes up to a78ff1112263fdd871d3506dbcff44f6f12e8423:

  um: add extended processor state save/restore support (2016-05-21 23:38:06 +0200)

----------------------------------------------------------------
This pull request contains a nice FPU fixup from Eli Cooper for
UML.

----------------------------------------------------------------
Eli Cooper (3):
      um: fix FPU state preservation around signal handlers
      um: extend fpstate to _xstate to support YMM registers
      um: add extended processor state save/restore support

 arch/um/include/shared/registers.h    |  2 ++
 arch/um/kernel/process.c              |  2 +-
 arch/um/os-Linux/signal.c             | 28 ++++++++++++++------
 arch/x86/um/os-Linux/registers.c      | 49 +++++++++++++++++++++++++++++++++--
 arch/x86/um/ptrace_32.c               |  5 ++--
 arch/x86/um/ptrace_64.c               | 16 ++++++------
 arch/x86/um/shared/sysdep/ptrace_64.h |  4 +--
 arch/x86/um/signal.c                  | 37 +++++++++-----------------
 arch/x86/um/user-offsets.c            |  2 +-
 9 files changed, 95 insertions(+), 50 deletions(-)

