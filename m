Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7BTS-0006pA-UA for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Mar 2004 02:55:34 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7BTQ-00078f-Pm for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Mar 2004 02:55:33 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] Kernel panic on UML linux
In-Reply-To: <200403270448.04891.mark.hurenkamp@xs4all.nl>
Message-ID: <Pine.LNX.4.44.0403271153250.19079-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Sat, 27 Mar 2004 11:55:22 +0100 (CET)
To: Mark Hurenkamp <mark.hurenkamp@xs4all.nl>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Sat, 27 Mar 2004, Mark Hurenkamp wrote:

> I went and read some more on the UML site, and found
> some hints that helped me get the UML running within GDB
> However, for some reason GDB reports 'Program exited normally',
> eventhough there is a kernel panic.
> Could that be due to disabling the SIGSEGV handler?

No.

You need to set a breakpoint on panic

break panic

> crashes after enabling the firewall (this case, mandrake 8.2
> system with Bastille firewall), but the addresses mentioned
> are different (Kernel panic: Kernel mode fault at addr 0x48b16000, 
> ip 0x400fc344).
> Without the firewall enabled, both systems work flawlessly.

Is this TT or SKAS mode?

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
