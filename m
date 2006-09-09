Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GLzBm-0003Xk-R3 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Sep 2006 02:31:50 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GLzBi-0002bF-0W
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Sep 2006 02:31:50 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 9 Sep 2006 11:31:36 +0200
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk>
	<200503132106.35599.blaisorblade@yahoo.it>
	<EBD0B8CF381E8B44BB99E8EA137E27C0021AD010@CPEXBE-EML06.kpnsp.local>
In-Reply-To: <EBD0B8CF381E8B44BB99E8EA137E27C0021AD010@CPEXBE-EML06.kpnsp.local>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609091131.36909.blaisorblade@yahoo.it>
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
To: i.r.wezeman@hetnet.nl
Cc: Jeff Dike <jdike@addtoit.com>, Anton Altaparmakov <aia21@cam.ac.uk>, user-mode-linux-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>

On Saturday 09 September 2006 00:25, i.r.wezeman@hetnet.nl wrote:
> Hi there.
> 
> I got a error undefined reference to `__bb_init_func' when
> compiling uml with kernel 2.6.17.6, gcc 4.1.1 and glibc-2.4

Ok, that's new. The below mail is about a very similar problem but with an 
older Gcc, and since these symbols are provided by gcc, this makes a 
difference.

Try removing from arch/um/kernel/gmon_syms.c these 2 lines:

extern void __bb_init_func(void *);
EXPORT_SYMBOL(__bb_init_func);

and recompiling. Better yet, try if adding the weak attribute like below fixes 
the problem:

extern void __bb_init_func(void *) __attribute__((weak));
EXPORT_SYMBOL(__bb_init_func);

Another possible thing to check is what happens with CONFIG_STATIC_LINK=y 
(edit it by hand and do not enable GPROF for now, that is yet another thing).

> Done: make clean && make distclean && make allmodconfig ARCH=um

> # CONFIG_GPROF is not set
> CONFIG_GCOV=y

This results from allmodconfig? Mmpf, that is not so nice (allmodconfig should 
not result in a debug kernel). Even if allmodconfig is not a _smart_ setting 
(set to y or m everything).

> #
> # UML-specific options
> #
> # CONFIG_MODE_TT is not set
> # CONFIG_STATIC_LINK is not set
> CONFIG_MODE_SKAS=y

> Build: make linux ARCH=um
> 
> 
> edit file: uml/arch/um/os-Linux/sys-i386/registers.c

> Ending:
> 
> arch/um/kernel/built-in.o:(__ksymtab+0x238): undefined reference to
> `__bb_init_func'
> arch/um/os-Linux/built-in.o: In function `do_syscall_stub':
> arch/um/os-Linux/skas/mem.c:63: undefined reference to
> `get_safe_registers'
> arch/um/os-Linux/built-in.o: In function `copy_context_skas0':
> arch/um/os-Linux/skas/process.c:333: undefined reference to
> `get_safe_registers'

Since it arrives to this point, get_safe_register should be undefined only 
because of the previous failure.

> I see it must be solved. So wat is happend now?
> 
> Ron Wezeman
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
