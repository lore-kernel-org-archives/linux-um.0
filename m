Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FMqmf-0003VY-Nr for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:13:13 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FMqme-0001Fi-Uc
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 24 Mar 2006 10:13:13 -0800
Message-Id: <200603241814.k2OIEY8R005505@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/16] UML - Fix declaration of exit()
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
Date: Fri, 24 Mar 2006 13:14:34 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This fixes a conflict between a header and what gcc "knows" the declaration'
to be.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/include/kern.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/include/kern.h	2006-02-21 16:02:19.000000000 -0500
+++ linux-2.6.15-mm/arch/um/include/kern.h	2006-02-21 16:15:14.000000000 -0500
@@ -29,7 +29,7 @@ extern int getuid(void);
 extern int getgid(void);
 extern int pause(void);
 extern int write(int, const void *, int);
-extern int exit(int);
+extern void exit(int);
 extern int close(int);
 extern int read(unsigned int, char *, int);
 extern int pipe(int *);



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
