Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ev38n-0007TA-CS for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Jan 2006 17:45:09 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ev38m-0006ld-RD
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Jan 2006 17:45:09 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [PATCH 4/9] UML - Better diagnostics for broken
	configs
Message-ID: <20060107023713.GA13285@ccure.user-mode-linux.org>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org>
	<20060105161436.GA4426@ccure.user-mode-linux.org>
	<Pine.LNX.4.61.0601052258350.27662@yvahk01.tjqt.qr>
	<200601061801.17497.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601061801.17497.rob@landley.net>
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
Date: Fri, 6 Jan 2006 21:37:13 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jan Engelhardt <jengelh@linux01.gwdg.de>, akpm@osdl.org, linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 06:01:13PM -0600, Rob Landley wrote:
> Unfortunately, stock kernels don't let you just discard a system call, so you
> have to pass _something_ on to the underlying OS before you can resume from 
> the ptrace.  But you can change all the information both on the way in and on
> the way out, so what UML did was it turned all system calls into "getpid", 
> which it then ignored the return value of in favor of doing its own system 
> call handling.  Stock kernels also don't allow one process to remap another 
> process's memory, which is kind of important in context switching and meant 
> that each process being traced had to be a separate PID on the host, because 
> the UML kernel couldn't remap that process's page tables.
> 
> Doing both of these things (a seperate host process for each UML process, and
> calling getpid() for all system calls), is what "Tracing Thread" mode did.  
> The UML kernel was one thread among several, and it was kinda slow.

The skas vs tt distinction is the address space part of this.  How we nullify
system calls is separate.  That's the PTRACE_SYSCALL vs PTRACE_SYSEMU (which
is now in mainline) thing.

> Then somebody got drunk and came up with something extremely clever that I'm 
> _still_ trying to get a clear explanation of, but they found out a way to run
> SKAS mode on an unmodified kernel by sacrificing a chicken or something, and 
> this became known as "SKAS0" mode.  

Hehe, that would be Blaisorblade - I've refrained from asking what he had
to sacrifice.

> It's not as fast as SKAS3 mode 
> (sacrificing chickens takes time), but it's faster than TT mode and a lot 
> less cluttered because you don't need a separate process on the host for each
> process running under User Mode Linux kernel. 

skas0 still requires one host process per UML process.  That's how it gets
host address spaces, which skas3 does using /proc/mm.  In this sense, skas0
is sort of a cross between tt and skas3 modes.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
