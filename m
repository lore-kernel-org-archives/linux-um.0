Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMdXg-0005Mc-RH for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Feb 2007 21:09:24 -0800
Received: from pne-smtpout4-sn2.hy.skanova.net ([81.228.8.154])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HMdXg-0000zw-Cq
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Feb 2007 21:09:24 -0800
Received: from mail.refactor.fi (80.220.8.56) by
	pne-smtpout4-sn2.hy.skanova.net (7.2.075)
	id 45B62169001F5CAC for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 1 Mar 2007 06:08:55 +0100
Received: from teori.refactor.fi (teori [192.168.2.2])
	by mail.refactor.fi (Postfix) with ESMTP id 8CC461BC01A
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu,  1 Mar 2007 07:08:54 +0200 (EET)
Received: from vinsci by teori.refactor.fi with local (Exim 4.63)
	(envelope-from <vinsci@refactor.fi>) id 1HMdXC-0007w3-Ac
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 07:08:54 +0200
Message-Id: <E1HMdXC-0007w3-Ac@teori.refactor.fi>
From: =?UTF-8?Q?Leonard_Norrg=C3=A5rd?= <vinsci@refactor.fi>
Date: Thu, 01 Mar 2007 07:08:54 +0200
Subject: [uml-devel] [PATCH] fix misleading error message in
	tools/tunctl/tunctl.c
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Fix misleading error message.

Signed-off-by: Leonard Norrgard <vinsci@refactor.fi>

Index: tunctl/tunctl.c
===================================================================
RCS file: /cvsroot/user-mode-linux/tools/tunctl/tunctl.c,v
retrieving revision 1.4
diff -u -r1.4 tunctl.c
--- tunctl/tunctl.c	2 Nov 2002 19:34:19 -0000	1.4
+++ tunctl/tunctl.c	1 Mar 2007 05:04:58 -0000
@@ -101,7 +101,7 @@
       exit(1);
     }
     if(ioctl(tap_fd, TUNSETOWNER, owner) < 0){
-      perror("TUNSETPERSIST");
+      perror("TUNSETOWNER");
       exit(1);
     } 
     if(brief)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
