Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cctkh-0000Ll-PU for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Dec 2004 15:00:43 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Cctkg-0004Y2-HL
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 10 Dec 2004 15:00:43 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: SKAS4 future and present (was: Re: [uml-devel] Merging some of
	your patches)
Message-ID: <20041210224610.GA28982@bytesex>
References: <200411301945.07814.blaisorblade_spam@yahoo.it>
	<200412040458.38846.blaisorblade_spam@yahoo.it>
	<20041207120349.GC21667@bytesex>
	<200412101951.14321.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412101951.14321.blaisorblade_spam@yahoo.it>
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
Date: Fri, 10 Dec 2004 23:46:11 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

> > I also don't want to wait one more year.  But if there is a chance to
> > get skas4 work within a more reasonable time frame I'd prefeare that
> > route.
> 
> When I get to work on Bodo's improvements to SYSEMU (on which I have some 
> doubts I already posted) I'll also try adding that... UML must already handle 
> some others similar "API-extensions", including probably 
> PTRACE_SYSEMU_SINGLESTEP (or another kind of idea).

Found a old x86_64 patch (2.6.4) with some skas4 stuff (uml kernel code
only, but hey, more than nothing ...) on my hard disk.  skas4 needs
ptrace(FAULTINFO) as well, looks like this there:

	 struct ptrace_faultinfo {
	        int is_write;
	        unsigned long addr;
	+       unsigned long trap_no;
	+       unsigned long error_code;
	 };

So it probably doesn't make a big difference maintainance-wise whenever
we'll put that in _now_ as FAULTINFO_NEW or wait for skas4 as skas4 will
use the very same thing ...

> > This never being discussed is the first problem.
> 
> "Release often - release earlier" is important.

Full agree ...

> Also, while in that discussion, Linus proposed that API, it does not
> mean that if we implement that exact API, it gets accepted by everyone
> without concerns. We should get into this mindview...

... and thats one of the reasons.  I think the only way to avoid that is
to discuss the design ideas early.  It doesn't need to be the perfect
patch for that.

The 2.6.4 x86_64 patch looks like Jeff tried two approachs:

First being (IIRC the original thing suggested by Linus) a new syscall
which returns a file descriptor refering to the mm, a syscall for
executing mmap() operations on a mm using the fd refering to it.  Switch
processes via ptrace(SWITCH_MM) like skas3 does.

Second being one host process per uml process, ptrace(SWITCH_MM) not
being needed any more, current->mm not being modified any more, the
syscall for changing mappings of another processes takes the pid not
a fd as argument.

The second approach looks much better to me.  This way it likely also is
easier to make tls+nptl work within uml, it will probably also simplify
any personality issues on amd64.  As the host kernel side is missing
it's not clear how this makes sure that you can't change the mappings
of random processes in the second approach.  With the first approach
this is easy, only the creator of a new mm can change mapping therein
because you need the file handle for that.

Jeff, any comment what the current status is?  Maybe also a URL to
current patches?

> Probably, in SuSE there is someone who knows better (don't know if
> Andrea Arcangeli will ever care, but it would be nice)... since you
> include SKAS in your kernel, getting it reliable is interesting also
> for you all in SuSE.

Andrea looked into skas some time ago and didn't like the way mm
switching is done very much.  Havn't heared anything recently through,
asking him for comments and then go over the skas patches is on my (way
too long) todo list through.

He probably could also give some useful comments on the skas4 design.

> > [ split sysemu + skas ]
> However, the -bb patchset offers exactly that!

Great, I'll have a look.

> UML); also I didn't CC Roland McGrath, the ptrace maintainer.

Roland McGrath seems to be a busy guy as well, Cc:'ing him probably
is a good idea to make sure he will see the mail.

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
