Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CVBSD-00071A-Gj for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Nov 2004 08:17:45 -0800
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CVBSA-0002Wn-0F for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Nov 2004 08:17:45 -0800
Message-ID: <419E1C90.70903@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to
	kill host-OS processes
References: <20041103113736.GA23041@taniwha.stupidest.org>
In-Reply-To: <20041103113736.GA23041@taniwha.stupidest.org>
Content-Type: multipart/mixed; boundary="------------060606030004010403020806"
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
Date: Fri, 19 Nov 2004 17:17:20 +0100
To: Chris Wedgwood <cw@f00f.org>
Cc: Jeff Dike <jdike@addtoit.com>, Blaisorblade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060606030004010403020806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Chris Wedgwood wrote:
> kill(..., SIGKILL) doesn't work to kill host-OS processes created in
> the exec path in TT mode --- for this we need PTRACE_KILL (it did work
> in previous kernels, but not by design).  Without this process will
> accumulate on the host-OS (although the won't be visible inside UML).
> 
> Signed-off-by: Chris Wedgwood <cw@f00f.org>
> ---
> 
> Yes, there are other fixes along these lines which are needed but one
> at a time as we test these...
> 
> Index: cw-current/arch/um/kernel/tt/exec_user.c
> ===================================================================
> --- cw-current.orig/arch/um/kernel/tt/exec_user.c	2004-11-03 02:10:18.064830204 -0800
> +++ cw-current/arch/um/kernel/tt/exec_user.c	2004-11-03 02:12:10.447716745 -0800
> @@ -35,7 +35,8 @@
>  		tracer_panic("do_exec failed to get registers - errno = %d",
>  			     errno);
>  
> -	kill(old_pid, SIGKILL);
> +	if (ptrace(PTRACE_KILL, old_pid, NULL, NULL))
> +		printk("Warning: ptrace(PTRACE_KILL, %d, ...) saw %d\n", errno);
>  
>  	if(ptrace_setregs(new_pid, regs) < 0)
>  		tracer_panic("do_exec failed to start new proc - errno = %d",
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by:
> Sybase ASE Linux Express Edition - download now for FREE
> LinuxWorld Reader's Choice Award Winner for best database on Linux.
> http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
Now, there are some patches out there, to fix the problem:
- this one here
- uml-hang-on-2.6.9-host from BlaisorBlade
- patch-fix-uml-hang-on-2.6.9-host to combine the two and add some new
   stuff

After a discussion on #uml yesterday, I tried to find out, which parts of the
patches are really neccessary. Now here are the results:

1) Chris' patch is neccessary to avoid the amassing threads in tt-mode.
2) All parts from BlaisorBlade's patch regarding SKAS are needed to not have
    SKAS hanging on shutdown. I used the os_kill_ptraced_process() inserted here
    for Chris' part.
3) The changes done in switch_to_tt() from BlaisorBlades patch are not needed.
    Thus, my rework of this isn't needed, too.
4) In release_thread_tt() my change has to inserted, else UML doesn't boot on
    my system.
5) The changes, I did for kill_of_processes_tt and kill_idlers are not needed.
6) I inserted some small changes in kill_of_processes_tt and kill_idlers to
    have the killing process waiting for the killed one to exit. Not really needed,
    but cleaner.
7) I saw some zombies not being reaped immediately before the exec() in case of
    reboot. Thus, I added a small waitpid-loop in tracer(). Also, not needed,
    but cleaner.

The resulting new patch is attached in a tar-ball. It applies to 2.6.9-bb2, but
you have to remove the patch "uml-hang-on-2.6.9-host and add my small series of
patches, which also is in the tar-ball. The fix some small problems, let SKAS
reboot without problems and add the new SYSEMU_SINGLESTEP-mode (but runs on
older hosts also).
Series:
    patch-bb1-fix-1
    patch-fix-elf_aux
    patch-fix-sysemu-tt
    patch-fix-reboot-skas
    patch-close-all-fds which is the unnamed patch from Jeff, adapted to 2.6.9-bb2
    patch-SYSEMU_SINGLESTEP-1
    patch-SYSEMU_SINGLESTEP-2
    patch-rework-uml-hang-on-2.6.9-host

Regards Bodo

--------------060606030004010403020806
Content-Type: application/x-bzip2;
 name="bb2-addon-bodo.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="bb2-addon-bodo.tar.bz2"

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
--------------060606030004010403020806--


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
