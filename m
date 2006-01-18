Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzNDG-0000yO-1f for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 15:59:38 -0800
Received: from [151.97.230.9] (helo=ssc.unict.it)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EzNDF-0002Yl-EA
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 15:59:38 -0800
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Message-Id: <20060118235514.4626.78783.stgit@zion.home.lan>
In-Reply-To: <20060118235132.4626.74049.stgit@zion.home.lan>
References: <20060118235132.4626.74049.stgit@zion.home.lan>
Subject: [uml-devel] [PATCH 6/8] uml: skas0-hold-own-ldt fixups for x86-64
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 19 Jan 2006 00:55:15 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net


In a recent fixup i386 code was copied raw to x86_64 subarch to make it compile
again.

Here there are some little fixups and resyncs needed for it (mainly for
cleanliness sake) - I did an audit and found the rest of the code to be safe.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/asm-um/ldt-x86_64.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/asm-um/ldt-x86_64.h b/include/asm-um/ldt-x86_64.h
index 57159f1..96b35aa 100644
--- a/include/asm-um/ldt-x86_64.h
+++ b/include/asm-um/ldt-x86_64.h
@@ -39,11 +39,13 @@ typedef struct uml_ldt {
 } uml_ldt_t;
 
 /*
- * macros stolen from include/asm-i386/desc.h
+ * macros stolen from include/asm-x86_64/desc.h
  */
 #define LDT_entry_a(info) \
 	((((info)->base_addr & 0x0000ffff) << 16) | ((info)->limit & 0x0ffff))
 
+/* Don't allow setting of the lm bit. It is useless anyways because
+ * 64bit system calls require __USER_CS. */
 #define LDT_entry_b(info) \
 	(((info)->base_addr & 0xff000000) | \
 	(((info)->base_addr & 0x00ff0000) >> 16) | \
@@ -54,6 +56,7 @@ typedef struct uml_ldt {
 	((info)->seg_32bit << 22) | \
 	((info)->limit_in_pages << 23) | \
 	((info)->useable << 20) | \
+	/* ((info)->lm << 21) | */ \
 	0x7000)
 
 #define LDT_empty(info) (\
@@ -64,6 +67,7 @@ typedef struct uml_ldt {
 	(info)->seg_32bit	== 0	&& \
 	(info)->limit_in_pages	== 0	&& \
 	(info)->seg_not_present	== 1	&& \
-	(info)->useable		== 0	)
+	(info)->useable		== 0	&& \
+	(info)->lm              == 0)
 
 #endif



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
