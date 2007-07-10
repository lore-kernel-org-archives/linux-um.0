Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I8I5U-0001YX-3z for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Jul 2007 08:57:16 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I8I5T-00019w-JQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 Jul 2007 08:57:16 -0700
Date: Tue, 10 Jul 2007 11:56:55 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070710155655.GA7645@c2.user-mode-linux.org>
References: <3d0408630707070401i336cc879k8055d5858c97054a@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3d0408630707070401i336cc879k8055d5858c97054a@mail.gmail.com>
Subject: Re: [uml-devel] UML Build error when hostFS support is included.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Yan Zheng <yanzheng@21cn.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Jul 07, 2007 at 07:01:36PM +0800, Yan Zheng wrote:
> Hi all.
> 
> I get fellow error message, when build UML with default config (make
> defconfig) except hostFS support is included.  the kernel is 2.6.22-rc7.

Try the patch below.

		Jeff

-- 
Work email - jdike at linux dot intel dot com

Add some exports for hostfs that are required after Alberto Bertogli's
fixes for accessing unlinked host files.

Also did some style cleanups while I was here.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/os-Linux/user_syms.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

Index: linux-2.6.17/arch/um/os-Linux/user_syms.c
===================================================================
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

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
