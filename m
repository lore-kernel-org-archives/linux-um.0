Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8l9W-0007vs-Nd for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Sep 2004 12:45:46 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1C8l9V-0007XO-0A
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Sep 2004 12:45:46 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] uml, ptrace, and BKL
Message-ID: <20040918205024.GA3748@ccure.user-mode-linux.org>
References: <Pine.LNX.4.58.0409171920470.1171@gradall.private.brainfood.com>
	<20040918033012.GA1618@ccure.user-mode-linux.org>
	<Pine.LNX.4.58.0409172129180.1171@gradall.private.brainfood.com>
	<20040918131814.GA2942@ccure.user-mode-linux.org>
	<Pine.LNX.4.58.0409181318020.1171@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409181318020.1171@gradall.private.brainfood.com>
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
Date: Sat, 18 Sep 2004 16:50:24 -0400
To: Adam Heath <doogie@brainfood.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Sep 18, 2004 at 01:20:39PM -0500, Adam Heath wrote:
> This is true(and something I hadn't considered).  But with preemption, it's
> possible for multiple threads to be running in the kernel(as I understand it).

That's true in any case.  The difference with preemption is that a thread
can be preempted involuntarily when it's in the kernel.  This doesn't really
change anything with locking, especially the BKL.  That's automatically dropped
when a thread calls schedule(), so that if a thread was preempted while 
holding the BKL, it will drop it during the context switch.

> Same for a preemptible box.

Again, lock contention only really becomes an issue with lots of processors.
So, you may see some contention on a 2P box, but in order for it to be a
real problem, you'll probably need a lot more.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
