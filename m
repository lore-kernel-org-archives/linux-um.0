Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HQi03-0002CR-42 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Mar 2007 03:43:45 -0700
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HQhzz-0005Vt-SD
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 12 Mar 2007 03:43:30 -0700
Message-ID: <45F52EA7.2090605@fujitsu-siemens.com>
Date: Mon, 12 Mar 2007 11:42:47 +0100
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <200703092250.48861.blaisorblade@yahoo.it>
In-Reply-To: <200703092250.48861.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] x86_64 32-bit ptrace mangles sixth
	systemcall argument
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
Cc: Jeff Dike <jdike@addtoit.com>, Andi Kleen <ak@suse.de>, user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> On Tuesday 06 March 2007 00:26, Blaisorblade wrote:
>  > On Tuesday 06 March 2007 00:10, Jeff Dike wrote:
>  > > On Tue, Mar 06, 2007 at 12:03:26AM +0100, Blaisorblade wrote:
>  > > > > No, RCX corruption is different - that happens when a sysexit 
> is done
>  > > > > from a system call where userspace wasn't prepared to save and
>  > > > > restore RCX.  sigreturn is the best example.
>  > > >
>  > > > Hmm... we should finally fix that, at some point. Or... now that you
>  > > > explain it this way, it could even seem unfixable... is it? Or maybe
>  > > > sysreturn should become a syscall where the return must happen 
> through
>  > > > the slow return path (iret), if that exists for x86_64.
>  > >
>  > > This is fixed, and has been for a while.  The fix was, as you suggest,
>  > > return through iret in this case.
> 
> Hmm, return through IRET is implemented for sys_rt_sigreturn since 2.6.0 
> (with
> a couple of changes, yeah, but...).
> 
> Was the original Bodo's report bogus? No, he actually found a much harder
> issue.
> 
> I've attached the log of that IRC here for reference.
> 
I took a quick look into 2.6.21-rc3, arch/x86_64/entry.S. AFAICS, the problem
I supposed in the IRC is fixed. Now a ptraced syscall always returns through
IRET. Thus, *all* registers in user space exactly will have the contents,
which the tracing process wrote at end of syscall.

Bodo

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
