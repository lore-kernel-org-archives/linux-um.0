Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9hE0-0001W1-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 15 Oct 2003 01:41:44 -0700
Received: from ns.sysgo.de ([213.68.67.98] helo=dagobert.svc.sysgo.de)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A9hDy-0000nd-AB
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 15 Oct 2003 01:41:42 -0700
Message-ID: <3F8D08B5.3010001@sysgo.de>
From: azu <azu@sysgo.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] filemap feature 2.4.22-5um
References: <BAY7-F10EP60A1ozvkh00011910@hotmail.com>
In-Reply-To: <BAY7-F10EP60A1ozvkh00011910@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 15 Oct 2003 10:43:33 +0200
To: Steve Schmidtke <steve_schmidtke@hotmail.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

> ISSUE:  The UML will panic if it runs out of /proc/mm fds.

returning -ENOMEM for example triggers the oom-killer in my tests.
and thats not what we want.

> ISSUE:  What side effects does re-using an address space have?

it's slow, but should work:

you need to cleanup (unmap all pages or reopen the fd) an dirty address
space before switching it if the mm differs.

the pager will map you all pages you need on demand.
i tested this by removing the premapping (removed the mmap() and
mprotect() calls in fix_range()), but it's much slower.

access to userspace is always safe in skas-mode.

alex




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
