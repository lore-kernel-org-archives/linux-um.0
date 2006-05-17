Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FgNH7-0003Oi-Az for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 May 2006 07:45:21 -0700
Received: from ucontrol.mobiledns.com ([208.176.116.2])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FgNH3-000569-Um
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 May 2006 07:45:21 -0700
From: Steven James <pyro@linuxlabs.com>
Subject: Re: [uml-devel] [PATCH] RFC allow PTRACE_SYSCALL to selectively skip
	syscalls
In-Reply-To: <200605170820.30922.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.58.0605171020350.664@ucontrol.mobiledns.com>
References: <Pine.LNX.4.58.0605111220070.664@ucontrol.mobiledns.com>
	<200605170820.30922.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 17 May 2006 10:45:12 -0400 (EDT)
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, 17 May 2006, Blaisorblade wrote:

> On Saturday 13 May 2006 19:40, Steven James wrote:
> > Greetings,
> >
> > I have been working on a few experimental system calls using a ptrace
> > mechanism similar to UML to implement the calls. Naturally this lead me to
> > look at PTRACE_SYSEMU vs. PTRACE_SYSCALL. Since the extra system calls are
> > implemented entirely by the ptrace thread it seems a shame to take the
> > context switch on entry and exit from the call. In some cases, I need to
> > also implement a few of the standard Linux kernel calls in the ptrace
> > thread as well, based on parameters of the call (for example, writes to
> > specific open files).
> >
> > The patch below for x86_64 implements a scheme where a ptraced system call
> > is skipped if the ptrace thread sets a return value (in RAX) when it
> > handles the syscall entry. Otherwise things proceed normally.
>
> Just to make things clearer: is this a different API than SYSEMU to do the
> same thing, as it seems? If so, is it faster by any way, or just more elegant
> in your opinion, or what? I think it's as fast as SYSEMU since you must
> switch to the tracer on the syscall entry, look at params, set the result and
> switch back with a ptrace call, with PTRACE_SYSEMU in my case, with
> PTRACE_SYSCALL (?) in your case.

It's no faster than SYSEMU and it's not necessarily any more elegant.

>
> The current problem with PTRACE_SYSEMU is that you decide whether you'll skip
> the syscall before looking at parameters (other people have already
> complained about this). If this is the problem you have, I'll recover the
> past discussions and let you know.

That's exactly the problem I had. The emulator can't decide if it wants to
handle the call itself or let the Linux kernel do it until it knows what
syscall it is and in some cases the parameters.

My objective in the patch was to fix that with minimal changes to the
kernel. I did x86_64 first because I had one that was more convieniant for
me to reboot at the time :-)

>
> > A similar change is even easier on i386 since the needed logic is already
> > in entry.S for SYSEMU.
> >
> > I chose changing RAX as the trigger since that is otherwise a useless
> > thing for a tracing thread to do at syscall entry.
>
> What if the tracing thread must set -ENOSYS as the return value?

That's a flaw in the way I'm doing it. I would have to change orig_rax to
an invalid syscall number and take the extra context switches.

An alternative would be to either add yet another process flag that is
checked after the ptrace_notify in (do_)syscall_trace or change the
behaviour of TIF_SYSCALL_EMU by checking it after ptrace_notify.


> @@ -644,16 +644,24 @@
>                 send_sig(current->exit_code, current, 1);
>                 current->exit_code = 0;
>         }
> +       if(regs->rax != -ENOSYS)
> +               return 1;
> +
> +       return 0;
>  }
> --
> Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
> Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
> http://www.user-mode-linux.org/~blaisorblade
>
>
>
>
>
> ___________________________________
> Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB
> http://mail.yahoo.it
>
>
>
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>

||||| |||| |||||||||||||  |||
by Linux Labs International, Inc.
   Steven James, CTO

55 Marietta Street
Suite 1830
Atlanta, Ga 30303
866 824 9737 support



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
