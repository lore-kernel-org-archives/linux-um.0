Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DY4t9-0000kB-Vh	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 09:25:47 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DY4t8-0000v2-Cj	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 09:25:47 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Question about the kernel thread in UML TT mode
Message-ID: <20050517155357.GA5872@ccure.user-mode-linux.org>
References: <006101c55ac4$2ccbf0e0$9eb3c68a@SHZ.ST.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006101c55ac4$2ccbf0e0$9eb3c68a@SHZ.ST.COM>
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
Date: Tue, 17 May 2005 11:53:57 -0400
To: Alex LIU <alex.liu@st.com>
Cc: UML-dev <user-mode-linux-devel@lists.sourceforge.net>

On Tue, May 17, 2005 at 05:38:21PM +0800, Alex LIU wrote:
> In UML,when do_fork was called,the new process P will be created in UML. Then in copy_thread_tt(in fact in start_fork_tramp)the corresponding process Q will be created in the host linux. I know the pid of the corresponding host process Q is appointed as the extern_pid of the UML process P. But then how will the 2 processes do next individually?

They aren't really two processes.  But they set up signal handlers, and the 
timer, and then go to sleep until that process is scheduled.

> In UML,the function copy_thread_tt call start_fork_tramp, which cloned a thread. Once the thread was created it will run the outer_tramp function,in which cloned another thread. Once the second thread was created it will run the tramp function(fork_tramp or new_thread_proc). In fact the first thread is a temp one.it will kill itself later.Then why does UML clone 2 threads in copy_thread_tt?

To avoid zombies - the parent process is expected to reap exited children,
but as far as UML is concerned, the parent may not wake up for along time,
leaving the child as a zombie for an arbitrary time.

The two threads are the double-fork trick.  The parent of the new process
is the first temporary thread, which exits immediately, leaving the new child
to be inherited by init, which will reap children immediately, eliminating 
zombies.

> In UML,when the kernel_thread was called,the UML kernel thread P will be created in copy_process. And the corresponding host thread Q will be create in copy_thread_tt. Then the host thread Q will run its SIGUSR1 signal handler new_thread_handler,which will call run_kernel_thread function and exited at last. But I think it should be the UML kernel thread P that call run_kernel_thread function, any problems? 

P and Q are the same thing, so it makes no sense to say the handler should be
run in one rather than the other.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
