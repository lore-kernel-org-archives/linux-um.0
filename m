Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <elicooper@gmx.com>) id 1acZng-00069n-Ny
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Mar 2016 14:36:52 +0000
Received: from mout.gmx.net ([212.227.15.19])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1acZnf-00061e-SL for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 06 Mar 2016 14:36:52 +0000
From: Eli Cooper <elicooper@gmx.com>
Date: Sun,  6 Mar 2016 22:36:24 +0800
Message-Id: <1457274987-20078-1-git-send-email-elicooper@gmx.com>
Subject: [uml-devel] [PATCH 0/3] um: Add support for extended processor state
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>

This series adds support for the extended processor state (XSTATE) for
x86_64 UML, especially the YMM registers used by AVX/AVX2 instructions.

Modern userspace programs built with AVX can now run inside x86_64 UML
without YMM registers getting corrupted.

Eli Cooper (3):
  um: extend _fpstate to _xstate
  um: add extended processor state save/restore support
  um: fix ptrace PTRACE_GETFPREGS and PTRACE_SETFPREG support

 arch/um/include/shared/registers.h    |  2 ++
 arch/um/kernel/process.c              |  2 +-
 arch/x86/um/os-Linux/registers.c      | 49 +++++++++++++++++++++++++++++++++--
 arch/x86/um/ptrace_32.c               |  4 +--
 arch/x86/um/ptrace_64.c               | 14 +++++-----
 arch/x86/um/shared/sysdep/ptrace_64.h |  4 +--
 arch/x86/um/signal.c                  | 26 +++++++++----------
 arch/x86/um/user-offsets.c            |  2 +-
 8 files changed, 73 insertions(+), 30 deletions(-)

-- 
2.7.2


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

