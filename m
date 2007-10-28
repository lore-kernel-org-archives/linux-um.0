Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Im0jB-0000Xd-Vu for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Oct 2007 22:30:26 -0700
Received: from ro-out-1112.google.com ([72.14.202.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Im0j8-0005fM-Ip
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Oct 2007 22:30:25 -0700
Received: by ro-out-1112.google.com with SMTP id o35so696527rog
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 27 Oct 2007 22:30:21 -0700 (PDT)
Date: Sun, 28 Oct 2007 13:25:19 +0800
From: WANG Cong <xiyou.wangcong@gmail.com>
Message-ID: <20071028052518.GC2502@hacking>
References: <20071028032441.GB2502@hacking>
	<20071028034343.GV8181@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071028034343.GV8181@ftp.linux.org.uk>
Subject: Re: [uml-devel] UML building failed in current Linus-tree
Reply-To: WANG Cong <xiyou.wangcong@gmail.com>
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
Cc: WANG Cong <xiyou.wangcong@gmail.com>, sam@ravnborg.org, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, jdike@karaya.com

On Sun, Oct 28, 2007 at 03:43:43AM +0000, Al Viro wrote:
>On Sun, Oct 28, 2007 at 11:24:41AM +0800, WANG Cong wrote:
>> 
>> Hi, Jeff, Sam!
>> 
>> I just pulled from Linus-tree, and got the following error when building uml.
>> 
>> $ make defconfig ARCH=um
>> /home/wangcong/projects/linux-2.6/arch/um/Makefile-i386:32: /home/wangcong/projects/linux-2.6/arch/i386/Makefile.cpu: No such file or directory
>> make: *** No rule to make target `/home/wangcong/projects/linux-2.6/arch/i386/Makefile.cpu'.  Stop.
>> 
>> Is this a known problem? Yesterday's Linus-tree was fine.
>
>diff --git a/arch/um/Kconfig.i386 b/arch/um/Kconfig.i386
>index 9876d80..e0ac74e 100644
>--- a/arch/um/Kconfig.i386
>+++ b/arch/um/Kconfig.i386

Thanks, Al.

With your patch, it works fine.

Jeff, could you please consider pushing this and Al's another patch[1] into
Linus-tree? UML in Linus-tree can't work for a long time. ;(

[1] http://lkml.org/lkml/2007/10/21/118

Regards.

WANG Cong


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
