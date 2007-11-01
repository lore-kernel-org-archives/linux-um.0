Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IniAH-0004m8-3y for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Nov 2007 15:05:26 -0700
Received: from jade.aracnet.com ([216.99.193.136])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IniAF-000476-69
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Nov 2007 15:05:24 -0700
Received: from [192.168.0.4] (216-99-213-225.dsl.aracnet.com [216.99.213.225])
	(authenticated bits=0)
	by jade.aracnet.com (8.13.6/8.12.8) with ESMTP id lA1M5HdO009281
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 1 Nov 2007 15:05:21 -0700
Message-ID: <472A4DAC.3060104@BitWagon.com>
Date: Thu, 01 Nov 2007 15:05:32 -0700
From: John Reiser <jreiser@BitWagon.com>
MIME-Version: 1.0
Subject: [uml-devel] why allocate page for stack in clone(, stack,
	~CLONE_VM & (...)) ?
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

In arch/um/os/start_up.c, function start_ptraced_child() does:
        pid = clone(ptrace_child, (void *) sp, SIGCHLD, NULL);
where sp points into a newly- mmap()ed page.  Instead, why not
avoid the mmap() entirely via:
        pid = clone(ptrace_child, NULL,        SIGCHLD, NULL);

Because the flags to clone() do not contain CLONE_VM, then the clone()
is equivalent to a fork() with respect to address space.  The child does not
share VM with the parent, and using the same addresses for the stack
causes no overwrites.  Perhaps the Dcache efficiency is slightly
less, but much less costly than mmap() and the eventual munmap().

-- 
John Reiser, jreiser@BitWagon.com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
