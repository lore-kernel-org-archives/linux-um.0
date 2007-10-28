Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ilz44-00080v-1N for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Oct 2007 20:43:52 -0700
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ilz42-0004iO-L8
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Oct 2007 20:43:52 -0700
Date: Sun, 28 Oct 2007 03:43:43 +0000
From: Al Viro <viro@ftp.linux.org.uk>
Message-ID: <20071028034343.GV8181@ftp.linux.org.uk>
References: <20071028032441.GB2502@hacking>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071028032441.GB2502@hacking>
Subject: Re: [uml-devel] UML building failed in current Linus-tree
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
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: jdike@karaya.com, sam@ravnborg.org, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Sun, Oct 28, 2007 at 11:24:41AM +0800, WANG Cong wrote:
> 
> Hi, Jeff, Sam!
> 
> I just pulled from Linus-tree, and got the following error when building uml.
> 
> $ make defconfig ARCH=um
> /home/wangcong/projects/linux-2.6/arch/um/Makefile-i386:32: /home/wangcong/projects/linux-2.6/arch/i386/Makefile.cpu: No such file or directory
> make: *** No rule to make target `/home/wangcong/projects/linux-2.6/arch/i386/Makefile.cpu'.  Stop.
> 
> Is this a known problem? Yesterday's Linus-tree was fine.

diff --git a/arch/um/Kconfig.i386 b/arch/um/Kconfig.i386
index 9876d80..e0ac74e 100644
--- a/arch/um/Kconfig.i386
+++ b/arch/um/Kconfig.i386
@@ -1,6 +1,6 @@
 menu "Host processor type and features"
 
-source "arch/i386/Kconfig.cpu"
+source "arch/x86/Kconfig.cpu"
 
 endmenu
 
diff --git a/arch/um/Makefile-i386 b/arch/um/Makefile-i386
index 08433f8..b01dfb0 100644
--- a/arch/um/Makefile-i386
+++ b/arch/um/Makefile-i386
@@ -28,7 +28,7 @@ CONFIG_X86_32		:= y
 export CONFIG_X86_32
 
 # First of all, tune CFLAGS for the specific CPU. This actually sets cflags-y.
-include $(srctree)/arch/i386/Makefile.cpu
+include $(srctree)/arch/x86/Makefile_32.cpu
 
 # prevent gcc from keeping the stack 16 byte aligned. Taken from i386.
 cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
