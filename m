Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7CUg-0003BB-Uy for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Mar 2004 04:00:54 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B7CUf-0007Me-Vu for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Mar 2004 04:00:54 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] Kernel panic on UML linux
In-Reply-To: <200403271230.45025.mark.hurenkamp@xs4all.nl>
Message-ID: <Pine.LNX.4.44.0403271255200.19645-100000@filer.marasystems.com>
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
Date: Sat, 27 Mar 2004 13:00:42 +0100 (CET)
To: Mark Hurenkamp <mark.hurenkamp@xs4all.nl>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Sat, 27 Mar 2004, Mark Hurenkamp wrote:

> > Is this TT or SKAS mode?
> 
> This is running in SKAS mode.

I have found that GDB in some case works better if I attach to the kernel
separately, not starting the kernel from within GDB. At least on Fedora
Core 2 test 1.. the GDB version used there seems to have very many
problems, not only with UML. Maybe this also applies to your system?

To gain some time to attach the debugger you can boot the guest in
"failsafe" mode by using init=/bin/sh. Then when you have attached the
debugger, configured signals, set breakpoints etc allow the guest to
continue the boot by running

   exec /sbin/init

from the guest console..

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
