Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRaqr-0004D2-B0 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 10:36:21 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CRaqo-0006G9-Hy
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 10:36:20 -0800
Message-Id: <200411092048.iA9Kmjg9004223@ccure.user-mode-linux.org>
Subject: Re: Synchronization primitives in UML (was: Re: [uml-devel] Re:
	[patch 09/20] uml: use SIG_IGN for empty sighandler) 
In-Reply-To: Your message of "Tue, 09 Nov 2004 18:44:35 +0100."
	<200411091844.44218.blaisorblade_spam@yahoo.it> 
References: <200411052036.55541.blaisorblade_spam@yahoo.it>
	<20041106051306.GA3038@ccure.user-mode-linux.org>
	<200411091844.44218.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Tue, 09 Nov 2004 15:48:45 -0500
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, cw@f00f.org

blaisorblade_spam@yahoo.it said:
> I also understand now what all this is for. When I have time for this,
> I'll at  least copy and paste your mail into a comment, with any
> needed adjustment.

That would be a good idea.

> For the semaphore issue, I have some ideas (like using futexes) which
> need to  be developed a bit:

> 1) I want to create a semaphore API in os_*. 
> 2) It will be able to use socketpairs. 
> 3) It will be able to use futexes, if they are
> non-persistant and usable  without too much issues (the same way we
> are going to support Async I/O). 
> 4) It will be used first by the code
> which could really benefit from the  performance increase.
> 5) It won't
> use persistant objects.

This all sounds good, although there are simplicity benefits to just using
one underlying mechanism, as long as there are no overriding disadvantages
to it.

> Any comment on these issues? Also, apart TT context switching, is
> there any  other performance-sensitive use of semaphores, which would
> benefit from using  futexes? 

Offhand, I think context switching is the most sensitive one.

> Yes, semget and friends are uglier.
> But don't think that the current nested code is simple to read - three
>  semaphores at a time, without a clear name, are not the clearer code
> on the  world. 

What nested code are you talking about?

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
