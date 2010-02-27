Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 58/66] arch/um/os-Linux/sys-x86_64/prctl.c: Checkpatch cleanup
Date: Sat, 27 Feb 2010 17:51:39 +0100
Message-Id: <1267289508-31031-59-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

arch/um/os-Linux/sys-x86_64/prctl.c:11: ERROR: code indent should use tabs where possible

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/um/os-Linux/sys-x86_64/prctl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/os-Linux/sys-x86_64/prctl.c b/arch/um/os-Linux/sys-x86_64/prctl.c
index 9d34edd..79c278a 100644
--- a/arch/um/os-Linux/sys-x86_64/prctl.c
+++ b/arch/um/os-Linux/sys-x86_64/prctl.c
@@ -8,5 +8,5 @@
 
 int os_arch_prctl(int pid, int code, unsigned long *addr)
 {
-        return ptrace(PTRACE_ARCH_PRCTL, pid, (unsigned long) addr, code);
+	return ptrace(PTRACE_ARCH_PRCTL, pid, (unsigned long) addr, code);
 }
-- 
1.7.0.90.g251a4

