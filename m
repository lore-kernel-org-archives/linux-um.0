Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A9ryP-0003jw-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 15 Oct 2003 13:10:21 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A9ryI-0005HF-Nh
	for User-mode-linux-devel@lists.sourceforge.net; Wed, 15 Oct 2003 13:10:15 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h9FJxGj12772
	for <User-mode-linux-devel@lists.sourceforge.net>; Wed, 15 Oct 2003 15:59:17 -0400
Message-Id: <200310152013.h9FKDt4f028934@ccure.karaya.com>
Subject: Re: [uml-devel] filemap feature 2.4.22-5um 
In-Reply-To: Your message of "Tue, 14 Oct 2003 22:58:34 -0000."
             <BAY7-F10EP60A1ozvkh00011910@hotmail.com> 
References: <BAY7-F10EP60A1ozvkh00011910@hotmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Wed, 15 Oct 2003 16:13:55 -0400
To: Steve Schmidtke <steve_schmidtke@hotmail.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

steve_schmidtke@hotmail.com said:
> ISSUE:  The UML will panic if it runs out of /proc/mm fds.

This won't be an issue with the skas4 patch, which uses a system call to
get new address spaces.

> TODO:  Make the filemap lookup routine re-entrant safe.

Before you go wild with locking, look at the callers and see if they are
re-entrant.  This obviously won't work for things that are called from all
over the place, but if something is called from one place that is itself
locked, then you don't need to worry about it.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
