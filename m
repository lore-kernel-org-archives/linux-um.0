Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZCuQ-0004YQ-7R
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 24 Dec 2003 09:34:58 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AZCuM-00052v-N8
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 24 Dec 2003 09:34:54 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Dfa6/pAmb3enlxS"
Message-Id: <200312241550.43945.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] [PATCH] Missing symbols for 2.4.23-1um
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 24 Dec 2003 15:50:43 +0100
To: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_Dfa6/pAmb3enlxS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I think I already posted this, but it isn't applied on 2.4.23-1, so I'll keep 
posting like on main LKML; os_ioctl_generic is for hostaudio, strlen and 
printf probably for hostfs.

Bye
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN

--Boundary-00=_Dfa6/pAmb3enlxS
Content-Type: text/x-diff;
  charset="us-ascii";
  name="export_symbols.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="export_symbols.patch"

--- ./arch/um/kernel/ksyms.c.symbols	2003-11-13 16:30:12.000000000 +0100
+++ ./arch/um/kernel/ksyms.c	2003-11-16 12:43:05.000000000 +0100
@@ -68,6 +68,7 @@
 EXPORT_SYMBOL(os_create_unix_socket);
 EXPORT_SYMBOL(os_connect_socket);
 EXPORT_SYMBOL(os_accept_connection);
+EXPORT_SYMBOL(os_ioctl_generic);
 EXPORT_SYMBOL(os_rcv_fd);
 EXPORT_SYMBOL(run_helper);
 EXPORT_SYMBOL(start_thread);
--- ./arch/um/kernel/user_syms.c.symbols	2003-11-13 16:30:13.000000000 +0100
+++ ./arch/um/kernel/user_syms.c	2003-11-16 12:42:08.000000000 +0100
@@ -112,5 +112,7 @@
 
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(strstr);
+EXPORT_SYMBOL(strlen);
+EXPORT_SYMBOL(printf);
 
 EXPORT_SYMBOL(find_iomem);

--Boundary-00=_Dfa6/pAmb3enlxS--




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
