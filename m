Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CoGCC-00065R-7Q for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 23:12:04 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CoGCB-0004GE-Jy
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 23:12:04 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] How stable is hostfs (and UML in general)?
References: <200501082106.38306.rob@landley.net>
	<200501091706.58778.rob@landley.net>
	<200501101543.26588.blaisorblade@yahoo.it>
In-Reply-To: <200501101543.26588.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501110110.42826.rob@landley.net>
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
Date: Tue, 11 Jan 2005 01:10:42 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Frank Sorenson <frank@tuxrocks.com>

On Monday 10 January 2005 09:43 am, Blaisorblade wrote:

> I also think that if the system is idle, Linux could write out the datas
> anyway (I don't know this well, but it's reasonable that the data are
> sync'd after enough time).
>
> Now, your question reduces to only this one:
>
> "Will Linux, without memory pressure but with CPU / disk pressure, start
> the cache writeout or not? "
> At this point, I don't know

There was some discussion of this on linux-kernel a few years back.  That's 
where I first heard about it.  There was an optimization in the linux kernel 
for this, but whether they were arguing to preserve the optimization or 
whether they were arguing to rip it out now that shm was in there, I don't 
remember...

> > I know.  But once again, I'm tryng to use UML in hopes of being more
> > portable and doing without root access.  Patching the kernel defeats the
> > point entirely, I might as well just tell people "you'll need to boot
> > 2.6.10 to build this, and it needs to be run as root".
> >
> > I'm more interested in correctness than performance at the moment.  As
> > long as it WORKS, they can leave it running overnight for now...
>
> Well, be careful... using TT mode can mean experiencing more UML bugs.

I've noticed. :)

On the other hand, I have a honking big test script to exercise it and a 
comparison case with stable behavior, and I'm happy to isolate differences 
between the two.  I'll even happily attempt fixing them, which is not the 
same as knowing what I'm doing but when have I ever let that stop me?

> > It
> > seems unlikely knoppix would waste space on a second copy of libc for any
> > other reason...
>
> Well, the 1st copy on glibc runs with any kernel (2.4 and 2.6) and uses
> LinuxThreads for threading support.
>
> The 2nd copy, the one in /lib/tls, requires a 2.6 kernel, uses NPTL for
> threading support, and can give problems to some apps (including sometimes
> UML - but to get those problems, you need to link UML dinamically, while
> when TT mode is active it will link statically, and usually static link is
> done against non-NPTL glibc).
>
> Note:
> TLS = Thread Local Storage (one var, with TLS, can have a different value
> for each thread)
> NPTL = Next Generation Posix Threading.

Ah, that makes sense.  NTPL, futexes, and all Ingo's new 2.6 threading work.  
(Various people keep threatening to glue NTPL to uclibc if we ever actually 
have another release.  I still need to send Eric a cake for the one year 
anniversary of 0.9.26.)  And knoppix is still going through a 2.4 kernel/2.6 
kernel identity crisis, hence two libraries.  Got it.

(I also have a suse test environment on another machine, and upstairs there's 
an old fedora core I install, but right now I'm just trying to get it all to 
work on my laptop...)

Rob


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
