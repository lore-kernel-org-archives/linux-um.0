Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I9PmZ-00017w-G5 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 11:22:25 -0700
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I9PaZ-0007ni-1F
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 11:10:00 -0700
Message-ID: <4697BFCB.2060701@nagafix.co.uk>
Date: Fri, 13 Jul 2007 19:09:15 +0100
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <46975C78.5010903@nagafix.co.uk>
	<20070713160500.GB7468@c2.user-mode-linux.org>
In-Reply-To: <20070713160500.GB7468@c2.user-mode-linux.org>
Subject: Re: [uml-devel] link failure, multiple definition of 'in6addr_any'
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> On Fri, Jul 13, 2007 at 12:05:28PM +0100, Antoine Martin wrote:
>   
>> /usr/lib/gcc/x86_64-pc-linux-gnu/4.1.2/../../../../lib64/libc.a(in6_addr.o):(.rodata+0x0): 
>> multiple definition of `in6addr_any'
>> net/built-in.o:(.rodata+0x5380): first defined here
>> collect2: ld returned 1 exit status
>>     
>
> I hate to do this, but can you check the patch below?
>   
Works for me (tm)

btw, if you're in bug squashing mode, I've got one which is 100% 
reproducible - looks like a resource leak to me: simply run a post 
2.6.20 guest kernel on a 2.6.21.5 32-bit host (IIRC with or without 
skas3) and do an "emerge --sync" (gentoo fs) on the guest. It will hang 
half way through, you can interrupt the task with ^Z, but nothing else 
will run after that.

Antoine
> I really need to find a way to separate the kernel and libc namespaces.
>
> 				Jeff
>
>   


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
