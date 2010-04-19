Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH 0/5] uml: Some trivial cleanups
Date: Mon, 19 Apr 2010 23:53:03 +0200
Message-Id: <cover.1271713955.git.jan.kiszka@web.de>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Some trivial build warning fixes and cleanups for UML.

Jan Kiszka (5):
  uml: Remove unused variable from line driver
  uml: Drop private round_down definition
  uml: Fix warning due to missing task_struct declaration
  uml: i386: Avoid redefinition of NR_syscalls
  uml: Clean up asm/system.h

 arch/um/drivers/line.c        |    1 -
 arch/um/include/asm/system.h  |    3 ---
 arch/um/kernel/skas/syscall.c |    4 ++--
 arch/um/sys-i386/asm/elf.h    |    2 ++
 arch/um/sys-x86_64/asm/elf.h  |    2 ++
 arch/um/sys-x86_64/signal.c   |    2 --
 6 files changed, 6 insertions(+), 8 deletions(-)

