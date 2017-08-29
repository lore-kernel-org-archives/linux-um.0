Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [GIT PULL] UML fixes for 4.13-rc7
Date: Tue, 29 Aug 2017 22:33:06 +0200
Message-ID: <4491426.GmGx9Nx3l8@blindfold>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Linus,

The following changes since commit 14ccee78fc82f5512908f4424f541549a5705b89:

  Linux 4.13-rc6 (2017-08-20 14:13:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.13-rc7

for you to fetch changes up to 2fb44600fe784449404c6639de26af8361999ec7:

  um: Fix check for _xstate for older hosts (2017-08-24 21:52:28 +0200)

----------------------------------------------------------------
This pull request contains a single fix for a regression which
was introduced while the merge window.

----------------------------------------------------------------

Florian Fainelli (1):
      um: Fix check for _xstate for older hosts

 arch/x86/um/user-offsets.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


