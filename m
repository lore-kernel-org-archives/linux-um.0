Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G1TiO-0008BI-JB for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Jul 2006 12:52:44 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G1TiL-0000iq-Q4
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 14 Jul 2006 12:52:44 -0700
Message-Id: <200607141952.k6EJqOtL005577@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Fri, 14 Jul 2006 15:52:23 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH] UML - fix utsname build breakage
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: torvalds@osdl.org
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Some -mm-only material leaked into a patch destined for mainline, and I didn't
notice.

This was the replacement of system_utsname with utsname() that's required by
the uts namespace patch.  This patch reverts those changes (which are correct
in -mm) so that mainline UML builds again.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/kernel/syscall.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/syscall.c	2006-07-14 12:42:46.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/syscall.c	2006-07-14 15:43:31.000000000 -0400
@@ -110,7 +110,7 @@ long sys_uname(struct old_utsname __user
 	if (!name)
 		return -EFAULT;
 	down_read(&uts_sem);
-	err = copy_to_user(name, utsname(), sizeof (*name));
+	err = copy_to_user(name, &system_utsname, sizeof (*name));
 	up_read(&uts_sem);
 	return err?-EFAULT:0;
 }
@@ -126,21 +126,21 @@ long sys_olduname(struct oldold_utsname 
 
   	down_read(&uts_sem);
 
-	error = __copy_to_user(&name->sysname, &utsname()->sysname,
+	error = __copy_to_user(&name->sysname,&system_utsname.sysname,
 			       __OLD_UTS_LEN);
-	error |= __put_user(0, name->sysname + __OLD_UTS_LEN);
-	error |= __copy_to_user(&name->nodename, &utsname()->nodename,
+	error |= __put_user(0,name->sysname+__OLD_UTS_LEN);
+	error |= __copy_to_user(&name->nodename,&system_utsname.nodename,
 				__OLD_UTS_LEN);
-	error |= __put_user(0, name->nodename + __OLD_UTS_LEN);
-	error |= __copy_to_user(&name->release, &utsname()->release,
+	error |= __put_user(0,name->nodename+__OLD_UTS_LEN);
+	error |= __copy_to_user(&name->release,&system_utsname.release,
 				__OLD_UTS_LEN);
-	error |= __put_user(0, name->release + __OLD_UTS_LEN);
-	error |= __copy_to_user(&name->version, &utsname()->version,
+	error |= __put_user(0,name->release+__OLD_UTS_LEN);
+	error |= __copy_to_user(&name->version,&system_utsname.version,
 				__OLD_UTS_LEN);
-	error |= __put_user(0, name->version + __OLD_UTS_LEN);
-	error |= __copy_to_user(&name->machine, &utsname()->machine,
+	error |= __put_user(0,name->version+__OLD_UTS_LEN);
+	error |= __copy_to_user(&name->machine,&system_utsname.machine,
 				__OLD_UTS_LEN);
-	error |= __put_user(0, name->machine + __OLD_UTS_LEN);
+	error |= __put_user(0,name->machine+__OLD_UTS_LEN);
 
 	up_read(&uts_sem);
 



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
