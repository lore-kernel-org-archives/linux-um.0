Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Henrik Nordstrom <hno@marasystems.com>
In-Reply-To: <035a01c3b6e9$cfee1df0$2000000a@schlepptopp>
Message-ID: <Pine.LNX.4.44.0311300843150.946-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: bug in COW? -  Re: [uml-user] uml 2.6.0-test9 crash
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
Date: Sun, 30 Nov 2003 08:47:11 +0100 (CET)
To: roland <for_spam@gmx.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>

On Sun, 30 Nov 2003, roland wrote:

> 820     arch/um/drivers/ubd_kern.c: No such file or directory.  <- ???

Odd.. GDB should know where to find your sources..

Try starting the UML from the top of your kernel source tree.

> Program received signal SIGSEGV, Segmentation fault.
> 0xa002a80b in cowify_req (req=0xa02236e4, dev=0xa022ab40)
>     at arch/um/drivers/ubd_kern.c:820
> 820     in arch/um/drivers/ubd_kern.c
> (gdb) cont
> Continuing.
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0xa002a80b in cowify_req (req=0xa02236e4, dev=0xa022ab40)
>     at arch/um/drivers/ubd_kern.c:820
> 820     in arch/um/drivers/ubd_kern.c
> (gdb) 

Use the print command to try to figure out which part of the statement 
that is failing and what the different values are..

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
