Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CUaHx-0002TP-CZ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Nov 2004 16:36:41 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CUaHw-0008Io-5i for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Nov 2004 16:36:41 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [Patch 1/1] uml: fix uml-hang-on-2.6.9-host.patch
References: <4194CCAD.2020701@fujitsu-siemens.com>
In-Reply-To: <4194CCAD.2020701@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411180137.24171.blaisorblade_spam@yahoo.it>
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
Date: Thu, 18 Nov 2004 01:37:24 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike <jdike@addtoit.com>

On Friday 12 November 2004 15:46, Bodo Stroesser wrote:
> From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
>
> The patch needs to be corrected. The use of
> os_kill_ptraced_process() is restricted to the tracer-thread!
> No other process is allowed to do ptrace(PTRACE_KILL).
> So I had "dead" processes hanging in my host system until UML
> was shutdown. And I had panic()s, because processes were not
> stopped.

> Thus, I implemented request_kill_ptraced_process(), which lets
> the tracer do the ptrace(PTRACE_KILL). Sorry, this method is
> slow, but I didn't see an other solution.
Hmm, given how slow TT mode is, I think it may not be noticeable. Especially 
since the signal handling is asynchronous, the exited thread gets "scheduled 
to be killed when the signal is delivered". However, also look at Jeff Dike 
patch he's pushing for testing.

A doubt: IIRC, the queue keeps only one instance of each signal, right? Should 
not we switch all uses of SIGUSR* to real-time signals (which could also 
reduce latency, maybe)?

> Also, I modified some other places to use the new call instead
> of os_kill_process(). But this didn't work on the first step.
> kill_off_processes_tt() couldn't kill the remaining processes
> on shutdown. This happens, because ptrace(PTRACE_KILL) doesn't
> really send a SIGKILL to the process, but writes SIGKILL to the
> exit_code.

> That does results in send_sig(SIGKILL) for processes 
> being stopped on a ptrace event only, but not even for all of
> these events.

> So I added an option to request_kill_ptraced_process() that
> allows to force an additional os_kill_process() to be executed
> before the os_kill_ptraced_process().

About this: it's better to use symbolic constants for such usages, never to 
use numbers. And if you meet code snippets in UML were this is not applied, 
feel free to fix them.

> Summary: The behavior of 2.6.9 host is very uggly. You need to
> do kill() and ptrace(PTRACE_KILL) to be shure, a process will
> really exit.
Hmm.... could you supply a testcase for this?

No, I've modified the Gerd Knorr testcase, replacing kill(SIGKILL) with 
ptrace(PTRACE_KILL), and the result was that PTRACE_KILL alone works, in the 
simplest scenario at least.

> If the host is changed to be more consistent, we 
> should change all this again.

PTRACE_KILL should always work, on every kernel. If not, then we must fix that 
in mainline, and also 

PTRACE_KILL not working would be a real bug, but I would rather check if the 
childs are stopped, and I would happily ask Roland McGrath to fix it and I'd 
include the fix in the SKAS patch (I'm worried it's getting too big, but so 
far, so good). We are facing, instead, a correct API change.

The problem is that we used SIGKILL, which should never have worked. I first 
thought Roland McGrath didn't realize this fact. Now I understand, instead, 
that the kernel should always disallow a ptraced process to be killed by 
someone which is not his parent, when it's stopped (when you reboot, you 
killall everything).

So, the behaviour needed by older UMLs will never be restored - I thought this 
was possible until now, but no more.
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
