Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G0jov-0004Jd-3j for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 11:52:25 -0700
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1G0jop-0006iz-Uy
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 11:52:25 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Wed, 12 Jul 2006 20:52:20 +0200
References: <1152493715.28826.13.camel@athena.fprintf.net>
In-Reply-To: <1152493715.28826.13.camel@athena.fprintf.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607122052.20325.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML fails to build with CONFIG_MK7 set
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

On Monday 10 July 2006 03:08, Daniel Gryniewicz wrote:
> Hi, all.
>
> I got a bug report (http://bugs.gentoo.org/show_bug.cgi?id=138536) about
> UML 2.6.16-bs2 failing to build.  I've checked it out, and it fails to
> build because CONFIG_MK7 is set, which sets CONFIG_X86_USE_3DNOW, which
> causes asm/arch/string.h to pull in asm/mmx.h, which doesn't exist
> (because it's in asm/arch/mxx.h, this being UML).  The obvious solution
> is to symlink it in, but this raises another question:

Does it compile then? I tried at the time (it wasn't K7 but another setting 
giving the same error) but I recall it didn't work because it needed further 
work (and part of the content wasn't valid for i386).

In fact it was me to introduce this and to try to fix this exact problem, but 
I've not found an easy way and I then discarded it.
> How useful are the various arch settings when building UML?  Does it
> actually make a difference if I build with K7 rather than i686?

It makes difference for optimization flags (I think -march and not -mtune, but 
I may forget), and for infos on the processor (arch/i386/Kconfig.cpu sets the 
cacheline size and other info from the processor setting).
Quite frankly, the best solution would be to make i386 headers avoid using MMX 
since it doesn't compile in UML (or to fix them).

The best temporary solution would be to mark as working only the choices which 
actually do, and block them for UML (not for i386, and the code is shared - 
it suffices a dependency on !UML in the appropriate Kconfig). And it's a 
shame I didn't do this already. I hope to work on this on the weekend but 
it's a bit difficult.

> If so, 
> this should probably be fixed.  If not, the options to select ARCHES
> should probably be removed when configuring UML.

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
