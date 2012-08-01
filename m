Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5019B93E.4080006@nod.at>
Date: Thu, 02 Aug 2012 01:18:22 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: [GIT PULL] UML fixes for 3.6-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, toralf.foerster@gmx.de
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Linus,

The following changes since commit 28a33cbc24e4256c143dce96c7d93bf42322=
9f92:

   Linux 3.5 (2012-07-21 13:58:29 -0700)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-3=
=2E6-rc1

---
This patch set contains mostly fixes and cleanups.
The UML tty driver uses now tty_port and is no longer broken
like hell. :-)
---

Al Viro (3):
       um: switch UPT_SET_RETURN_VALUE and regs_return_value to pt_regs
       um: split syscall_trace(), pass pt_regs to it
       um: pull interrupt_end() into userspace()

Jiri Slaby (2):
       TTY: um/line, add tty_port
       TTY: um/line, use tty from tty_port

Martin P=E4rtel (2):
       um: fix ubd_file_size for read-only files
       um: pass siginfo to guest process

Richard Weinberger (6):
       um: remove line_ioctl()
       um: Remove dead code
       um: fully use tty_port
       um: remove count_lock
       um: set BLK_CGROUP=3Dy in defconfig
       um: Add arch/x86/um to MAINTAINERS

  MAINTAINERS                          |    1 +
  arch/um/defconfig                    |    2 +-
  arch/um/drivers/chan_kern.c          |    4 +-
  arch/um/drivers/line.c               |  218 ++++++++++---------------=
---------
  arch/um/drivers/line.h               |   12 +-
  arch/um/drivers/ssl.c                |   42 +------
  arch/um/drivers/stdio_console.c      |   21 ++--
  arch/um/drivers/ubd_kern.c           |    2 +-
  arch/um/include/asm/ptrace-generic.h |    2 +
  arch/um/include/shared/as-layout.h   |    3 +-
  arch/um/include/shared/irq_user.h    |    3 +-
  arch/um/include/shared/kern_util.h   |   13 +-
  arch/um/kernel/irq.c                 |    2 +-
  arch/um/kernel/process.c             |   13 +--
  arch/um/kernel/ptrace.c              |   71 +++++-------
  arch/um/kernel/skas/syscall.c        |    6 +-
  arch/um/kernel/time.c                |    2 +-
  arch/um/kernel/trap.c                |   39 +++++-
  arch/um/os-Linux/internal.h          |    2 +-
  arch/um/os-Linux/signal.c            |   26 +++--
  arch/um/os-Linux/skas/process.c      |   16 ++-
  arch/um/os-Linux/time.c              |    2 +-
  arch/x86/um/asm/ptrace.h             |    6 +-
  23 files changed, 206 insertions(+), 302 deletions(-)

Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

