Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HbpEu-0007L0-Ib for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Apr 2007 19:40:48 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HbpEu-0003WL-3k
	for User-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Apr 2007 19:40:48 -0700
Date: Wed, 11 Apr 2007 22:35:35 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070412023535.GA18095@c2.user-mode-linux.org>
References: <3aab51dc0704111910p54a3066aref3663180003d671@mail.gmail.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3aab51dc0704111910p54a3066aref3663180003d671@mail.gmail.com>
Subject: Re: [uml-devel] Question about trap handling in UML kernel
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Haifeng He <hehaifeng@gmail.com>
Cc: User-mode-linux-devel@lists.sourceforge.net

On Wed, Apr 11, 2007 at 07:10:36PM -0700, Haifeng He wrote:

> I have a question about trap handling in UML kernel, particularly in the
> skas0 mode.
> My understanding is that, UML will fork a kernel thread for each user
> process

UML will fork a host process for each UML address space.

> and
> this thread will go to a loop (in userspace()) and wait for signal from user
> process using
> ptrace. If a signal occurs, it will call the signal handler to handle the
> interrupt.
> Is it correct?

Yes.

> My second question is, how many kernel threads are there in skas0 mode or I
> should
> ask how many different kinds of kernel threads will be created? Is there any
> kernel thread
> in UML other than those created for user process?

There are these kinds, assuming you mean host threads -
	kernel process, runs kernel code - one per virtual CPU
	user process, runs userspace code, one per address space
	utility threads, things that are useful to have in separate
threads, like the I/O thread and SIGIO thread.

> My last question is, given a kernel thread, if it is possible that the
> execution of a thread will
> be interrupted by others other than by scheduler?

If I understand the question, no.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
