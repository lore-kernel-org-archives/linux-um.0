Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Du12N-0001sr-T0	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Jul 2005 21:45:59 -0700
Received: from [67.70.253.242] (helo=localhost.localdomain)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1Du12J-0003UV-6v	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 16 Jul 2005 21:46:00 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Segmentation fault with kernel thread in UML-2.6.7 TT
	mode
References: <001401c58923$f6dee2b0$9eb3c68a@SHZ.ST.COM>
In-Reply-To: <001401c58923$f6dee2b0$9eb3c68a@SHZ.ST.COM>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507152025.01288.blaisorblade@yahoo.it>
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
Date: Fri, 15 Jul 2005 20:25:00 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Alex LIU <alex.liu@st.com>

On Friday 15 July 2005 11:59, Alex LIU wrote:
> Hi,all:

> I just modified the kernel thread function in UML 2.6.7 tt mode. I want the
> kernel thread go to the user space after finished the kernel function
> rather than exit. It's just like a system call return or a return from
> fork...
Hmm, but where's the caller to return? In most cases it won't exist.

I don't understand what's your purpose, and the behaviour you'd want to 
reproduce. Sorry, but *which* userspace should it go to? What you're 
modifying is the execution path of kernel_thread. Now, let's take a call to 
kernel_thread from the initial thread, before init is executed, or a similar 
situation (ksoftirqd and such things must surely be kernel_thread'ed from 
somewhere). Where should it continue? Neither in kernel code because it's now 
hidden (or it should be, anyhow this isn't supposed to work), nor in 
userspace code because no one has been specified.

Now, surely, there are cases where a userspace context will exist. For 
instance, modprobe <some module spawning a kernel thread in initialization>, 
or mount ext3/reiserfs fs. In both cases, the kernel code will spawn a kernel 
thread; but the userspace caller will already have continued with the system 
call return code when the kernel thread exits (or, probably, the caller will 
have died).

> But now the problem is that there will be segmentation fault just before
> the kernel thread go to the user space. After tracing I found when the
> segmentation fault occur, in handle_page_fault function, (!(vma->vm_flags &
> VM_GROWSDOWN)) is true and the err is -14. What's the meaning of such
> value?

Look up in errno headers (/usr/include/asm/errno.h and dependencies). It's 
EFAULT, which makes sense. No userspace program, so no mapping to use and no 
registers to execute.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
