Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Fri, 18 Dec 2015 21:28:53 +0100
Message-Id: <1450470533-13115-1-git-send-email-vegard.nossum@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] uml: flush stdout before forking
To: Richard Weinberger <richard@nod.at>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

I was seeing some really weird behaviour where piping UML's output
somewhere would cause output to get duplicated:

  $ ./vmlinux | head -n 40
  Checking that ptrace can change system call numbers...Core dump limits :
          soft - 0
          hard - NONE
  OK
  Checking syscall emulation patch for ptrace...Core dump limits :
          soft - 0
          hard - NONE
  OK
  Checking advanced syscall emulation patch for ptrace...Core dump limits :
          soft - 0
          hard - NONE
  OK
  Core dump limits :
          soft - 0
          hard - NONE

This is because these tests do a fork() which duplicates the non-empty
stdout buffer, then glibc flushes the duplicated buffer as each child
exits.

A simple workaround is to flush before forking.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 arch/um/os-Linux/start_up.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 47f1ff0..22a358e 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -94,6 +94,8 @@ static int start_ptraced_child(void)
 {
 	int pid, n, status;
 
+	fflush(stdout);
+
 	pid = fork();
 	if (pid == 0)
 		ptrace_child();
-- 
1.9.1

