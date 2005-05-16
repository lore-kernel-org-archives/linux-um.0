Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXhGI-0001kG-Oi	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 08:12:06 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DXhGH-0007kc-4l	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 08:12:06 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] The UML scheduler
Message-ID: <20050516150648.GB4977@ccure.user-mode-linux.org>
References: <3524bf1f05051607306756dcfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3524bf1f05051607306756dcfc@mail.gmail.com>
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
Date: Mon, 16 May 2005 11:06:48 -0400
To: Young Koh <young.koh@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, May 16, 2005 at 10:30:33AM -0400, Young Koh wrote:
> suppose there are 2 processes on top of UML and 3 host processes.
> then, the host kernel sees 5 processes total, so, each of the process
> will get 20% of the CPU time? is that right?

In tt mode, there will be 5 processes, but it will be difficult for the 2 UML
processes to each get 20% of the time, since only one of them will be runnable
at a time on the host.  This is still unfair because each of them will have
a higher dynamic priority than the 3 host processes because they are each only
runnable half the time.

In skas mode, there is only one host process for all of the UML processes.

> Or, UML is somehow viewed as a group of processes and UML get 25% of
> the CPU and each UML got 12.5% of the CPU time? if so, how is it
> possible?

In skas mode, this is true.

> one more question, when the UML kernel wants to schedule its
> processes, how does it preempt UML processes?

The same way as any other architecture.  A timer tick comes in, and the 
timer handler calls schedule().

> this way of scheduling and preemption will be different from TT mode
> and SKAS mode? if so, how?

No, exactly the same.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
