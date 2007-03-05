Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOMDT-0003bu-1Y for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 15:03:39 -0800
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HOMDR-0004jE-Cg
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 15:03:38 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 6 Mar 2007 00:03:26 +0100
References: <20070131224504.GA7698@ccure.user-mode-linux.org>
	<200702021848.40114.blaisorblade@yahoo.it>
	<20070202201230.GA8533@ccure.user-mode-linux.org>
In-Reply-To: <20070202201230.GA8533@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200703060003.26856.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] x86_64 32-bit ptrace mangles sixth system
	call argument
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Friday 02 February 2007 21:12, Jeff Dike wrote:
> On Fri, Feb 02, 2007 at 06:48:39PM +0100, Blaisorblade wrote:
> > Is this a recent regression or did this always happen?
>
> I haven't looked at the history of the code, but it has the look of
> something that's been there a long time.
>
> > Is this the bug diagnosed by Bodo Stroesser time ago, or only it looks
> > similar? I recall vaguely that in that bug RCX was corrupted.
>
> No, RCX corruption is different - that happens when a sysexit is done
> from a system call where userspace wasn't prepared to save and restore
> RCX.  sigreturn is the best example.

Hmm... we should finally fix that, at some point. Or... now that you explain 
it this way, it could even seem unfixable... is it? Or maybe sysreturn should 
become a syscall where the return must happen through the slow return path 
(iret), if that exists for x86_64.

> > Above all, how can UML run in SKAS0 mode with this bug (if it can)?
>
> The impact is limited by several things -
> 	it must be a 32-bit UML on a 64-bit host
> 	the system call must have 6 arguments - mmap and pselect are
> the only 6-argument system calls that I can find quickly
> 	the system call must be made through sysenter - int 0x80 is
> fine
>
> But, a 32-bit UML making mmap calls through sysenter indeed does not run
> very well.

Has this been fixed? I've read that Chuck Ebbert had already fixed this in 
your diary, but not sent the patch.

I'd open an entry in bugzilla for this sort of things. It also seems that 
Jason Lunz's patch about max_low_pfn is not even in your tree, and that the 
x86_64 PTRACE_OLDSETOPTIONS fix is not yet in the main git tree. Hmm....

And the udelay() fixes didn't get merged, in the end. Bah, I need more time!

-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
