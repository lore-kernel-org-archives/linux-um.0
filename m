Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ynAs-0003QF-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 23:49:26 -0700
Received: from [128.123.64.160] (helo=hongkong.cs.nmsu.edu ident=0)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19ynAr-0004sZ-Hv
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 14 Sep 2003 23:49:25 -0700
From: Ross Combs <rocombs@cs.nmsu.edu>
Message-Id: <200309150649.h8F6nIHc022712@hongkong.cs.nmsu.edu>
Subject: [uml-devel] Re: 2.4.22-4um race condition
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
Date: Mon, 15 Sep 2003 00:49:18 -0600
To: jdike@karaya.com, rocombs@cs.nmsu.edu
Cc: user-mode-linux-devel@lists.sourceforge.net

The "correct" fix seems to have completely removed the errors.
I just moved these two lines:

        kernel_fd = fds[0];
        *fd_out = fds[1];

to before the clone() in ubd_user.c.  Is this correct?

(and CC'd the ML because I forgot to last time)

-Ross


> From rocombs@hongkong.cs.nmsu.edu  Mon Sep 15 00:29:35 2003
> Date: Mon, 15 Sep 2003 00:29:28 -0600
> From: Ross Combs <rocombs@cs.nmsu.edu>
> To: jdike@karaya.com
> Subject: 2.4.22-4um race condition
>
> I just sent out a message saying I hadn't noticed any problems from my
> kernel changes.  However, I am now seeing intermittent problems during
> kernel startup.  About 20% of the time on one host the kernel segfaults
> and the exact same binary doesn't fail at all on the other.  I'm using
> tt mode for the moment, but skas3 is also compiled into the UML image.
>
> The message it printed with no ubd0 file were like this:
>   ....
>   unable to open root_fs for validation
>   io_thread - read failed, err = 9
>   Kernel panic: Segfault with no mm
>
> with a filesystem they looked like:
>   ....
>   Partition check:
>    ubda: unknown partition table
>   io_thread - read failed, err = 9
>   Kernel panic: Segfault with no mm
>
> That statement appeared to be coming from ubd_user.c.  I changed the
> printks to show the kernel_fd value:
>   printk("io_thread - read failed, fd = %d, err = %d\n",
>          kernel_fd, -n);
>   ...
>   printk("io_thread - short read, fd =%d, length = %d\n",
>          kernel_fd, n);
>   ...
>   printk("io_thread - write failed, fd = %d, err = %d\n", kernel_fd, -n);
>
> and determined that kernel_fd was -1.  This appears to be the default
> value.  I noticed that in the start_io_thread() routine that kernel_fd
> is ultimately assigned one end of a pipe which is created in the same
> routine... but after the io_thread is started.
>
> What keeps os_read_file() from being called in io_thread() before kernel_fd
> is initialized?  I don't see anything.  I added this test to the read error
> case:
>   if (kernel_fd==-1) /* don't segfault */
>     continue;
> and things seem to be better.  I sometimes get a flurry of errors during
> startup:
>   io_thread - read failed, fd = -1, err = 9
>   io_thread - read failed, fd = -1, err = 9
>   io_thread - read failed, fd = -1, err = 9
>   io_thread - read failed, fd = -1, err = 9
>   io_thread - read failed, fd = -1, err = 9
> but that's all.
>
> So it seems like both failed and short reads should continue.  The continue
> might as well be factored out and put at the end of the if(n != sizeof(req))
> block.
>
> Anyone else seeing this problem?
>
> -Ross
>


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
