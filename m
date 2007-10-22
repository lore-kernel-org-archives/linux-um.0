Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ik3pZ-0004G7-Rx for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Oct 2007 13:24:57 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ik3pZ-0000ck-0O
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Oct 2007 13:24:57 -0700
Date: Mon, 22 Oct 2007 16:24:06 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071022202406.GA9556@c2.user-mode-linux.org>
References: <200710111754.46854.rob@landley.net>
	<200710200252.37919.p.giarrusso@gmail.com>
	<87y7dyhv2u.fsf@hades.wkstn.nix> <20071021114854.GF2455@hacking>
	<20071021130848.GA4621@c2.user-mode-linux.org>
	<20071021132031.GI2455@hacking>
	<20071021154346.GW8181@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071021154346.GW8181@ftp.linux.org.uk>
Subject: Re: [uml-devel] User Mode Linux still doesn't build in 2.6.23-final.
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
To: Al Viro <viro@ftp.linux.org.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, Paolo Giarrusso <p.giarrusso@gmail.com>, linux-kernel@vger.kernel.org, Nix <nix@esperi.org.uk>, Rob Landley <rob@landley.net>, WANG Cong <xiyou.wangcong@gmail.com>

On Sun, Oct 21, 2007 at 04:43:46PM +0100, Al Viro wrote:
> Fallout continues; I've got a preliminary patch for it.  Basically, we
> need to stop doing -U__i386__ et.al.

Thanks, Al.  You need the patch below in order to get a working UML -
feel free to fold it into this.

				Jeff

-- 
Work email - jdike at linux dot intel dot com


KERNEL_DEFINES needs whitespace trimmed, otherwise this whitespace
crunching done by make fools the patsubst which is used to remove
KERNEL_DEFINES from USER_CFLAGS.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/Makefile |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/um/Makefile
===================================================================
--- linux-2.6.orig/arch/um/Makefile	2007-10-22 16:19:38.000000000 -0400
+++ linux-2.6/arch/um/Makefile	2007-10-22 16:19:44.000000000 -0400
@@ -70,9 +70,12 @@ include $(srctree)/$(ARCH_DIR)/Makefile-
 # in KBUILD_CFLAGS.  Otherwise, it would cause ld to complain about the two different
 # errnos.
 # These apply to kernelspace only.
+#
+# strip leading and trailing whitespace to make the USER_CFLAGS removal of these
+# defines more robust
 
-KERNEL_DEFINES = -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask \
-	-Dmktime=kernel_mktime $(ARCH_KERNEL_DEFINES)
+KERNEL_DEFINES = $(strip -Derrno=kernel_errno -Dsigprocmask=kernel_sigprocmask \
+			 -Dmktime=kernel_mktime $(ARCH_KERNEL_DEFINES))
 KBUILD_CFLAGS += $(KERNEL_DEFINES)
 KBUILD_CFLAGS += $(call cc-option,-fno-unit-at-a-time,)
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
