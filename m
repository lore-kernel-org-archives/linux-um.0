Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bsl2A-00045E-IS for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Aug 2004 09:24:02 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1Bsl29-0001MC-Vy
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Aug 2004 09:24:02 -0700
Message-Id: <200408051723.i75HNjCi003244@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Q: UML thread communication - scheduling oddness 
In-Reply-To: Your message of "Thu, 05 Aug 2004 09:35:01 EDT."
	<41123785.5040004@nortelnetworks.com> 
References: <200408050020.i750Kwvv009127@ccure.user-mode-linux.org>
	<41123785.5040004@nortelnetworks.com> 
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
Date: Thu, 05 Aug 2004 13:23:45 -0400
To: Joe Marzot <gmarzot@nortelnetworks.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Randy Macleod <macleodr@nortelnetworks.com>

gmarzot@nortelnetworks.com said:
> Could you add a few sentences though on the delivery mechnisms for the
>  the packets to the kernel thread and to userspace. I saw a poll() on
> the  pollfds array which has the taps fd in it but this is a
> non-blocking  poll and I could not trace to how often it is called and
> what triggers  it - I also saw the sigio handler but I could not see
> who was generating  the SIGIO - is that how the userspace thread is
> woken up? 

OK, an incoming packet is handled this way:
	it's received by the host and routed to the tap device (or 
alternatively, it's received by the host eth, sent to the bridge that it's part
of, and copied to the tap device which is also in the bridge)
	it pops out of /dev/net/tun, which UML has a file descriptor open to
	the file descriptor is set up O_ASYNC, so that generates a SIGIO
	this causes sigio_handler to be called
	it looks at all of the descriptors in its care, and handles all the
ones that are now active
	the network driver's interrupt routine is called whenever a tap fd is
active, and it reads the frame off the fd and passes it to the UML network 
stack

sigio_handler does blocking polls because it knows that something is active,
and that it won't, in fact, block.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
