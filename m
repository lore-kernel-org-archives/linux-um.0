Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from zeniv-ca.linux.org.uk ([2607:5300:60:148a::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSQrH-003B6U-Tl
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:29:53 +0000
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mSQrD-005yZB-RO
 for linux-um@lists.infradead.org; Mon, 20 Sep 2021 21:29:47 +0000
Date: Mon, 20 Sep 2021 21:29:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCHES] uml cleanups and (minor) fixes
Message-ID: <YUj9S+S4Gd86mM6N@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org

	A bunch of assorted um patches - most of that is trimming
an ancient unused crap (declarations with no definitions, unused
macros, etc.), with a couple of fixes - missing include in barrier.h
and misannotations of iounmap().

	The stuff is based at 5.15-rc1 and it can be found in
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.um

	Individual patches in followups.

Diffstat:

 arch/um/include/asm/processor-generic.h |  2 +-
 arch/um/include/shared/common-offsets.h | 15 ---------------
 arch/um/include/shared/irq_user.h       |  1 -
 arch/um/include/shared/kern_util.h      |  2 --
 arch/um/include/shared/mem_user.h       |  5 -----
 arch/um/include/shared/net_kern.h       |  2 --
 arch/um/include/shared/net_user.h       |  1 -
 arch/um/include/shared/os.h             | 13 -------------
 arch/um/include/shared/registers.h      |  2 --
 arch/um/include/shared/sigio.h          |  1 -
 arch/um/kernel/Makefile                 |  2 +-
 arch/um/kernel/exec.c                   |  1 +
 arch/um/kernel/process.c                |  6 +-----
 arch/um/kernel/syscall.c                | 28 ----------------------------
 arch/um/kernel/trap.c                   |  1 -
 arch/x86/kernel/asm-offsets.c           |  3 ---
 arch/x86/um/asm/barrier.h               |  1 +
 arch/x86/um/os-Linux/registers.c        |  1 +
 arch/x86/um/ptrace_32.c                 |  1 +
 arch/x86/um/ptrace_64.c                 |  1 +
 arch/x86/um/shared/sysdep/syscalls_64.h |  3 ---
 arch/x86/um/signal.c                    |  1 +
 arch/x86/um/sys_call_table_32.c         |  4 ----
 arch/x86/um/sys_call_table_64.c         | 17 -----------------
 arch/x86/um/syscalls_64.c               | 11 +++++++++++
 include/asm-generic/logic_io.h          |  2 +-
 lib/logic_iomem.c                       |  4 ++--
 27 files changed, 23 insertions(+), 108 deletions(-)
 delete mode 100644 arch/um/kernel/syscall.c

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

