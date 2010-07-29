Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 29 Jul 2010 17:28:52 +0200
From: Christoph Egger <siccegge@cs.fau.de>
Subject: [PATCH 1/3] Removing dead PROC_MM
Message-ID: <05c3e16545a12d02d1f09d1fd90efdb88385f631.1280417117.git.siccegge@cs.fau.de>
References: <cover.1280417117.git.siccegge@cs.fau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1280417117.git.siccegge@cs.fau.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: vamos-dev@i4.informatik.uni-erlangen.de
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

PROC_MM doesn't exist in Kconfig. Looking around it looks like a
left-over from 2.6.0 or even 2.4 times, last mentioned in a fedora
patch for 2.6.10. I believe it's time to get rid of that last tiny
parts here that are still around.

Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
---
 arch/um/kernel/ptrace.c |   21 ---------------------
 1 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 4845099..e051049 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -7,9 +7,6 @@
 #include "linux/ptrace.h"
 #include "linux/sched.h"
 #include "asm/uaccess.h"
-#ifdef CONFIG_PROC_MM
-#include "proc_mm.h"
-#endif
 #include "skas_ptrace.h"
 
 
@@ -158,24 +155,6 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 		break;
 	}
 #endif
-#ifdef CONFIG_PROC_MM
-	case PTRACE_SWITCH_MM: {
-		struct mm_struct *old = child->mm;
-		struct mm_struct *new = proc_mm_get_mm(data);
-
-		if (IS_ERR(new)) {
-			ret = PTR_ERR(new);
-			break;
-		}
-
-		atomic_inc(&new->mm_users);
-		child->mm = new;
-		child->active_mm = new;
-		mmput(old);
-		ret = 0;
-		break;
-	}
-#endif
 #ifdef PTRACE_ARCH_PRCTL
 	case PTRACE_ARCH_PRCTL:
 		/* XXX Calls ptrace on the host - needs some SMP thinking */
-- 
1.7.0.4

