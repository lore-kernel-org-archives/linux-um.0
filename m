Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdRgp-0006tD-7D for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 02:10:27 -0800
Received: from mx2.elte.hu ([157.181.151.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AdRgo-0006e2-QR for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Jan 2004 02:10:27 -0800
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [uml-devel] [UML combo patch] uml-combo-2.6.0-A7
Message-ID: <20040105101117.GA23694@elte.hu>
References: <Pine.LNX.4.58.0312171735540.8123@earth>
	<Pine.LNX.4.58.0312181304250.3617@earth>
	<20040101191630.GA23954@elte.hu>
	<200401021929.54997.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401021929.54997.blaisorblade_spam@yahoo.it>
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
Date: Mon, 5 Jan 2004 11:11:17 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

* BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:

> > plus fixed a bug in
> > the __do_mmap_pgoff() change that caused host kernel bootup hangs.
> 
> Yes, I did experience problems with my guest kernel (and today I
> tracked it down to the E* patches), but I didn't know what it is...
> Aargh! A missing return! Ok, I'm too foolish. Thanks for finding it!
> (But why the hell GCC 3.2.2 doesn't warn about it?)

yeah, interesting question. I tried a (very) fresh gcc snapshot too and
it doesnt warn either. Ironically, the only compiler that warned about
this was gcc296. (hah!) I filed a gcc bugreport.

> Two questions:
> 1) I've added the G-03(this fixes the empty /proc/kallsyms issue), H-03 and 
> H-04(for Makefiles cleanups) patches. Would you try them?

i'll try these too. Your bugfixes/collections are now perfectly fine for
2.6.0 UML experimentation so i'll use them instead of spinning my own
ones. (your ones are also better split up.)

> 2)Have you given a look to the mm/memory.c change (what I'd split into
> A-04)?  Do you think that change can be safe even for the host kernel?

tricky stuff - hand-building vmas is fragile like hell, and the vsyscall
stuff is far from simple too. What is the main purpose of your change?

	Ingo


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
