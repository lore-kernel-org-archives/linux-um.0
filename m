Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GxTzs-0000jX-LO for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Dec 2006 11:54:32 -0800
Received: from swingline.cs.wisc.edu ([128.105.121.52])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GxTzr-0005Kp-AE
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Dec 2006 11:54:32 -0800
Received: from swingline.cs.wisc.edu (localhost [127.0.0.1])
	by swingline.cs.wisc.edu (8.13.6/8.13.6) with ESMTP id kBLJsOXB031093
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 21 Dec 2006 13:54:24 -0600
Received: (from epaulson@localhost)
	by swingline.cs.wisc.edu (8.13.6/8.13.6/Submit) id kBLJsOYe031092
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Dec 2006 13:54:24 -0600
Date: Thu, 21 Dec 2006 13:54:24 -0600
From: Erik Paulson <epaulson@cs.wisc.edu>
Message-ID: <20061221195424.GB30967@swingline.cs.wisc.edu>
References: <458142B3.7050807@freemail.gr>
	<20061220180830.GE5488@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20061220180830.GE5488@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] porting uml to Hurd
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

On Wed, Dec 20, 2006 at 01:08:30PM -0500, Jeff Dike wrote:
> 
<...>
> There's no documentation to speak of wrt to an OS port.  There is some
> outdated architecture porting information at
> http://user-mode-linux.sourceforge.net/arch-port.html, some of which
> is relevant.
> 
> Here's a little list off the top of my head, for a skas-like mode  -
> 	interception and nullification of another process system calls
> 	ability to change memory mappings of another process
> 	interception and nullification of signals received by another
> process
> 
> If you can handle those, you are probably in good shape.
> 
> If you can't do the second two, then a tt-like mode might be possible,

What are the options for an OS that can't intercept system calls? On Darwin
(the BSD part of MacOS X) there is no PTRACE_SYSCALL - Apple's stance on
intercepting system calls is 'use dynamic loader hacks'. They also appear
to use sysenter for system calls (and I think int80 in some places too)

Modifying memory is easy on MacOS, in fact it's a lot easier than on Linux.

For system calls, past apporaches have been to patch the MacOS host kernel:
http://www.citi.umich.edu/u/provos/systrace/macosx.html

I suppose a MacOS UML could do some binary translation looking for Linux
system calls too.

For a good overview of some of the MacOS functionality, see:
http://uninformed.org/?v=4&a=3&t=sumry

-Erik


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
