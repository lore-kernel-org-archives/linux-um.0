Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BYAuh-00043t-Jp for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jun 2004 14:47:15 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BYAuh-0007oZ-2D for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jun 2004 14:47:15 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QIvxAzC+9I4hplA"
Message-Id: <200406091318.40109.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] [PATCH] fixing dependency tracking for UML
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
Date: Wed, 9 Jun 2004 13:18:40 +0200
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>



--Boundary-00=_QIvxAzC+9I4hplA
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

You probably saw that if you change one config option, even if 
linux/autoconf.h (which is included by everything) changes, the kernel is 
smart enough not to recompile everything. But with UML this no more holds. 
Why? Because, as you see in this patch, fixdep avoids making anything depend 
onto linux/autoconf.h *explicitly*, but nobody taught him to do the same for 
arch/um/include/uml-config.h. So apply this patch. Do not say "I don't want 
to change the generic Kbuild for one arch": this cannot hurt. It's a bugfix 
for us, a no-op for others.

Note: with this patch, fixdep will still add a dependency from a file 
containing UML_CONFIG_BYE onto CONFIG_BYE. Since someone could think that 
fixdep should grep for [^A-Z_]CONFIG_ rather than simply for CONFIG_, I've 
added a comment that ask *not to fix* this "bug".

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729

--Boundary-00=_QIvxAzC+9I4hplA
Content-Type: text/x-diff; charset="us-ascii"; name="H-02-Fixdep-improve.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="H-02-Fixdep-improve.patch"

--- ./scripts/basic/fixdep.c.umlConfig	2003-12-20 17:56:21.000000000 +0100
+++ ./scripts/basic/fixdep.c	2004-01-06 16:22:24.000000000 +0100
@@ -310,6 +310,7 @@
 		}
 		memcpy(s, m, p-m); s[p-m] = 0;
 		if (strrcmp(s, "include/linux/autoconf.h") &&
+		    strrcmp(s, "arch/um/include/uml-config.h") &&
 		    strrcmp(s, ".ver")) {
 			printf("  %s \\\n", s);
 			do_config_file(s);

--Boundary-00=_QIvxAzC+9I4hplA
Content-Type: text/x-diff; charset="us-ascii"; name="AvoidFixdepChanges.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="AvoidFixdepChanges.patch"

--- scripts/basic/fixdep.c.comment	2004-04-10 12:39:10.000000000 +0200
+++ scripts/basic/fixdep.c	2004-06-09 13:07:08.000000000 +0200
@@ -93,6 +93,14 @@
  * (Note: it'd be easy to port over the complete mkdep state machine,
  *  but I don't think the added complexity is worth it)
  */
+/*  
+ * Note 2: if somebody writes HELLO_CONFIG_BOOM in a file, it will depend onto
+ * CONFIG_BOOM. This could seem a bug (not too hard to fix), but please do not
+ * fix it! Some UserModeLinux files (look at arch/um/) call CONFIG_BOOM as
+ * UML_CONFIG_BOOM, to avoid conflicts with /usr/include/linux/autoconf.h,
+ * through arch/um/include/uml-config.h; this fixdep "bug" makes sure that
+ * those files will have correct dependencies.
+ */
 
 #include <sys/types.h>
 #include <sys/stat.h>

--Boundary-00=_QIvxAzC+9I4hplA--



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
