Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIrWj-0007m6-2p for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Oct 2004 09:35:29 -0700
Received: from smtp.wp.pl ([212.77.101.160])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CIrWi-0006Se-6M
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Oct 2004 09:35:28 -0700
Received: from lodz106.vline.pl (HELO [172.16.13.24]) (sikkh@[212.191.130.106])
	(envelope-sender <sikkh@wp.pl>) by smtp.wp.pl (WP-SMTPD) with SMTP
	for <user-mode-linux-devel@lists.sourceforge.net>;
	16 Oct 2004 18:35:07 +0200
From: Piotr Neuman <sikkh@wp.pl>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_22UcBbqTJzHmehF"
Message-Id: <200410161835.02592.sikkh@wp.pl>
Subject: [uml-devel] [patch] open_meta_file (meta_fs.c) error reporting fix.
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
Date: Sat, 16 Oct 2004 18:35:02 +0200
To: user-mode-linux-devel@lists.sourceforge.net

--Boundary-00=_22UcBbqTJzHmehF
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Small bug in open_meta_file() prevents error reporting if memory allocation in 
get_path() fails (pretty unprobable but still).

Fix included (applies to UML ver. 2.6.8-um1 + externfs patch).

--Boundary-00=_22UcBbqTJzHmehF
Content-Type: text/x-diff; charset="us-ascii";
	name="hostfs_open_meta_file.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hostfs_open_meta_file.patch"

--- linux-uml/fs/hostfs/meta_fs.c.old	2004-10-16 18:32:17.514517144 +0200
+++ linux-uml/fs/hostfs/meta_fs.c	2004-10-16 18:25:14.000000000 +0200
@@ -83,8 +83,10 @@ static int open_meta_file(const char *pa
 		goto out;
 
 	meta_file = get_path(meta_path, meta_tmp, sizeof(meta_tmp));
-	if(meta_file == NULL)
+	if(meta_file == NULL) {
+		err = -ENOMEM;
 		goto out;
+	}
 	
 	err = open_filehandle(meta_file, of_rdwr(OPENFLAGS()), 0, fh);
 	if(err)

--Boundary-00=_22UcBbqTJzHmehF--


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
