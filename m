Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CTkOL-0005nS-VU for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Nov 2004 09:11:49 -0800
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CTkOI-0007ja-Ak for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Nov 2004 09:11:49 -0800
Message-ID: <4198E349.5070809@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Patchset to implement PTRACE_SYSEMU_SINGLESTEP
References: <419517A4.7020700@fujitsu-siemens.com>
	<200411130043.25888.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411130043.25888.blaisorblade_spam@yahoo.it>
Content-Type: multipart/mixed; boundary="------------000603060407000805060705"
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
Date: Mon, 15 Nov 2004 18:11:37 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

This is a multi-part message in MIME format.
--------------000603060407000805060705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Blaisorblade wrote:
> On Friday 12 November 2004 21:05, Bodo Stroesser wrote:
> 
>>Attached are several patches. Four of them (patch-2.6.*-skas-v7-*)
>>implement PTRACE_SYSEMU_SINGLESTEP in the host. They are based on
>>linux-2.6.7-vanilla + host-skas3-2.6.7-v7.patch (resp. the 2.6.9 versions).
>>The "-reorganize" patches are a rework of the current patch without
>>changing the functionality. The "add-SYSEMU_SINGLESTEP" then implement the
>>new features. Please note: the differences between 2.6.7 and 2.6.9 are
>>dependent on the different handling of syscall singlestepping in the two
>>versions.
>>
>>To have UML using the new feature, there are two further patches named
>>patch-SYSEMU_SINGLESTEP-*. They are based on linux-2.6.9-vanilla +
>>all bb2-patches + patch-sysemu-tt + patch-fix-uml-hang-on-2.6.9-host.
>>To have all the patches complete, the latter two are attached also.
>>
>>I tested on host 2.6.7 and host 2.6.9 with SKAS and TT mode. Currently I
>>don't know any problem with it.
> 
> 
>>Bodo
> 
> 
>>BTW: Today I tried the first time since weeks to do a reboot in SKAS. It
>>simply exits UML, as it did weeks ago. Is there anybody involved with that
>>problem?
> 
> 
> It seems a bit randomical: on my system, it segfaults some times, after 
> checking for /proc/mm and SKAS mode.
> 
> When applying my use-va_end patch, (it's also in Jeff incrementals), instead, 
> it always gets this segfault.
> 
> If you look at the comment about exec(), it says that UML risks to get some 
> signals after the exec(). It workarounds this for some signals, but this 
> cannot be done anyway for SIGSEGV... actually SIGSEGV delivery happens to 
> always be synchronous, since the process gets trapped before the signal is 
> queued.
> 
> By comparison, all signals are normally asynchronous, i.e. they get queued and 
> later delivered, so that deliverying a signal is slower than doing a context 
> switch.
> 
> Quoting from signal(7) man page:
> 
> Multiple instances of real-time signals can be queued.  By contrast,  if  
> multiple instances of  a standard  signal  are  delivered  while  that signal 
> is currently blocked, then only one instance is queued.

What happens on my system shows some other symptoms. After "Restarting system."
UML exits without further message. I could track this down to a SIGIO being
unblocked immediately before the execvp(). It is handled by sig_handler()
that calls sig_handler_common_skas(). Why this exits, I don't know.
Maybe, SKAS misses an reset of the handlers to empty handlers.
Since I didn't want to dig very deep here, I choosed a simple solution.
I attached the patch. For me it works fine.
Feel free to find a better solution!

Bodo

--------------000603060407000805060705
Content-Type: text/plain;
 name="patch-fix-reboot-skas"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-fix-reboot-skas"

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

In most cases reboot failed on my system. After
"Restarting system.", UML exited without further messages.
I found an SIGIO being processed by sig_handler() resp.
sig_handler_common_skas(). Don't know, why this exits,
maybe the context is no longer valid at this time.
So, I changed the sequence in the reboot part of main()
to stop the timers and disable the fds before unblocking
the signals. Since this wasn't enough, I also added
set_handler(SIGXXX, SIG_IGN) calls to disable_timer() and
deactivate_all_fds().
Now reboot works fine in SKAS and it still works in TT.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
---

--- a/arch/um/kernel/main.c	2004-11-15 17:19:42.437975368 +0100
+++ b/arch/um/kernel/main.c	2004-11-15 17:35:34.901178952 +0100
@@ -157,18 +157,20 @@ int main(int argc, char **argv, char **e
 		int err;
 
 		printf("\n");
-
-		/* Let any pending signals fire, then disable them.  This
-		 * ensures that they won't be delivered after the exec, when
-		 * they are definitely not expected.
-		 */
-		unblock_signals();
+		/* stop timers and set SIG*ALRM to be ignored */
 		disable_timer();
+		/* disable SIGIO for the fds and set SIGIO to be ignored */
 		err = deactivate_all_fds();
 		if(err)
 			printf("deactivate_all_fds failed, errno = %d\n",
 			       -err);
 
+		/* Let any pending signals fire now.  This ensures
+		 * that they won't be delivered after the exec, when
+		 * they are definitely not expected.
+		 */
+		unblock_signals();
+
 		execvp(new_argv[0], new_argv);
 		perror("Failed to exec kernel");
 		ret = 1;
--- a/arch/um/kernel/time.c	2004-10-18 23:53:43.000000000 +0200
+++ b/arch/um/kernel/time.c	2004-11-15 17:32:41.057607192 +0100
@@ -60,6 +60,9 @@ void disable_timer(void)
 	   (setitimer(ITIMER_REAL, &disable, NULL) < 0))
 		printk("disnable_timer - setitimer failed, errno = %d\n",
 		       errno);
+	/* If there are signals already queued, after unblocking ignore them */
+	set_handler(SIGALRM, SIG_IGN, 0, -1);
+	set_handler(SIGVTALRM, SIG_IGN, 0, -1);
 }
 
 void switch_timers(int to_real)
--- a/arch/um/kernel/irq_user.c	2004-10-18 23:53:51.000000000 +0200
+++ b/arch/um/kernel/irq_user.c	2004-11-15 17:33:40.893510752 +0100
@@ -374,6 +374,8 @@ int deactivate_all_fds(void)
 		if(err)
 			return(err);
 	}
+	/* If there is a signal already queued, after unblocking ignore it */
+	set_handler(SIGIO, SIG_IGN, 0, -1);
 
 	return(0);
 }

--------------000603060407000805060705--


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
