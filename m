Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoXLz-00058Y-En
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 04 Feb 2004 16:26:47 -0800
Received: from mta5.srv.hcvlny.cv.net ([167.206.5.78])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoXLy-00006z-Q5
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 04 Feb 2004 16:26:46 -0800
Received: from 10.0.0.11 (ool-44c218a8.dyn.optonline.net [68.194.24.168])
 by mta5.srv.hcvlny.cv.net
 (iPlanet Messaging Server 5.2 HotFix 1.16 (built May 14 2003))
 with ESMTP id <0HSL00JOL58KNK@mta5.srv.hcvlny.cv.net> for
 user-mode-linux-devel@lists.sourceforge.net; Wed,
 04 Feb 2004 19:26:45 -0500 (EST)
From: "Josef 'Jeff' Sipek" <jeffpc@optonline.net>
Message-id: <200402041926.39098.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
Subject: [uml-devel] [patch] 2.6 uml & CONFIG_SMP fix
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
Date: Wed, 04 Feb 2004 19:26:29 -0500
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,
	yesterday, I finally got around to fixing the code. Right now, it
compiles, but there are some warnings that I didn't take a look at.
This patch makes it compile with CONFIG_SMP, nothing more.
I tested the resulting binary, and it works well in tt (I did NOT test
skas.) 

You should be able to pull the patch from
http://kernel.bkbits.net:14690/jeffpc/uml-smp/ (I think that pulling via web
is not working, I'll check later.)

Jeff.

diff -Nru a/arch/um/Makefile b/arch/um/Makefile
- --- a/arch/um/Makefile	Tue Feb  3 21:48:38 2004
+++ b/arch/um/Makefile	Tue Feb  3 21:48:38 2004
@@ -170,7 +170,7 @@
 	ln -sf $(basename $(notdir $@))-$(SUBARCH)$(suffix $@) $(notdir $@)
 
 include/asm-um/arch:
- -	cd $(TOPDIR)/include/asm-um && ln -sf ../asm-$(SUBARCH) arch
+	cd $(TOPDIR)/include/asm-um && ln -sf ../asm-$(SUBARCH) arch && ln -sf arch/spinlock.h
 
 $(ARCH_DIR)/include/sysdep:
 	cd $(ARCH_DIR)/include && ln -sf sysdep-$(SUBARCH) sysdep
diff -Nru a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
- --- a/arch/um/kernel/irq.c	Tue Feb  3 21:48:38 2004
+++ b/arch/um/kernel/irq.c	Tue Feb  3 21:48:38 2004
@@ -584,7 +584,7 @@
 					unsigned long count, void *data)
 {
 	int irq = (long) data, full_count = count, err;
- -	cpumask_t new_value;
+	cpumask_t new_value, tmp;
 
 	if (!irq_desc[irq].handler->set_affinity)
 		return -EIO;


- -- 
"Intellectuals solve problems; geniuses prevent them"
		- Albert Einstein
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAIY28wFP0+seVj/4RAr8dAKCrYt3JZg+cFUIoKGVNpgxX9pGuqwCfUFsM
vsjhr3DJcTBwzxkMwFNR+OU=
=GXuF
-----END PGP SIGNATURE-----



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
