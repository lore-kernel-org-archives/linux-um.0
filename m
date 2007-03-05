Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOMSo-0005D8-M3 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 15:19:30 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HOMSn-0008SJ-0d
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 15:19:30 -0800
Date: Mon, 5 Mar 2007 18:10:44 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070305231044.GB9525@ccure.user-mode-linux.org>
References: <20070131224504.GA7698@ccure.user-mode-linux.org>
	<200702021848.40114.blaisorblade@yahoo.it>
	<20070202201230.GA8533@ccure.user-mode-linux.org>
	<200703060003.26856.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200703060003.26856.blaisorblade@yahoo.it>
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Mar 06, 2007 at 12:03:26AM +0100, Blaisorblade wrote:
> > No, RCX corruption is different - that happens when a sysexit is done
> > from a system call where userspace wasn't prepared to save and restore
> > RCX.  sigreturn is the best example.
> 
> Hmm... we should finally fix that, at some point. Or... now that you explain 
> it this way, it could even seem unfixable... is it? Or maybe sysreturn should
> become a syscall where the return must happen through the slow return path 
> (iret), if that exists for x86_64.

This is fixed, and has been for a while.  The fix was, as you suggest, return
through iret in this case.

> > But, a 32-bit UML making mmap calls through sysenter indeed does not run
> > very well.
> 
> Has this been fixed? I've read that Chuck Ebbert had already fixed this in 
> your diary, but not sent the patch.

Yup, and I'm going to resurrect that patch.

> I'd open an entry in bugzilla for this sort of things. It also seems that 
> Jason Lunz's patch about max_low_pfn is not even in your tree

It is, I just haven't updated the site with it yet.

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
