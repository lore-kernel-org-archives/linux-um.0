Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BmGVi-00036g-Pm for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 11:35:42 -0700
Received: from smtp.wp.pl ([212.77.101.160])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.34) id 1BmGVi-00008i-CJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jul 2004 11:35:42 -0700
Received: from lodz106.vline.pl (HELO 172.16.13.24) (sikkh@[212.191.130.106])
	(envelope-sender <sikkh@wp.pl>) by smtp.wp.pl (WP-SMTPD) with SMTP
	for <user-mode-linux-devel@lists.sourceforge.net>;
	18 Jul 2004 20:35:35 +0200
From: Piotr Neuman <sikkh@wp.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZMs+AOZ7CLiAFgw"
Message-Id: <200407182036.09041.sikkh@wp.pl>
Subject: [uml-devel] Humfs in 2.4.26-um1 bug
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
Date: Sun, 18 Jul 2004 20:36:09 +0200
To: user-mode-linux-devel@lists.sourceforge.net



--Boundary-00=_ZMs+AOZ7CLiAFgw
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

There is a bug in Humfs making ownerships() function misreport grup id (used 
by stat). The fix is in humfs-2.4.26-2-meta_tdb-1.patch.bz2 already so if you 
use that, there's no need to patch.

ps. I have seen lockups during 2.4.26-um2 bootup, redirecting all output (in 
bash for example by "&>") to file or /dev/null ;-) is a quick fix.

--Boundary-00=_ZMs+AOZ7CLiAFgw
Content-Type: text/x-diff;
  charset="us-ascii";
  name="humfs_gid_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="humfs_gid_fix.patch"

Index: meta_fs.c
===================================================================
--- meta_fs.c	(revision 736)
+++ meta_fs.c	(working copy)
@@ -365,7 +365,7 @@
 	if(uid_out != NULL)
 		*uid_out = uid;
 	if(gid_out != NULL)
-		*gid_out = uid;
+		*gid_out = gid;
 	if(type_out != NULL)
 		*type_out = type;
 	if(maj_out != NULL)

--Boundary-00=_ZMs+AOZ7CLiAFgw--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
