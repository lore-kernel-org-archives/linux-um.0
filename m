Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <51E90E00.4030305@nod.at>
Date: Fri, 19 Jul 2013 11:59:28 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PULL] UML fixes for 3.11-rc2
To: torvalds@linux-foundation.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Linus,

please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus

Special thanks goes to Toralf F=F6ster for continuously testing UML and=
 reporting issues!

Thanks,
//richard

----------------------------------------------------------------
Richard Weinberger (5):
      um: Fix return value of strnlen_user()
      um: Mark stub pages mapping with VM_PFNMAP
      um: Fix wait_stub_done() error handling
      um: siginfo cleanup
      um: remove dead code

Tristan Schmelcher (1):
      uml: Fix which_tmpdir failure when /dev/shm is a symlink, and in =
other edge cases

 arch/um/include/shared/frame_kern.h |   8 +-
 arch/um/kernel/signal.c             |   4 +-
 arch/um/kernel/skas/mmu.c           |   2 +-
 arch/um/kernel/skas/uaccess.c       |   2 +-
 arch/um/os-Linux/mem.c              | 230 ++++++++++++++++++++++++++++=
+-------
 arch/um/os-Linux/signal.c           |   8 +-
 arch/um/os-Linux/skas/process.c     |  19 +--
 arch/x86/um/signal.c                |   1 -
 8 files changed, 213 insertions(+), 61 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

