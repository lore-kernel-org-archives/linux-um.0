Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xsLd-0004qn-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 11:08:45 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xsLc-0007tO-0m
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Sep 2003 11:08:44 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h8CI0ej14027
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 14:00:41 -0400
Message-Id: <200309121808.h8CI8de4003128@ccure.karaya.com>
Subject: Re: [uml-devel] write SIGIO emulation thread and ubd driver asynchronous I/O thread 
In-Reply-To: Your message of "Thu, 11 Sep 2003 03:23:02 CDT."
             <Pine.LNX.4.44.0309110316270.14423-100000@moby.ittc.ku.edu> 
References: <Pine.LNX.4.44.0309110316270.14423-100000@moby.ittc.ku.edu> 
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
Date: Fri, 12 Sep 2003 14:08:39 -0400
To: Vishveswar Reddy Challagonda <vish@ittc.ku.edu>
Cc: user mode linux list <user-mode-linux-devel@lists.sourceforge.net>

vish@ittc.ku.edu said:
> But I am yet to deal with 'ubd driver asynchronous I/O thread' and
> 'Write  SIGIO emulation thread'. 

The first is the standard technique of simulating async IO when the kernel
doesn't support it.  You start a new thread for each outstanding IO request
you want, and each handles a request synchronously, notifying you asynchronously
when it is done.

The SIGIO emulation thread is basically the same thing.  Some devices don't
deliver SIGIO when we think they ought to, so that thread waits for IO 
synchronously, and notifies UML asynchronously when it comes in.  In this 
particular case, the problem is with SIGIO when output is possible, not when
input is available.  So the thread waits for poll to tell it that the
descriptor is accepting output again.

> Does the concept of ptracing come here
> also?

No.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
