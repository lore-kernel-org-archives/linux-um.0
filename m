Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DuAcn-0006wA-NJ	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 Jul 2005 08:00:13 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1DuAcl-0003Hu-I9	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 Jul 2005 08:00:14 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Segmentation fault with kernel thread in UML-2.6.7 TT
	mode
Message-ID: <20050717140928.GA6519@ccure.user-mode-linux.org>
References: <200507152025.01288.blaisorblade@yahoo.it>
	<000901c58aa4$86288800$9eb3c68a@SHZ.ST.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000901c58aa4$86288800$9eb3c68a@SHZ.ST.COM>
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
Date: Sun, 17 Jul 2005 10:09:28 -0400
To: Alex LIU <alex.liu@st.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Jul 17, 2005 at 03:52:46PM +0800, Alex LIU wrote:
> In fact I want to port Bproc to UML. Now Bproc is based on i386. And
> a part of the main work Bproc does is about the kernel thread...Bproc
> create a new kernel thread function with the name bproc_kernel_thread
> in i386 and let the Bproc kernel thread go to the user space rather
> than exit. 

What does it run when it enters userspace?  The only other thing I can
think of which does this is the kernel thread that turns into init,
which it does by calling exec.

> In UML,I found in finish_fork_handler, set_user_mode is called at
> last. I think it's purpose is to let the new forked process go to
> the user space like ret_from_fork in i386. 

If you look at its implementation, you'll see that it is very tt-mode 
specific, and thus can't do something as basic as re-entering
userspace in a generic way.

If you are entering userspace, you need for there to be something
there to enter.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
