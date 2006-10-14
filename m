Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GYXAQ-0005RD-Cb for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Oct 2006 17:14:20 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GYXAM-00020f-GD
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Oct 2006 17:14:18 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 14 Oct 2006 02:13:55 +0200
References: <20061005213212.17268.7409.stgit@memento.home.lan>
	<20061005213852.17268.13871.stgit@memento.home.lan>
	<20061009180013.GB4931@ccure.user-mode-linux.org>
In-Reply-To: <20061009180013.GB4931@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200610140213.56153.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 06/14] uml: make UML_SETJMP always safe
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
To: Jeff Dike <jdike@addtoit.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Monday 09 October 2006 20:00, Jeff Dike wrote:
> On Thu, Oct 05, 2006 at 11:38:52PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> >
> > If enable is moved by GCC in a register its value may not be preserved
> > after coming back there with longjmp(). So, mark it as volatile to
> > prevent this; this is suggested (it seems) in info gcc, when it talks
> > about -Wuninitialized. I re-read this and it seems to say something
> > different, but I still believe this may be needed.
> >
> > Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> > ---
> >
> >  arch/um/include/longjmp.h |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/um/include/longjmp.h b/arch/um/include/longjmp.h
> > index e93c6d3..e860bc5 100644
> > --- a/arch/um/include/longjmp.h
> > +++ b/arch/um/include/longjmp.h
> > @@ -12,7 +12,8 @@ #define UML_LONGJMP(buf, val) do { \
> >  } while(0)
> >
> >  #define UML_SETJMP(buf) ({ \
> > -	int n, enable;	   \
> > +	int n;	   \
> > +	volatile int enable;	\
> >  	enable = get_signals(); \
> >  	n = setjmp(*buf); \
> >  	if(n != 0) \
>
> I agree with this, but not entirely with your reasoning.  The
> -Wuninitialized documentation just talks about when gcc emits a
> warning.
>
> What we want is a guarantee that enable is not cached in a register,
> but is stored in memory.  What documentation I can find seems to imply
> that is the case ("accesses to volatile objects must have settled
> before the next sequence point").
>
> However, given the prevailing opinion that essentially all volatile
> declarations are hiding bugs, I wouldn't mind a bit of review of this
> from someone holding this opinion.

I agree with that, so I think Al (whom I cc'ed) will be able to evaluate this.
 - however I think that the problem with volatile is that it does not have any 
semantic wrt cache - volatile does not even work with host-to-device 
operation (the thing it was thought for) if you have reasonable caches - 
unless the var is in a MMIO region with disabled caches.

So relying on volatile for variables shared between threads is not useful.

Note that raw_spinlock_t counter is volatile, however - separate caches 
flushes or atomic operations are needed, but it may avoid the need for a full 
barrier() operation or a volatile "memory" clobber - GCC knows only the 
volatile object has changed, while with barrier() it must assume everything 
must be reloaded. However, at least one barrier operation is needed for a 
spinlock to prevent GCC from moving code outside of critical sections.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
