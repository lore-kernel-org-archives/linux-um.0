Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJBG1-00027x-QO	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 07:44:05 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EJBG0-0008OA-HL
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 07:44:06 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Any way to give /dev/console a controlling TTY?
References: <200509231135.27882.rob@landley.net>
	<200509231331.47282.rob@landley.net>
	<Pine.LNX.4.61.0509232048230.14136@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.61.0509232048230.14136@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509240943.54587.rob@landley.net>
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
Date: Sat, 24 Sep 2005 09:43:54 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Henrik Nordstrom <uml@hno.marasystems.com>

On Friday 23 September 2005 13:56, Henrik Nordstrom wrote:
> On Fri, 23 Sep 2005, Rob Landley wrote:
> >> Anybody see an obvious way to make /dev/console a controlling TTY?
>
> The user-space process who wants it as a controlling tty needs to run
>
>    ioctl(0, TIOCSCTTY, (void *) 1);
>
> You should also take care to set up the termios parameters correctly.
>
> At http://marasystems.com/download/ctty/ you can find a little tool we use
> in embedded systems making /dev/console a controlling TTY. We use from
> inittab in the main console entries (single and console).

So I fire up UML:

./linux rootfstype=hostfs rw init=/bin/sh LD_ASSUME_KERNEL=2.4.1

And I run the above program "./ctty /bin/sh"

And I get:

sh-3.00# ./ctty /bin/sh
idr_remove called for id=5 which is not allocated.
08b77930:  [<080fe55f>] sub_remove+0xef/0x100
08b77990:  [<080fe59f>] idr_remove+0x2f/0xc0
08b779b0:  [<08107282>] release_dev+0x5d2/0x6f0
08b77a30:  [<08106745>] init_dev+0x1b5/0x5b0
08b77a80:  [<081074ec>] tty_open+0x14c/0x370
08b77a90:  [<080b38bf>] cdev_get+0xf/0x20
08b77aa0:  [<080b3a8f>] exact_lock+0xf/0x20
08b77ab0:  [<08111130>] kobj_lookup+0xe0/0xf0
08b77ad8:  [<081073a0>] tty_open+0x0/0x370
08b77ae0:  [<080b398e>] chrdev_open+0x9e/0x120
08b77af0:  [<08061757>] buffer_op+0x47/0x80
08b77af4:  [<08061590>] do_buffer_op+0x0/0x180
08b77b10:  [<080a971a>] dentry_open+0x10a/0x190
08b77b2c:  [<080ec008>] empty_dir+0x18/0x330
08b77b30:  [<080a9608>] filp_open+0x68/0x70
08b77b74:  [<080ec000>] empty_dir+0x10/0x330
08b77b90:  [<080a9949>] sys_open+0x49/0x90
08b77bb0:  [<08061067>] execute_syscall_skas+0xd7/0xe0
08b77bb4:  [<080ec008>] empty_dir+0x18/0x330
08b77bd0:  [<0805bc55>] change_signals+0x65/0x90
08b77be4:  [<080ec008>] empty_dir+0x18/0x330
08b77c04:  [<080ec008>] empty_dir+0x18/0x330
08b77c40:  [<08061091>] handle_syscall+0x21/0x40
08b77c50:  [<0805fb18>] handle_trap+0x28/0x130
08b77c80:  [<08060164>] userspace+0x1c4/0x220
08b77cd0:  [<080612f4>] force_flush_all_skas+0x44/0x50
08b77cf0:  [<08060bf1>] fork_handler+0xc1/0xe0

sh-3.00#

Which is not too surprising because I get an error like that most of the time 
when I start UML anyway.  (I've mentioned it here before, still no idea what 
it is.)

So it's a shell just like the one I had before: Ctrl-C is still being ignored.

Right, so exit out of that into the first UML shell, and then type "reset".  
(The standard reset(1) command.)

And I get a hang.  The screen clears but I never get my prompt back, and 
although hitting enter moves the cursor down the screen nothing I type makes 
any difference (including ctrl-c).

Anybody else tried this?

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
