Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EyfId-0004OW-R6 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 17:06:15 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EyfIb-0007Vc-Ss
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 17:06:15 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] high-performance system calls using vsyscall
References: <3524bf1f0601120902v3812029l4d8ba5411b53f36f@mail.gmail.com>
	<20060112233848.GA945@ccure.user-mode-linux.org>
In-Reply-To: <20060112233848.GA945@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200601170104.22814.blaisorblade@yahoo.it>
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
Date: Tue, 17 Jan 2006 01:04:21 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Young Koh <young.koh@gmail.com>

On Friday 13 January 2006 00:38, Jeff Dike wrote:
> On Thu, Jan 12, 2006 at 12:02:16PM -0500, Young Koh wrote:
> > I found an old post discussing the possibility of turning a system
> > call into a procedure call using vsyscall. Is it really implemented in
> > recent versions? I tested with recent Linux/UML kernels and glibcs but
> > system calls don't seem that fast. so, i guess it's not implemented
> > yet?

> In the generic kernel (or in whatever arches have the vsyscall page),
> it's used for only a small number of system calls.

No, wrong - on x86 it's used for everything, depending on userspace (it's 
replacing int 0x80 with sysenter). For some reason, on x86-64 it was that 
way, but it switched to what you say (implementing only a few syscalls 
directly in userspace).

> In a tt-style UML, where the UML kernel is in the same address space
> as the process, this could be used for all system calls, where you
> would just jump from there into the UML kernel.

1st, TT mode is kept there only until SKAS0 will be damn stable (it seems 
we're probably reaching that, no foreseen problems, except maybe my new TLS 
code doesn't work for SKAS0 yet IMHO), and because it's the only SMP 
supporting mode.

However, going through ptrace for interprocess comunication is far from 
optimal - using something like, say, POSIX message queues (it's a wild guess) 
would be probably faster. Something purely in userspace seems difficult. 
However, as shown below, if it's not purely in userspace ptrace will 
intercept it, so we stop any gain.

> I think you would have to fiddle libc to make all of the system calls for 
this.

No, you have to do worse - newer libc (more or less NPTL ones) link to a DSO 
which is the vsyscall page, which we can't replace. However maybe the address 
is not fixed, so we could pass the address of another vsyscall page with our 
code.

Obviously ptrace can't be disabled, as int 0x80 is still usable inside UML, 
and you must catch that. Also the normal vsyscall page is still mapped and 
could be run, so sysenter must be also caught.

Once you pass another vsyscall page to glibc, you must only write the 
implementation, distinguish the syscalls from that page (which must go in) 
from the syscalls coming from everywhere else (which must still be 
intercepted the normal way). Indeed, you still get to trace even new-style 
syscalls this way (adding an API for checking something in kernel before 
switching to the debugger is ugly, especially because we indeed must inspect 
the stack to see where the syscall come from).

> 				Jeff

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	
	
		
___________________________________ 
Yahoo! Messenger with Voice: chiama da PC a telefono a tariffe esclusive 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
