Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUaCA-0001oa-Ij for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Nov 2004 16:30:42 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CUaC9-0007J0-7l for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Nov 2004 16:30:42 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Testing requested - Signal 11 or UML zombies
References: <200411180156.iAI1uuQ3006539@ccure.user-mode-linux.org>
In-Reply-To: <200411180156.iAI1uuQ3006539@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411180132.29462.blaisorblade_spam@yahoo.it>
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
Date: Thu, 18 Nov 2004 01:32:29 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Gerd Knorr <kraxel@bytesex.org>

On Thursday 18 November 2004 02:56, Jeff Dike wrote:
> Below is a patch which I believe fixes the zombies on 2.6.{9,10} bug. 
> There are other fixes for this, one of which is in -mm and is causing
>  'sleeping process nnnnn got unexpected signal : 11'
> crashes.

> Bodo proposed what looks like a correct patch, but which I don't like
> because it involves a round-trip to the tracing thread on every UML context
> switch, which probably 99%+ of the time is unecessary.

> So, what I do now is have the tracing thread do a PTRACE_KILL, PTRACE_CONT
> whenever it sees a process getting a SIGKILL.  And for good measure, the
> PTRACE_CONT ensures that it sees the intercepted SIGKILL.

> So, if you are running on a 2.6.9 or later host, and/or are/were seeing
> either of the above problems, please give this patch a try and report
> results.

I'm pasting here this patch from Chris Wedgwood, to get some comments on it. I 
think this patch may or may not be appropriate, but that it triggers some 
interesting notes on killing host threads:

kill(..., SIGKILL) doesn't work to kill host-OS processes created in
the exec path in TT mode --- for this we need PTRACE_KILL (it did work
in previous kernels, but not by design).  Without this process will
accumulate on the host-OS (although the won't be visible inside UML).

Signed-off-by: Chris Wedgwood <cw@f00f.org>
---

Yes, there are other fixes along these lines which are needed but one
at a time as we test these...

Index: cw-current/arch/um/kernel/tt/exec_user.c
===================================================================
--- cw-current.orig/arch/um/kernel/tt/exec_user.c       2004-11-03 
02:10:18.064830204 -0800
+++ cw-current/arch/um/kernel/tt/exec_user.c    2004-11-03 02:12:10.447716745 
-0800
@@ -35,7 +35,8 @@
                tracer_panic("do_exec failed to get registers - errno = %d",
                             errno);
 
-       kill(old_pid, SIGKILL);
+       if (ptrace(PTRACE_KILL, old_pid, NULL, NULL))
+               printk("Warning: ptrace(PTRACE_KILL, %d, ...) saw %d\n", 
errno);
 
        if(ptrace_setregs(new_pid, regs) < 0)
                tracer_panic("do_exec failed to start new proc - errno = %d",

As you can see, this changes another KILLing of the process. Shouldn't we work 
on the code above, too?

I first thought that the above kill()ing was not dropped when merging the 
below code (the kill below was merged in 2.6.7-2um and 2.4.27-1um, so very 
recently), as suggested by Chris, so thought the change unnecessary, but 
instead that affects fork()ing code, so it's definitely different. If 
everything works with Bodo's patch, it means that the threads for exec()ing 
processes get killed properly in a third place.

And I'm not looking into that because I never studied well TT mode and have no 
time for this right now.

So, Jeff, could you schedule some cleanup on this area for later?

> Index: 2.6.9/arch/um/kernel/tt/process_kern.c
> ===================================================================
> --- 2.6.9.orig/arch/um/kernel/tt/process_kern.c 2004-11-16
> 12:14:15.000000000 -0500 +++
> 2.6.9/arch/um/kernel/tt/process_kern.c 2004-11-17 18:24:25.000000000 -0500
> @@ -65,7 +65,8 @@
>    panic("write of switch_pipe failed, err = %d", -err);
>
>   reading = 1;
> - if((from->exit_state == EXIT_ZOMBIE) || (from->exit_state == EXIT_DEAD))
> + if((from->exit_state == EXIT_ZOMBIE) ||
> +    (from->exit_state == EXIT_DEAD))
>    os_kill_process(os_getpid(), 0);

>   err = os_read_file(from->thread.mode.tt.switch_pipe[0], &c, sizeof(c));
> @@ -82,7 +83,7 @@
>   prev_sched = current->thread.prev_sched;
>   if((prev_sched->exit_state == EXIT_ZOMBIE) ||
>      (prev_sched->exit_state == EXIT_DEAD))
> -  os_kill_ptraced_process(prev_sched->thread.mode.tt.extern_pid, 1);
> +  os_kill_process(prev_sched->thread.mode.tt.extern_pid, 1);
>
>   /* This works around a nasty race with 'jail'.  If we are switching
>    * between two threads of a threaded app and the incoming process


> Index: 2.6.9/arch/um/kernel/tt/tracer.c
> ===================================================================
> --- 2.6.9.orig/arch/um/kernel/tt/tracer.c 2004-11-16 21:26:03.000000000
> -0500 +++ 2.6.9/arch/um/kernel/tt/tracer.c 2004-11-17 18:36:15.000000000
> -0500 @@ -271,10 +271,28 @@
>  #endif
>    else if(WIFSIGNALED(status)){
>     sig = WTERMSIG(status);
> -   if(sig != 9){
> +   if(sig == SIGKILL){
> +    /* This is to make sure that processes die
> +     * immediately without becoming zombies on
> +				 * all hosts.  Before 2.6.9, kill(pid, SIGKILL)
> +				 * was enough to make sure a process went away
> +				 * immediately.  After 2.6.9, they don't run
> +				 * any more, but they remain as zombies.  So,
> +				 * a PTRACE_CONT is necessary in order to put
> +				 * them in a normal run state so that they die.
> +				 * I do a PTRACE_KILL here for good measure.
> +				 * Might as well kill it by all available
> +				 * means.  These calls will likely fail when
> +				 * they are not needed because the process has
> +				 * already disappeared.  However, they don't
> +				 * hurt.
> +				 */
> +				ptrace(PTRACE_KILL, pid, 0, 0);
> +				ptrace(PTRACE_CONT, pid, 0, sig);
> +			}
> +			else
>  				printf("Child %d exited with signal %d\n", pid,
>  				       sig);
> -			}
>  		}
>  		else if(WIFSTOPPED(status)){
>  			proc_id = pid_to_processor_id(pid);
> Index: 2.6.9/arch/um/os-Linux/process.c
> ===================================================================
> --- 2.6.9.orig/arch/um/os-Linux/process.c	2004-11-16 12:14:15.000000000
> -0500 +++ 2.6.9/arch/um/os-Linux/process.c	2004-11-17 18:27:52.000000000
> -0500 @@ -95,9 +95,16 @@
>
>  }
>
> +/* Kill off a ptraced child by all means available.  kill it normally
> first, + * then PTRACE_KILL it, then PTRACE_CONT it in case it's in a run
> state from + * which it can't exit directly.
> + */
> +
>  void os_kill_ptraced_process(int pid, int reap_child)
>  {
> +	kill(pid, SIGKILL);
>  	ptrace(PTRACE_KILL, pid);
> +	ptrace(PTRACE_CONT, pid);
>  	if(reap_child)
>  		CATCH_EINTR(waitpid(pid, NULL, 0));
>  }
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: InterSystems CACHE
> FREE OODBMS DOWNLOAD - A multidimensional database that combines
> robust object and relational technologies, making it a perfect match
> for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
