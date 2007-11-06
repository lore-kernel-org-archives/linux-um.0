Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IpQu1-00064M-6z for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Nov 2007 08:03:45 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IpQtz-0002Qh-K6
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Nov 2007 08:03:45 -0800
Date: Tue, 6 Nov 2007 11:02:50 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071106160250.GB6637@c2.user-mode-linux.org>
References: <20071106114602.GB7652@hacking>
	<20071106141143.GI8181@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071106141143.GI8181@ftp.linux.org.uk>
Subject: Re: [uml-devel] UML defconfig building failed again
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
To: Al Viro <viro@ftp.linux.org.uk>, Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: WANG Cong <xiyou.wangcong@gmail.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, jdike@karaya.com

On Tue, Nov 06, 2007 at 02:11:43PM +0000, Al Viro wrote:
> Sigh...  Kbuild breakage this time...  See if %s/\<[AC]FLAGS\>/KBUILD_&/g
> in arch/um/Makefile-i386 helps.

Yup, this fixes it:


     [AC]FLAGS -> KBUILD_[AC]FLAGS conversion in Makefile-i386.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/Makefile-i386 |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/Makefile-i386 b/arch/um/Makefile-i386
index b01dfb0..6729011 100644
--- a/arch/um/Makefile-i386
+++ b/arch/um/Makefile-i386
@@ -22,8 +22,8 @@ export LDFLAGS HOSTCFLAGS HOSTLDFLAGS UML_OBJCOPYFLAGS
 endif
 endif
 
-CFLAGS			+= -DCONFIG_X86_32
-AFLAGS			+= -DCONFIG_X86_32
+KBUILD_CFLAGS		+= -DCONFIG_X86_32
+KBUILD_AFLAGS		+= -DCONFIG_X86_32
 CONFIG_X86_32		:= y
 export CONFIG_X86_32


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
