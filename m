Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AQZJd-0003O1-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 30 Nov 2003 13:41:17 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AQZJd-0003GW-0B
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 30 Nov 2003 13:41:17 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] Valgrinding Linux kernel with UML
In-Reply-To: <Law10-F99ny3O76JOTB00020380@hotmail.com>
Message-ID: <Pine.LNX.4.44.0311302238510.4256-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Sun, 30 Nov 2003 22:41:13 +0100 (CET)
To: derry shribman <derrysh@hotmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

There was some discussion on this some weeks ago, indicating at least that
it was possible to run UML under valgrind with some patches to valgrind
but unless it was thought about the kmalloc/kfree and friends it could not
do much useful.. check the archives if you have not already, maybe there 
is some useful clues.

Regards
Henrik

On Sun, 30 Nov 2003, derry shribman wrote:

> Hi,
> 
> I have been using valgrind for quite a while, and found it to be very useful 
> for my user-mode Linux programming.
> I therefore tried getting valgrind to work on the Linux Kernel, with UML.
> 
> I did a few quick hacks:
> - getting valgrind it to know UML's kmalloc/kfree and friends
> - canceling the sanity check valgrind performs upon loading an image, in 
> which it checks the image base address (since UML loads the kernel at a 
> different virtual start address than regular applications start address).
> 
> Still - valgrind+UML crashed immediately.
> 
> Did anyone try out valgrind+UML?
> 
> Thanks,
> Derry
> 
> _________________________________________________________________
> Protect your PC - get McAfee.com VirusScan Online 
> http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: SF.net Giveback Program.
> Does SourceForge.net help you be more productive?  Does it
> help you create better code?  SHARE THE LOVE, and help us help
> YOU!  Click Here: http://sourceforge.net/donate/
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
