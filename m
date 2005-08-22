Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E74vD-0001YN-Db	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Aug 2005 22:32:35 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1E74vB-0002ch-15
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 Aug 2005 22:32:35 -0700
Received: from localhost.localdomain (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.13.1/8.13.1) with ESMTP id j7M6wtg2023646
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 22 Aug 2005 02:59:00 -0400
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200508220032.14192.rob@landley.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] 2.6.12.3-uml has something wrong with the filesystem.
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
Date: Mon, 22 Aug 2005 00:32:14 -0500
To: user-mode-linux-devel@lists.sourceforge.net

Ok, I have a build system (www.landley.net/code/firmware) that compiles a 
Linux distro under UML (so it can build a C library against newer kernel 
headers than the parent system and not worry about binaries linked against 
that making syscalls that segfault under the old kernel during the rest of 
the build).

When I upgraded this system from 2.6.11 to 2.6.12.3, it started getting 
strange build failures.  The build failures are all of the "file not found" 
variety, but they are _random_.  I've seen failures happen in the 
builds of gcc (couldn't find a standard .h file), zlib (install failed), df 
(again install failed), and a couple other places.

This is clearly a race condition: the build actually ran to completion once, 
but most of the times it dies with a file not found.  It never dies twice in 
the same place, even when running it two or three times in sequence with no 
changes.

The filesystem it's using is an ext2 image that lives in a loopback mounted 
sparse file on hostfs.  (Yeah, this is a strange way to torture the 
filesystem, I know.  But it should work.)

Any clues as to recent patches that might be causing this?  What info do you 
need from me?  (I can send you the build tarball if you want to reproduce it 
yourself, but it's 100 megs and can take an hour or more to run to a failure 
case with nothing obvious to set the debugger to trap on to catch it in the 
act...)

Rob


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
