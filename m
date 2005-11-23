Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EesfC-0001ZP-QK for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Nov 2005 03:19:46 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Eesf9-00028Y-7y
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Nov 2005 03:19:46 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id jANCs6dv013395
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 23 Nov 2005 07:54:07 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511230519.32588.rob@landley.net>
Subject: [uml-devel] Funkiness in uml Kconfig.
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
Date: Wed, 23 Nov 2005 05:19:32 -0600
To: UML devel <user-mode-linux-devel@lists.sourceforge.net>

So you may have seen the miniconfig stuff wander by, which means that my build
script exits if there's a .config error, and we have this:

fs/Kconfig:1749:warning: 'select' used by config symbol 'CIFS_UPCALL' refer to
undefined symbol 'CONNECTOR'

This makes it shut up:

Signed-off-by: Rob Landley <rob@landley.net>

---
--- linux-2.6.14/arch/um/Kconfig 2005-11-23 05:13:33.162339168 -0600
+++ linux-2.6.15-rc2/arch/um/Kconfig 2005-11-23 05:05:56.000000000 -0600
@@ -289,6 +289,8 @@
 
 source "drivers/net/Kconfig"
 
+source "drivers/connector/Kconfig"
+
 source "fs/Kconfig"
 
 source "security/Kconfig"


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
