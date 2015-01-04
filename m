Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <54A96470.1000208@nod.at>
Date: Sun, 04 Jan 2015 17:04:00 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: [GIT PULL] UML fixes for v3.19-rc3
To: Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Linus,

The following changes since commit d753856c9f9ae33a980192aa7b81d8b97d79dec2:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2015-01-02 13:24:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus

for you to fetch changes up to b485342bd79af363c77ef1a421c4a0aef2de9812:

  x86, um: actually mark system call tables readonly (2015-01-04 14:21:25 +0100)

----------------------------------------------------------------
Two fixes for UML regressions. Nothing exciting.
----------------------------------------------------------------
Daniel Borkmann (1):
      x86, um: actually mark system call tables readonly

Richard Weinberger (1):
      um: Skip futex_atomic_cmpxchg_inatomic() test

 arch/um/Kconfig.common          | 1 +
 arch/x86/um/sys_call_table_32.c | 2 +-
 arch/x86/um/sys_call_table_64.c | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

Thanks,
//richard
