Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 60/66] arch/um/sys-i386/shared/sysdep/vm-flags.h: Checkpatch cleanup
Date: Sat, 27 Feb 2010 17:51:41 +0100
Message-Id: <1267289508-31031-61-git-send-email-andrea.gelmini@gelma.net>
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

arch/um/sys-i386/shared/sysdep/vm-flags.h:11: ERROR: space prohibited before that close parenthesis ')'

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/um/sys-i386/shared/sysdep/vm-flags.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/um/sys-i386/shared/sysdep/vm-flags.h b/arch/um/sys-i386/shared/sysdep/vm-flags.h
index e0d24c5..881afd7 100644
--- a/arch/um/sys-i386/shared/sysdep/vm-flags.h
+++ b/arch/um/sys-i386/shared/sysdep/vm-flags.h
@@ -8,7 +8,7 @@
 
 #define VM_DATA_DEFAULT_FLAGS \
 	(VM_READ | VM_WRITE | \
-	((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0 ) | \
+	((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0) | \
 		 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
 
 #endif
-- 
1.7.0.90.g251a4

