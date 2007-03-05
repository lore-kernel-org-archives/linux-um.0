Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOMaB-00064d-UG for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 15:27:08 -0800
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HOMa8-0001nj-7l
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 15:27:07 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Tue, 6 Mar 2007 00:26:53 +0100
References: <20070131224504.GA7698@ccure.user-mode-linux.org>
	<200703060003.26856.blaisorblade@yahoo.it>
	<20070305231044.GB9525@ccure.user-mode-linux.org>
In-Reply-To: <20070305231044.GB9525@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200703060026.53253.blaisorblade@yahoo.it>
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

On Tuesday 06 March 2007 00:10, Jeff Dike wrote:
> On Tue, Mar 06, 2007 at 12:03:26AM +0100, Blaisorblade wrote:
> > > No, RCX corruption is different - that happens when a sysexit is done
> > > from a system call where userspace wasn't prepared to save and restore
> > > RCX.  sigreturn is the best example.

> > Hmm... we should finally fix that, at some point. Or... now that you
> > explain it this way, it could even seem unfixable... is it? Or maybe
> > sysreturn should become a syscall where the return must happen through
> > the slow return path (iret), if that exists for x86_64.

> This is fixed, and has been for a while.  The fix was, as you suggest,
> return through iret in this case.

Also the 32bit emulation case? That would be interesting for SKAS with 64bit 
host and 32bit guest (which I haven't tested for a long time). Also this 
means that I could test the needed trivial fixes for 64 on 64 (like 
opening /proc/mm64, using PTRACE_EX_FAULTINFO which I introduced...).
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
