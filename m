Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Mon, 29 Aug 2011 18:13:30 +0200
Message-Id: <1314634419-24766-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: UML fixes for 3.1-rcX (2nd try)
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Sorry for sending this patch series again.
My mail server thought I'm a spammer. :-\

[PATCH 1/9] um: disable CMPXCHG_DOUBLE as it breaks UML build
[PATCH 2/9] um: drivers/xterm.c: fix a file descriptor leak
[PATCH 3/9] um: Save FPU registers between task switches
[PATCH 4/9] um: fix oopsable race in line_close()
[PATCH 5/9] um: winch_interrupt() can happen inside of free_winch()
[PATCH 6/9] um: fix free_winch() mess
[PATCH 7/9] um: PTRACE_[GS]ETFPXREGS had been wired on the wrong
[PATCH 8/9] um: fix strrchr problems
[PATCH 9/9] um: clean arch_ptrace() up a bit

 arch/um/Kconfig.x86                       |    4 ++
 arch/um/Makefile                          |    2 +-
 arch/um/drivers/line.c                    |   61 +++++++++++++++++------------
 arch/um/drivers/xterm.c                   |    1 +
 arch/um/include/asm/ptrace-generic.h      |    4 --
 arch/um/include/shared/line.h             |    1 +
 arch/um/include/shared/registers.h        |    2 +-
 arch/um/kernel/process.c                  |    2 +-
 arch/um/kernel/ptrace.c                   |   28 -------------
 arch/um/os-Linux/registers.c              |    9 ++++-
 arch/um/os-Linux/skas/mem.c               |    2 +-
 arch/um/os-Linux/skas/process.c           |   19 ++++++++-
 arch/um/sys-i386/asm/ptrace.h             |    5 --
 arch/um/sys-i386/ptrace.c                 |   28 +++++++++++--
 arch/um/sys-i386/shared/sysdep/ptrace.h   |    1 +
 arch/um/sys-x86_64/ptrace.c               |   12 ++++--
 arch/um/sys-x86_64/shared/sysdep/ptrace.h |    1 +
 17 files changed, 105 insertions(+), 77 deletions(-)
