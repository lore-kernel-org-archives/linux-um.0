Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FgFOh-0007dh-3x for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 May 2006 23:20:39 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FgFOh-0003ZL-3X for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 May 2006 23:20:39 -0700
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FgFOd-0005Mi-FT
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 16 May 2006 23:20:39 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] RFC allow PTRACE_SYSCALL to selectively skip
	syscalls
References: <Pine.LNX.4.58.0605111220070.664@ucontrol.mobiledns.com>
In-Reply-To: <Pine.LNX.4.58.0605111220070.664@ucontrol.mobiledns.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605170820.30922.blaisorblade@yahoo.it>
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
Date: Wed, 17 May 2006 08:20:30 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Steven James <pyro@linuxlabs.com>

On Saturday 13 May 2006 19:40, Steven James wrote:
> Greetings,
>
> I have been working on a few experimental system calls using a ptrace
> mechanism similar to UML to implement the calls. Naturally this lead me to
> look at PTRACE_SYSEMU vs. PTRACE_SYSCALL. Since the extra system calls are
> implemented entirely by the ptrace thread it seems a shame to take the
> context switch on entry and exit from the call. In some cases, I need to
> also implement a few of the standard Linux kernel calls in the ptrace
> thread as well, based on parameters of the call (for example, writes to
> specific open files).
>
> The patch below for x86_64 implements a scheme where a ptraced system call
> is skipped if the ptrace thread sets a return value (in RAX) when it
> handles the syscall entry. Otherwise things proceed normally.

Just to make things clearer: is this a different API than SYSEMU to do the 
same thing, as it seems? If so, is it faster by any way, or just more elegant 
in your opinion, or what? I think it's as fast as SYSEMU since you must 
switch to the tracer on the syscall entry, look at params, set the result and 
switch back with a ptrace call, with PTRACE_SYSEMU in my case, with 
PTRACE_SYSCALL (?) in your case.

The current problem with PTRACE_SYSEMU is that you decide whether you'll skip 
the syscall before looking at parameters (other people have already 
complained about this). If this is the problem you have, I'll recover the 
past discussions and let you know.

> A similar change is even easier on i386 since the needed logic is already
> in entry.S for SYSEMU.
>
> I chose changing RAX as the trigger since that is otherwise a useless
> thing for a tracing thread to do at syscall entry.

What if the tracing thread must set -ENOSYS as the return value?
@@ -644,16 +644,24 @@
                send_sig(current->exit_code, current, 1);
                current->exit_code = 0;
        }
+       if(regs->rax != -ENOSYS)
+               return 1;
+
+       return 0;
 }
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
