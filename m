Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bvivz-00006g-9P for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Aug 2004 13:45:55 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1Bvivy-0001E8-FJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Aug 2004 13:45:54 -0700
Message-Id: <200408132147.i7DLlB2o003883@ccure.user-mode-linux.org>
Subject: Re: handle_trap - failed to wait at end of syscall [was Re:
	[uml-devel] debugging UML cores] 
In-Reply-To: Your message of "Fri, 13 Aug 2004 11:46:04 EDT."
	<411CE23C.4070903@nortelnetworks.com> 
References: <200408120541.i7C5faJd010923@ccure.user-mode-linux.org>
	<411B8E89.5040407@nortelnetworks.com>
	<411CE23C.4070903@nortelnetworks.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Fri, 13 Aug 2004 17:47:11 -0400
To: Joe Marzot <gmarzot@nortelnetworks.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

gmarzot@nortelnetworks.com said:
> WSTOPSIG(err) = SIGHUP
> does this give any clues...any ideas of what else to look at?

Do you have any idea how you're making this happen?  The userspace process is
getting a SIGHUP in the middle of having a system call nullified.  This is OK
since a SIGHUP can happen any time if you log out on it or something, but
I'd like to know exactly what's going on so I can decide what the right reaction
to it is.

Simplistically, we could just handle it there and ignore it, since UML probably
got the SIGHUP as well, and will deal with it then.

				Jeff




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
