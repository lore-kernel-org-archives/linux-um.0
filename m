Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GM4md-0000VL-4x for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Sep 2006 08:30:17 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GM4mZ-0008Bd-DK
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Sep 2006 08:30:14 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 9 Sep 2006 17:30:02 +0200
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk>
	<200609091131.36909.blaisorblade@yahoo.it>
	<EBD0B8CF381E8B44BB99E8EA137E27C0021AD015@CPEXBE-EML06.kpnsp.local>
In-Reply-To: <EBD0B8CF381E8B44BB99E8EA137E27C0021AD015@CPEXBE-EML06.kpnsp.local>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609091730.02654.blaisorblade@yahoo.it>
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
Cc: user-mode-linux-devel@lists.sourceforge.net

On Saturday 09 September 2006 15:39, i.r.wezeman@hetnet.nl wrote:
> The 'Try removing' will not work.
In all these cases you get a message about `get_safe_registers', i.e. another 
error; do you get the error about __bb_init_func with the "try removing" 
thing?
Also, it should compile by disabling CONFIG_GCOV (as you know probably), and 
this option is only for debugging - if it does not compile in that case 
there's something _very_ strange going on (like if `get_safe_registers' had 
been removed by hand-editing); anyway this discussion is useful to find the 
fix to the bug.
> So have do the 'Better yet ' with make 
> clean, make distclean, make allmodconfig ARCH=um and make linux ARCH=um
>
> Now got the same error after 'Better yet':
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/um/os-Linux/built-in.o: In function `do_syscall_stub':
> arch/um/os-Linux/skas/mem.c:63: undefined reference to `get_safe_registers'
> arch/um/os-Linux/built-in.o: In function `copy_context_skas0':
> arch/um/os-Linux/skas/process.c:333: undefined reference to
> `get_safe_registers' collect2: ld returned 1 exit status
>   KSYM    .tmp_kallsyms1.S
> nm: '.tmp_vmlinux1': No such file
> No valid symbol.
> make: *** [.tmp_kallsyms1.S] Error 1
>
> error, do: #CONFIG_MODE_TT=y
> make clean and make linux ARCH=um
>
> Now got the same error as with 'Better yet'
>
> error, do: CONFIG_STATIC_LINK=y
> make clean and make linux ARCH=um
>
> Same error as with 'Better yet'
>
> error, do: CONFIG_GPROF=y
> make clean and make linux ARCH=um
>
> Same error as with 'Better yet'
>
> TODO: get_safe_register should be undefined only
> because of the previous failure.
>
> In which to undefine?
No, don't undefine it. I was talking about this error message, which I can't 
explain - I thought it was just a conseguence of the error above.
> > arch/um/os-Linux/built-in.o: In function `do_syscall_stub':
> > arch/um/os-Linux/skas/mem.c:63: undefined reference to
> > `get_safe_registers'
> > arch/um/os-Linux/built-in.o: In function `copy_context_skas0':
> > arch/um/os-Linux/skas/process.c:333: undefined reference to
> > `get_safe_registers'
since get_safe_registers is defined in arch/um/os-Linux/sys-i386/registers.c, 
this error does not make a lot of sense. Make sure you haven't removed the 
definition by mistake - the other possibility is that file is not linked with 
the rest, but this would cause also other "undefined reference" errors.
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
