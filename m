Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbiqD-0002wr-St for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Jun 2004 09:37:17 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BbiqD-0004n7-BY for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Jun 2004 09:37:17 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vbF1AGbCIZAbqqI"
Message-Id: <200406191708.31918.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] [PATCH] [2.4.26] Symbols fix
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
Date: Sat, 19 Jun 2004 17:08:31 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_vbF1AGbCIZAbqqI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Please apply this to fix a "XXX" about some symbols to export in user_syms.c.
This makes the file similar to the 2.6 one, so I don't think that those 
symbols will "strangely clash with headers".

However I'm compiling it right now, to test it anyway.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_vbF1AGbCIZAbqqI
Content-Type: text/x-diff; charset="us-ascii"; name="2.4-Symbols-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.4-Symbols-fix.patch"

--- arch/um/kernel/user_syms.c.fix	2004-06-19 16:51:14.000000000 +0200
+++ arch/um/kernel/user_syms.c	2004-06-19 16:59:34.000000000 +0200
@@ -1,11 +1,6 @@
 #include "linux/types.h"
 #include "linux/module.h"
 
-/* XXX Deleted a number of symbols because they clashed strangely with headers
- * Add them back later.
- */
-
-#if 0
 /* Some of this are builtin function (some are not but could in the future),
  * so I *must* declare good prototypes for them and then EXPORT them.
  * The kernel code uses the macro defined by include/linux/string.h,
@@ -15,20 +10,20 @@
 #undef strlen
 #undef memcpy
 #undef memset
-
-EXPORT_SYMBOL_PROTO(strlen);
-EXPORT_SYMBOL_PROTO(memset);
-EXPORT_SYMBOL_PROTO(memcpy);
 #undef strstr
 
-EXPORT_SYMBOL_PROTO(strstr);
-
 extern size_t strlen(const char *);
 extern void *memcpy(void *, const void *, size_t);
 extern void *memset(void *, int, size_t);
 extern int printf(const char *, ...);
+extern char *strstr(const char *, const char *);
+
+EXPORT_SYMBOL(strlen);
+EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(strstr);
+EXPORT_SYMBOL(printf);
 
-#endif
 
 /* Here, instead, I can provide a fake prototype. Yes, someone cares: genksyms.
  * However, the modules will use the CRC defined *here*, no matter if it is 
@@ -81,5 +76,3 @@
 EXPORT_SYMBOL_PROTO(statfs64);
 
 EXPORT_SYMBOL_PROTO(getuid);
-
-EXPORT_SYMBOL_PROTO(printf);

--Boundary-00=_vbF1AGbCIZAbqqI--




-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
