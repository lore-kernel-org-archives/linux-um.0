Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mV9mE-006f32-PJ
 for linux-um@lists.infradead.org; Tue, 28 Sep 2021 09:51:56 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] uml: x86: add FORCE to user_constants.h
Date: Tue, 28 Sep 2021 11:51:46 +0200
Message-Id: <20210928115146.277bec2328bb.If70926505d16d6c6a229002eb6d3f6838b546175@changeid>
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

The build system has started warning when filechk is called
without FORCE:

arch/x86/um/Makefile:44: FORCE prerequisite is missing

Add FORCE to make sure the file is checked/rebuilt when
necessary (and to quiet up the warning.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/x86/um/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 5ccb18290d71..ba5789c35809 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -40,7 +40,7 @@ $(obj)/user-offsets.s: c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) \
 	-Iarch/x86/include/generated
 targets += user-offsets.s
 
-include/generated/user_constants.h: $(obj)/user-offsets.s
+include/generated/user_constants.h: $(obj)/user-offsets.s FORCE
 	$(call filechk,offsets,__USER_CONSTANT_H__)
 
 UNPROFILE_OBJS := stub_segv.o
-- 
2.31.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

