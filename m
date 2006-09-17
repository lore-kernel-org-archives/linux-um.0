Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GP10s-0001aY-U1 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 Sep 2006 11:05:06 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GP10o-0003CL-QD
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 Sep 2006 11:05:06 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 17 Sep 2006 20:04:20 +0200
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk>
	<200609091131.36909.blaisorblade@yahoo.it>
	<20060911152739.GA4443@ccure.user-mode-linux.org>
In-Reply-To: <20060911152739.GA4443@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609172004.21083.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Partial fix! - Was: Re: [BUG report] UML linux-2.6
	latest BK doesn't compile
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 11 September 2006 17:27, Jeff Dike wrote:
> On Sat, Sep 09, 2006 at 11:31:36AM +0200, Blaisorblade wrote:
> > On Saturday 09 September 2006 00:25, i.r.wezeman@hetnet.nl wrote:
> > > Hi there.
> > >
> > > I got a error undefined reference to `__bb_init_func' when
> > > compiling uml with kernel 2.6.17.6, gcc 4.1.1 and glibc-2.4
>
> Happens to me with -rc6.
>
> > Try removing from arch/um/kernel/gmon_syms.c these 2 lines:
> >
> > extern void __bb_init_func(void *);
> > EXPORT_SYMBOL(__bb_init_func);
>
> And this seems to fix it.
>
> > Better yet, try if adding the weak attribute like below fixes
> > the problem:
> >
> > extern void __bb_init_func(void *) __attribute__((weak));
> > EXPORT_SYMBOL(__bb_init_func);
>
> And this fixes it even better.

Ok, I expect you to send the final patch, thanks... it should go for 2.6.18 
possibly, and since you tested it you have it almost ready.

Bye bye
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
