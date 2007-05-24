Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hr9dA-0002oQ-7m for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 May 2007 02:29:12 -0700
Received: from adsl-63-197-69-248.dsl.snfc21.pacbell.net ([63.197.69.248]
	helo=nsd.dyndns.org)
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1Hr9d8-0002nz-Sf
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 May 2007 02:29:12 -0700
Received: from n-dade by nsd.dyndns.org with local (Exim 3.35 #1)
	id 1Hr9d2-00011l-00 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 May 2007 02:29:04 -0700
Date: Thu, 24 May 2007 02:29:04 -0700
Message-ID: <20070524092904.GB3768@sparc20.esperanza>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
From: "Nicolas S. Dade" <n-dade@nsd.dyndns.org>
Subject: [uml-devel] fix SEGV in handle_page_fault() when current->mm is NULL
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In a non-uml kernel a get_user() when current->mm is NULL (kernel thread, or
userspace process being torn down) returns error. In uml it SEGVs. The bug is
that handle_page_fault() does not check for NULL before using mm. The
trivial attached patch fixes this.

-Nicolas Dade

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix.patch"

--- linux-2.6.21.2/arch/um/kernel/trap.c.orig	2007-05-24 02:22:42.000000000 -0700
+++ linux-2.6.21.2/arch/um/kernel/trap.c	2007-05-24 02:23:45.000000000 -0700
@@ -51,6 +51,9 @@
 	 * fail. */
 	if (in_atomic())
 		goto out_nosemaphore;
+	/* If we have no user-space just fail */
+	if (!mm)
+		goto out_nosemaphore;
 
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--oyUTqETQ0mS9luUI--

