Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWgxv-0005sx-2l for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 12:08:43 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CWgxt-0001XB-6r for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 12:08:42 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: The current fix-kill patch
References: <200411230550.iAN5o8mY007302@ccure.user-mode-linux.org>
	<41A352E4.5050607@fujitsu-siemens.com>
In-Reply-To: <41A352E4.5050607@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411232110.51937.blaisorblade_spam@yahoo.it>
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
Date: Tue, 23 Nov 2004 21:10:51 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>

On Tuesday 23 November 2004 16:10, Bodo Stroesser wrote:
> Jeff Dike wrote:
> > Here's the latest fix-kill patch in my tree.  Please test and report...

> Have tested based on 2.6.9-bb3. I removed "rework-uml-hang-on-2.6.9-host",
> added BlaisorBlade's "uml-hang-on-2.6.9-host", and adapted iand added this
> new patch.
Btw, if you send another patch, send it relative to "uml-hang-on-2.6.9-host", 
or to it + fix-kill from Jeff, so I can easily spot the differences.

This is a general rule, also (with a bit of taste, i.e. applies between 
developers, not between users).

> The resulting UML kernel for me works fine on host 
> 2.6.7-skas3-v7 and 2.6.9-skas3-v7.
Not yet tested this Jeff Dike's one.

However, for me, on a 2.6.10-rc2 SKAS patched host (with the update I posted 
here and on my site to make SKAS compile), UML hangs on shutdown in SKAS 
mode.

Nobody else reported this with -bb3, so I suppose there is something new in 
2.6.10-rc2 (I didn't yet test this with 

Please let's start testing it ASAP, so that it's fixed before 2.6.10 release. 
However, I have at least to apply the Jeff's fix before.

> Next, I tested what happens if the "kill(pid, SIGKILL);" and
> "ptrace(PTRACE_CONT, pid);" are removed from os_kill_ptraced_process(), and
> it also worked fine.

> Since PTRACE_KILL wakes up the ptraced process unconditionally, IMHO
> "ptrace(PTRACE_CONT, pid);" has no effect here.
You reported PTRACE_KILL not to work in some Ptrace states. PTRACE_CONT is 
intended to fix this (even if PTRACE_KILL is not needed).

> And "kill(pid, SIGKILL);" 
> only is needed, if the ptraced process is not stopped on a
> ptrace-interception.
Well, PTRACE_CONT is to resume if from the ptrace-interception. Let's start by 
distinguishing bugs (i.e. reggressions in 2.6.9 behaviour vs. 2.6.8 and 
earlier one) from strange APIs. Gdb, or any ptracer, is IMHO never supposed 
to SIGKILL the process directly.

> Since os_kill_ptraced_process() is called only then, 
> when the ptraced process is known to be on a ptrace-stop, I would like to
> remove "kill(pid, SIGKILL);", too.
> os_kill_ptraced_process() is called each time, a process in TT exec()s.
> Thus avoiding unneeded calls is a little speedup.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
