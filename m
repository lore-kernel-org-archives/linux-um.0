Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IIUI3-0006XN-4s for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Aug 2007 12:00:23 -0700
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IIUI1-0005Rm-Fl
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Aug 2007 12:00:23 -0700
From: <gregkh@suse.de>
Date: Tue, 07 Aug 2007 11:55:10 -0700
In-Reply-To: <20070710164904.GA7825@c2.user-mode-linux.org>
Message-Id: <20070807190014.833E414458DB@imap.suse.de>
Subject: [uml-devel] patch uml-exports-for-hostfs.patch queued to -stable tree
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com, gregkh@suse.de, jdike@linux.intel.com, user-mode-linux-devel@lists.sourceforge.net
Cc: stable-commits@vger.kernel.org


This is a note to let you know that we have just queued up the patch titled

     Subject: UML: exports for hostfs

to the 2.6.22-stable tree.  Its filename is

     uml-exports-for-hostfs.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


From stable-bounces@linux.kernel.org Tue Jul 10 17:33:49 2007
From: Jeff Dike <jdike@addtoit.com>
Date: Tue, 10 Jul 2007 12:49:04 -0400
Subject: UML: exports for hostfs
To: stable@kernel.org
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Message-ID: <20070710164904.GA7825@c2.user-mode-linux.org>


Add some exports for hostfs that are required after Alberto Bertogli's
fixes for accessing unlinked host files.

Also did some style cleanups while I was here.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- linux-2.6.17.orig/arch/um/os-Linux/user_syms.c	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/user_syms.c	2007-07-10 11:35:22.000000000 -0400
@@ -5,7 +5,8 @@
  * so I *must* declare good prototypes for them and then EXPORT them.
  * The kernel code uses the macro defined by include/linux/string.h,
  * so I undef macros; the userspace code does not include that and I
- * add an EXPORT for the glibc one.*/
+ * add an EXPORT for the glibc one.
+ */
 
 #undef strlen
 #undef strstr
@@ -61,12 +62,18 @@ EXPORT_SYMBOL_PROTO(dup2);
 EXPORT_SYMBOL_PROTO(__xstat);
 EXPORT_SYMBOL_PROTO(__lxstat);
 EXPORT_SYMBOL_PROTO(__lxstat64);
+EXPORT_SYMBOL_PROTO(__fxstat64);
 EXPORT_SYMBOL_PROTO(lseek);
 EXPORT_SYMBOL_PROTO(lseek64);
 EXPORT_SYMBOL_PROTO(chown);
+EXPORT_SYMBOL_PROTO(fchown);
 EXPORT_SYMBOL_PROTO(truncate);
+EXPORT_SYMBOL_PROTO(ftruncate64);
 EXPORT_SYMBOL_PROTO(utime);
+EXPORT_SYMBOL_PROTO(utimes);
+EXPORT_SYMBOL_PROTO(futimes);
 EXPORT_SYMBOL_PROTO(chmod);
+EXPORT_SYMBOL_PROTO(fchmod);
 EXPORT_SYMBOL_PROTO(rename);
 EXPORT_SYMBOL_PROTO(__xmknod);
 
@@ -102,14 +109,3 @@ EXPORT_SYMBOL(__stack_smash_handler);
 
 extern long __guard __attribute__((weak));
 EXPORT_SYMBOL(__guard);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */

_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable



Patches currently in stable-queue which might be from jdike@addtoit.com are

queue-2.6.22/uml-limit-request-size-on-cowed-devices.patch
queue-2.6.22/uml-exports-for-hostfs.patch

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
