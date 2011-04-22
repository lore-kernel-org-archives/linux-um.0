Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Fri, 22 Apr 2011 12:20:14 +0200
Message-Id: <1303467614-7585-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: Adjust current_thread_info() for newer gcc versions
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, kirill@shutemov.name, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

In some cases gcc >= 4.5.2 will optimize away current_thread_info().
To prevent gcc from doing so the stack address has to be obtained
via inline asm.

LKML-Reference: http://marc.info/?i=201104132150.05623.richard@nod.at

Acked-by: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/include/asm/thread_info.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index e2cf786..5bd1bad 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -49,7 +49,10 @@ static inline struct thread_info *current_thread_info(void)
 {
 	struct thread_info *ti;
 	unsigned long mask = THREAD_SIZE - 1;
-	ti = (struct thread_info *) (((unsigned long) &ti) & ~mask);
+	void *p;
+
+	asm volatile ("" : "=r" (p) : "0" (&ti));
+	ti = (struct thread_info *) (((unsigned long)p) & ~mask);
 	return ti;
 }
 
-- 
1.7.4.2

