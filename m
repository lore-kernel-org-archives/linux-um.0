Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JXgLw-0004S8-8H for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Mar 2008 09:27:28 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JXgLu-0006tY-Og
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Mar 2008 09:27:28 -0800
Date: Fri, 7 Mar 2008 12:27:19 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080307172719.GF9139@c2.user-mode-linux.org>
References: <88e04e60802281528j302b61bbv2780c23f2614e8cd@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <88e04e60802281528j302b61bbv2780c23f2614e8cd@mail.gmail.com>
Subject: Re: [uml-devel] questions about mconsole driver and process	address
	space
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Weiming Liu <runemass.cse@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Feb 28, 2008 at 06:28:53PM -0500, Weiming Liu wrote:
> Hi. I am doing some experiment on mconsole driver. My wish is to create a
> new user process from mconsole driver, modifying its address space, changing
> its file mapping... Eventually may be I can migrate a process from host or
> between UML instances. I am a newbie to both kernel and UML, and I have
> several questions on implementation:
> 
> 1. create a new process from a kernel thread. It seems that mconsole uses a
> work queque, and requests are processed at kevents thread. Right now what I
> am doing is, creating a new kernel thread and letting it call sys_ececve().
> I then find its task_struct by looking for its name and its parent. It seems
> stupid and maybe not correct. Is there any better way to do this?

Use a completion:

In the parent, do
   DECLARE_COMPLETION(c)
   kernel_thread()
   wait_for_completion(&c)
   child_task = my_task;

In the child, do
   my_task = current;
   complete(&c);

You'll also want to wrap a semaphore around the whole thing.

> 2. I need to manipulate the process' address space (memory segments, file
> mappings) like what flush_old_exec() and do_mmap() are doing. I cannot find
> a way to call those functions since I am in a kernel thread, and it seems
> too complicated by working directly on page tables and memory. How can this
> be done in a convenient way?

There are helpers for all these things.

      	  	      Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
