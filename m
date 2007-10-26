Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IlJ2I-0007NN-Ha for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Oct 2007 23:51:15 -0700
Received: from astoria.ccjclearline.com ([64.235.106.9])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IlJ2F-0008GC-MQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 25 Oct 2007 23:51:12 -0700
Received: from [99.236.101.138] (helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68) (envelope-from <rpjday@crashcourse.ca>)
	id 1IlJ2C-00089l-RT for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Oct 2007 02:51:09 -0400
Date: Fri, 26 Oct 2007 02:48:21 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Message-ID: <Pine.LNX.4.64.0710260247060.27287@localhost.localdomain>
MIME-Version: 1.0
Subject: [uml-devel] infinite symlink loop for "sysdep-i386"
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
To: user-mode-linux-devel@lists.sourceforge.net


  in arch/um/include/sysdep-i386:

$ ls -l
total 96
-rw-rw-r-- 1 rpjday rpjday  363 2007-08-28 06:10 archsetjmp.h
-rw-rw-r-- 1 rpjday rpjday  281 2007-08-28 06:10 barrier.h
-rw-rw-r-- 1 rpjday rpjday 5080 2007-08-28 06:10 checksum.h
-rw-rw-r-- 1 rpjday rpjday  903 2007-08-28 06:10 faultinfo.h
-rw-rw-r-- 1 rpjday rpjday  468 2007-10-16 13:42 kernel-offsets.h
-rw-rw-r-- 1 rpjday rpjday 4897 2007-10-16 13:42 ptrace.h
-rw-rw-r-- 1 rpjday rpjday 1669 2007-08-28 06:10 ptrace_user.h
-rw-rw-r-- 1 rpjday rpjday 1757 2007-08-28 06:10 sc.h
-rw-rw-r-- 1 rpjday rpjday  615 2007-10-16 13:42 sigcontext.h
-rw-rw-r-- 1 rpjday rpjday  374 2007-08-28 06:10 skas_ptrace.h
-rw-rw-r-- 1 rpjday rpjday 2199 2007-10-16 13:42 stub.h
-rw-rw-r-- 1 rpjday rpjday  731 2007-08-28 06:10 syscalls.h
lrwxrwxrwx 1 rpjday rpjday   11 2007-10-22 04:08 sysdep-i386 -> sysdep-i386   ?????
-rw-rw-r-- 1 rpjday rpjday  769 2007-08-28 06:10 tls.h
$

rday

-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://crashcourse.ca
========================================================================

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
