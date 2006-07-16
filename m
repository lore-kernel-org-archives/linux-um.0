Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G2CET-0005Wv-Ck for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 16 Jul 2006 12:24:49 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1G2CEP-0002eT-IP
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 16 Jul 2006 12:24:49 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 16 Jul 2006 21:24:36 +0200
References: <20060715152343.GA12263@var.cx>
	<200607161231.51516.blaisorblade@yahoo.it>
	<20060716120531.GA20515@var.cx>
In-Reply-To: <20060716120531.GA20515@var.cx>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607162124.36818.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] cap-bound not working in uml
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
To: Frank v Waveren <fvw.uml@var.cx>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sunday 16 July 2006 14:05, Frank v Waveren wrote:
> On Sun, Jul 16, 2006 at 12:31:51PM +0200, Blaisorblade wrote:
> > On Saturday 15 July 2006 17:23, Frank v Waveren wrote:
> > > I was trying to limit some unecessary capabilities in a UML instance
> > > with /proc/sys/kernel/cap-bound, but it turned out not to take.
> >
> > To remove capabilities from the whole system (i.e. all processes) the
> > recommended way wasn't to use lcap (or a similar program bundled with
> > libcap)?
>
> Yup, lcap is just an interface to /proc/sys/kernel/cap-bound.

I remember maybe some differences UML specific capabilities code in arch/um 
(it used to clear some capabilities, i.e. /dev/mem or /dev/kmem access). 
Check for that...

> > > The source of the problem (or at least something a bit of the way up
> > > the garden path of the problem) is at security/commoncap.c:140 at the
> > > top of cap_bprm_apply_creds(bprm, unsafe):
> > >
> > >    void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
> > >    {
> > >            /* Derived from fs/exec.c:compute_creds. */
> > >            kernel_cap_t new_permitted, working;
> > >
> > >            new_permitted = cap_intersect (bprm->cap_permitted,
> > > cap_bset); working = cap_intersect (bprm->cap_inheritable,
> > >                                     current->cap_inheritable);
> > >            new_permitted = cap_combine (new_permitted, working);
> > >            ...
> > >
> > > Here the new permitted set gets limited to the bits in cap_bset, which
> > > is as it should be, but then the intersection of the of the current
> > > and exec inheritable masks get added to that set, whereas as I
> > > understand it, cap_bset should always be the bounding set.
> > >
> > > I've tried commenting out that bit and everything worked as I'd hoped
> > > (I haven't done extensive testing, but bounding the caps worked, as
> > > did suids and such).
> > >
> > > That doesn't explain why it works with those lines left in on a
> > > non-UML kernel though, so I assume I'm missing something fundamental.
> > >
> > > (My guest kernel is
> > >   Linux version 2.6.16.24 (fvw@jupiter.var.cx) (gcc version 4.0.3
> > > 20051201 (prerelease) (Debian 4.0.2-5)) #3 Sat Jul 15 16:54:20 CEST
> > > 2006 , should it matter)

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
