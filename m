Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [GIT PULL] UML fixes for 4.5-rc7
Message-ID: <56DB5079.3010607@nod.at>
Date: Sat, 5 Mar 2016 22:32:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Linus,

The following changes since commit fc77dbd34c5c99bce46d40a2491937c3bcbd10af:

  Linux 4.5-rc6 (2016-02-28 08:41:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.5-rc7

for you to fetch changes up to ad32a1f3c36b046b2e7b0361b88c18e3af61419e:

  um: use %lx format specifiers for unsigned longs (2016-03-05 22:21:28 +0100)

----------------------------------------------------------------
This pull request contains three bug/build fixes.

----------------------------------------------------------------
Colin Ian King (1):
      um: use %lx format specifiers for unsigned longs

Richard Weinberger (2):
      Revert "um: Fix get_signal() usage"
      um: Export pm_power_off

 arch/um/kernel/reboot.c          | 1 +
 arch/um/kernel/signal.c          | 2 +-
 arch/x86/um/os-Linux/task_size.c | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

