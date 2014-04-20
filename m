Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <53543B76.2080405@nod.at>
Date: Sun, 20 Apr 2014 23:26:14 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: [GIT PULL] UML fixes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Tristan Schmelcher <tschmelcher@google.com>, "Anton Ivanov (antivano)" <antivano@cisco.com>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Linus,

The following changes since commit a798c10faf62a505d24e5f6213fbaf904a39623f:

  Linux 3.15-rc2 (2014-04-20 11:08:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus

for you to fetch changes up to a8c60be4f1bb3a4eead20e3fa19ce645f818014a:

  um: Memory corruption on startup (2014-04-20 23:13:36 +0200)

----------------------------------------------------------------
Assorted fixes for UML.
----------------------------------------------------------------
Anton Ivanov (2):
      um: Missing pipe handling
      um: Memory corruption on startup

Tristan Schmelcher (1):
      uml: Simplify tempdir logic.

 arch/um/include/shared/os.h |   1 +
 arch/um/kernel/physmem.c    |   1 +
 arch/um/os-Linux/file.c     |   6 +
 arch/um/os-Linux/main.c     |   1 +
 arch/um/os-Linux/mem.c      | 372 +++++++++-----------------------------------
 5 files changed, 84 insertions(+), 297 deletions(-)

Thanks,
//richard
