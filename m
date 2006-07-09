Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FzZm9-00051A-PK for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jul 2006 06:56:45 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FzZm7-0006lF-7U
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jul 2006 06:56:45 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 9 Jul 2006 15:56:35 +0200
References: <006401c69c19$eb9edbd0$d4190a0a@centecnetworks.com>
	<20060707004552.GC8756@ccure.user-mode-linux.org>
	<1152238941.13247.67.camel@athena.fprintf.net>
In-Reply-To: <1152238941.13247.67.camel@athena.fprintf.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607091556.35738.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [uml-user] UML 2.6.17 problems (section mismatch,
	get_skas_faultinfo : failed to wait for SIGUSR1/SIGTRAP)
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

On Friday 07 July 2006 04:22, Daniel Gryniewicz wrote:
> On Thu, 2006-07-06 at 20:45 -0400, Jeff Dike wrote:
> > On Sat, Jul 01, 2006 at 08:38:20AM +0800, Miao Qingjun wrote:
> > > 082c90c8 <stub_segv_handler>:
> >
> > ...
> >
> > >  82c9102:       e8 93 ae db ff          call   8083f9a <stub_syscall0>
> >
> > ...
> >
> > >  82c9120:       e8 57 ae db ff          call   8083f7c <stub_syscall2>
> >
> > I guess we should consider a no-O2 compilation to be a case of "it
> > hurts, so don't do it".
> >
> > What happened here is that two functions which absolutely have to be
> > inlined (because this code is mapped into UML processes with no other
> > UML code, so it must be self-contained) weren't.
> >
> > It should be possible to detect O2 or greater optimization and fail
> > the build if it's not there.  But that assumes that we know that
> > non-O2 won't inline stuff, which may not always be true.  Hmmmm
>
> Isn't this what CONFIG_FORCE_INLINING is supposed to do?  Granted, it
> appears to only work for gcc4, but...

There is a better solution - mark those function with __always_inline.

There are two different issues... we must set the attribute force_inline (i.e. 
use __always_inline) to make sure that compilation won't break when 
CONFIG_FORCE_INLINING is used; but with recent enough GCCs, this should also 
allow building without -O altogether.

Currently, even without source code changes someone reported succesful builds 
by simply using -finline, and that can be useful to simplify debug.

Note that not only UML code relies on working inlining;
see for instance this snippet from include/asm-i386/fixmap.h (where 
__always_inline is a recent introduction):

static __always_inline unsigned long fix_to_virt(const unsigned int idx)
{
        /*
         * this branch gets completely eliminated after inlining,
         * except when someone tries to use fixaddr indices in an
         * illegal way. (such as mixing up address types or using
         * out-of-range indices).
         *
         * If it doesn't get removed, the linker will complain
         * loudly with a reasonably clear error message..
         */
        if (idx >= __end_of_fixed_addresses)
                __this_fixmap_does_not_exist();

        return __fix_to_virt(idx);
}

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
