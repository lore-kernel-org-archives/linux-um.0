Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iN8QC-0001he-4m
 for linux-um@lists.infradead.org; Wed, 23 Oct 2019 04:38:57 +0000
Received: by mail-pl1-x644.google.com with SMTP id d22so9450208pll.7
 for <linux-um@lists.infradead.org>; Tue, 22 Oct 2019 21:38:55 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 01/47] asm-generic: atomic64: allow using generic atomic64
 on 64bit platforms
Date: Wed, 23 Oct 2019 13:37:35 +0900
Message-Id: <29a86a6d6018891f9dc90fefa864cd19fbc10b74.1571798507.git.thehajime@gmail.com>
In-Reply-To: <cover.1571798507.git.thehajime@gmail.com>
References: <cover.1571798507.git.thehajime@gmail.com>
MIME-Version: 1.0
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
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>

From: Octavian Purdila <tavi.purdila@gmail.com>

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 include/asm-generic/atomic64.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
index 370f01d4450f..9b15847baae5 100644
--- a/include/asm-generic/atomic64.h
+++ b/include/asm-generic/atomic64.h
@@ -9,9 +9,11 @@
 #define _ASM_GENERIC_ATOMIC64_H
 #include <linux/types.h>
 
+#ifndef CONFIG_64BIT
 typedef struct {
 	s64 counter;
 } atomic64_t;
+#endif
 
 #define ATOMIC64_INIT(i)	{ (i) }
 
-- 
2.20.1 (Apple Git-117)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

