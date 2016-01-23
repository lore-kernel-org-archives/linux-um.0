Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Colin King <colin.king@canonical.com>
Subject: [PATCH] um: use %lx format specifiers for unsigned longs
Date: Sat, 23 Jan 2016 19:17:59 +0000
Message-Id: <1453576679-10888-1-git-send-email-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Colin Ian King <colin.king@canonical.com>

static analysis from cppcheck detected %x being used for
unsigned longs:

[arch/x86/um/os-Linux/task_size.c:112]: (warning) %x in format
  string (no. 1) requires 'unsigned int' but the argument type
  is 'unsigned long'.

Use %lx instead of %x

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 arch/x86/um/os-Linux/task_size.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/os-Linux/task_size.c b/arch/x86/um/os-Linux/task_size.c
index 8502ad3..5adb6a2 100644
--- a/arch/x86/um/os-Linux/task_size.c
+++ b/arch/x86/um/os-Linux/task_size.c
@@ -109,7 +109,7 @@ unsigned long os_get_top_address(void)
 		exit(1);
 	}
 
-	printf("0x%x\n", bottom << UM_KERN_PAGE_SHIFT);
+	printf("0x%lx\n", bottom << UM_KERN_PAGE_SHIFT);
 	printf("Locating the top of the address space ... ");
 	fflush(stdout);
 
@@ -134,7 +134,7 @@ out:
 		exit(1);
 	}
 	top <<= UM_KERN_PAGE_SHIFT;
-	printf("0x%x\n", top);
+	printf("0x%lx\n", top);
 
 	return top;
 }
-- 
2.7.0.rc3


