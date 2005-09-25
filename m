Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJK97-0006XZ-JG	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 17:13:33 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EJK96-0001Mw-36
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 17:13:33 -0700
Received: from localhost.localdomain (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.13.1/8.13.1) with ESMTP id j8P1goc0008513
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 24 Sep 2005 21:42:50 -0400
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509241913.24060.rob@landley.net>
Subject: [uml-devel] Curiosity about nested UML invocations...
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
Date: Sat, 24 Sep 2005 19:13:23 -0500
To: user-mode-linux-devel@lists.sourceforge.net

So what does "nesting level" actually do, anyway?  Trying to run UML from 
within itself (giving the outer invocation mem=128M), I get the following 
error:

sh-3.00# ./linux rootfstype=hostfs rw init=/bin/sh LD_ASSUME_KERNEL=2.4.1
Checking for /proc/mm...not found
Checking for the skas3 patch in the host...found
UML running in SKAS0 mode
os_mode_fd: No such file or directory
sh-3.00#

Just playing around, really, but now I'm curious...

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
