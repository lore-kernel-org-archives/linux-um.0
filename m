Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuIce-00FeVJ-7E
	for linux-um@lists.infradead.org; Thu, 26 May 2022 18:54:14 +0000
Received: by mail-pl1-x649.google.com with SMTP id j13-20020a170902da8d00b00161d78a9e3eso1505557plx.17
        for <linux-um@lists.infradead.org>; Thu, 26 May 2022 11:54:10 -0700 (PDT)
Date: Thu, 26 May 2022 11:54:02 -0700
Message-Id: <20220526185402.955870-1-davidgow@google.com>
Mime-Version: 1.0
Subject: [PATCH] arch: um: Fix build for statically linked UML w/ constructors
From: David Gow <davidgow@google.com>
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
To: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: David Gow <davidgow@google.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org

If CONFIG_CONSTUCTORS is enabled on a statically linked
(CONFIG_STATIC_LINK=y) build of UML, the build fails due to the
.eh_frame section being both used and discarded:

ERROR:root:`.eh_frame' referenced in section `.text' of /usr/lib/gcc/x86_64-linux-gnu/11/crtbeginT.o: defined in discarded section `.eh_frame' of /usr/lib/gcc/x86_64-linux-gnu/11/crtbeginT.o
`.eh_frame' referenced in section `.text' of /usr/lib/gcc/x86_64-linux-gnu/11/crtbeginT.o: defined in discarded section `.eh_frame' of /usr/lib/gcc/x86_64-linux-gnu/11/crtbeginT.o

Instead, keep the .eh_frame section, as we do in dyn.lds.S for
dynamically linked UML.

This can be reproduced with:
./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_STATIC_LINK=y --kconfig_add CONFIG_GCOV_KERNEL=y --kconfig_add CONFIG_DEBUG_FS=y

Signed-off-by: David Gow <davidgow@google.com>
---
 arch/um/kernel/uml.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
index 7a8e2b123e29..71a59b8adbdc 100644
--- a/arch/um/kernel/uml.lds.S
+++ b/arch/um/kernel/uml.lds.S
@@ -95,6 +95,7 @@ SECTIONS
   }
 
   .got           : { *(.got.plt) *(.got) }
+  .eh_frame       : { KEEP (*(.eh_frame)) }
   .dynamic       : { *(.dynamic) }
   .tdata	  : { *(.tdata .tdata.* .gnu.linkonce.td.*) }
   .tbss		  : { *(.tbss .tbss.* .gnu.linkonce.tb.*) *(.tcommon) }
-- 
2.36.1.124.g0e6072fb45-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

