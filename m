Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FuVmO-0007FA-5H for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 07:40:04 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FuVmJ-00030w-BA
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 07:40:04 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 25 Jun 2006 16:38:31 +0200
References: <87sllyl2np.fsf@hades.wkstn.nix>
In-Reply-To: <87sllyl2np.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606251638.31879.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] problems compiling 2.6.17 against glibc 2.4
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
Cc: Nix <nix@esperi.org.uk>, Jeff Dike <jdike@addtoit.com>

On Wednesday 21 June 2006 21:38, Nix wrote:
> The problem is that arch/um/os-Linux/sys-i386/registers.c
> messes around inside a jmp_buf, and in glibc 2.4 the glibc
> maintainers have helpfully removed the definitions that
> let you poke around in there (they were only there for the
> sake of one macro, _JMPBUF_UNWINDS, which is no longer
> user-visible.)
>
> This vile patch lets me compile but is almost certainly not good enough:
> however, I don't know what *is* good enough: now that glibc is blocking
> us from the layout of the jmp_buf, what's to stop them from changing it?
> (Well, other than that it would break the ABI ;) )
I made the same thought, but no, they have *already* changed it.
Search for the message from Ulrich Drepper (and if you understand 
the "security reasons" I'd be curious to hear them); also the below patch is 
available in Jeff's tree from some time.

I asked Jeff to #ifdef that code out for 2.6.17 release (since the below patch 
was refused)... anyway Jeff found that we can take setjmp() implementation 
from klibc and include it in UML.

> A temporary hack to make it compile is
>
> --- linux-orig/arch/um/os-Linux/sys-i386/registers.c	2006-06-20
> 08:17:47.000000000 +0100 +++
> linux/arch/um/os-Linux/sys-i386/registers.c	2006-06-21 07:54:52.000000000
> +0100 @@ -130,6 +130,14 @@
>  		       HOST_FP_SIZE * sizeof(unsigned long));
>  }
>
> +# define JB_BX  0
> +# define JB_SI  1
> +# define JB_DI  2
> +# define JB_BP  3
> +# define JB_SP  4
> +# define JB_PC  5
> +# define JB_SIZE 24
> +
>  void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
>  {
>  	struct __jmp_buf_tag *jmpbuf = buffer;
>
> but that's hardly acceptable in the long run.

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
