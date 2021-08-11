Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDpgi-007UqC-A3
 for linux-um@lists.infradead.org; Wed, 11 Aug 2021 14:58:40 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 2/2] um: enable VMAP_STACK
Date: Wed, 11 Aug 2021 16:58:26 +0200
Message-Id: <20210811165826.7ad9ac13f6a7.I85ae4b0df1f69aa2d2012c8daa1d015c4fd258fc@changeid>
In-Reply-To: <20210811165826.f814c3ae4fca.I33fd41809c2c0413f19e292a26c0c0dff4b3d301@changeid>
References: <20210811165826.f814c3ae4fca.I33fd41809c2c0413f19e292a26c0c0dff4b3d301@changeid>
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
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

This works just fine, so select HAVE_ARCH_VMAP_STACK to
let users enable VMAP_STACK if desired.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 0561b73cfd9a..389c9f5bcb2b 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -21,6 +21,7 @@ config UML
 	select HAVE_GCC_PLUGINS
 	select SET_FS
 	select TTY # Needed for line.c
+	select HAVE_ARCH_VMAP_STACK
 
 config MMU
 	bool
-- 
2.31.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

