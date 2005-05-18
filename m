Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYOzQ-0003JS-MT	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 06:53:36 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DYOzP-0004yt-RC	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 06:53:36 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Question about the kernel thread in UML TT mode
Message-ID: <20050518133128.GA3925@ccure.user-mode-linux.org>
References: <20050517155357.GA5872@ccure.user-mode-linux.org>
	<000e01c55b91$039466d0$9eb3c68a@SHZ.ST.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000e01c55b91$039466d0$9eb3c68a@SHZ.ST.COM>
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
Date: Wed, 18 May 2005 09:31:28 -0400
To: Alex LIU <alex.liu@st.com>
Cc: 'UML-dev' <user-mode-linux-devel@lists.sourceforge.net>

On Wed, May 18, 2005 at 06:04:31PM +0800, Alex LIU wrote:
> But P and Q are different threads and they will be scheduled
> differently,right?

No, they're two different ways of looking at the same thread.  They're 
scheduled somewhat differently, but that's just reflecting the two ways
of looking at it.  If it's runnable on the host, it's runnable inside UML,
but not the other way around.

> Another question:
> when a kernel thread is created in UML, in the function outer_tramp the temp
> thread A will clone the corresponding host thread B and then wait for it to
> stop. The code is following:
> 
> 	t->pid = clone(t->tramp, (void *) t->temp_stack + page_size()/2,
> 		       t->flags, t->tramp_data);
> 	if(t->pid > 0) wait_for_stop(t->pid, SIGSTOP, PTRACE_CONT, NULL);
> 
> And once the host thread B is created it will run new_thread_proc,in the
> function the thread send the signal SIGUSR1 to itself:
> 
> 	os_usr1_process(os_getpid());
> 	change_sig(SIGUSR1, 1);
> 	return(0);
> 
> But I found the thread B will be blocked in the function change_sig(SIGUSR1,
> 1). Why?

It's not blocked there.  That makes it enter the SIGUSR1 handler, which puts
it on its kernel stack.

> And in the function outer_tramp, the thread A see the thread B was stopped
> with a SIGSTOP signal. Why? Since the thread B is blocked by the signal
> SIGUSR1...

The handler calls suspend_new_thread, which stops itself.

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
