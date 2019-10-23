Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iN8QC-0001hh-8k
 for linux-um@lists.infradead.org; Wed, 23 Oct 2019 04:38:57 +0000
Received: by mail-pf1-x442.google.com with SMTP id q21so12068063pfn.11
 for <linux-um@lists.infradead.org>; Tue, 22 Oct 2019 21:38:56 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 02/47] kbuild: allow architectures to automatically define
 kconfig symbols
Date: Wed, 23 Oct 2019 13:37:36 +0900
Message-Id: <c133f9df9611b72baedd882ca63590599e0a64d2.1571798507.git.thehajime@gmail.com>
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

This patch calls an architecture hook during the kernel config process
that allows the architecture to automatically define kconfig symbols.
This can be done by exporting environment variables from the
new architecture hook.

Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 0cbe8717bdb3..8c1f7422d0bc 100644
--- a/Makefile
+++ b/Makefile
@@ -605,6 +605,7 @@ endif
 export KBUILD_MODULES KBUILD_BUILTIN
 
 ifeq ($(dot-config),1)
+include arch/$(SRCARCH)/auto.conf
 include include/config/auto.conf
 endif
 
-- 
2.20.1 (Apple Git-117)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

