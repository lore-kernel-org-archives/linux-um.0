Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfSTJ-000864-6B for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 16:57:05 -0700
Received: from nks-mail-02.nks.net ([66.152.21.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1BfSTI-0002tv-Jy
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 16:57:05 -0700
Message-ID: <40E20187.1050803@nks.net>
From: James Neal <jneal@nks.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] [mgedmin@b4net.lt: Bug#256873: user-mode-linux: fails
	to start (kernel panic)]
References: <20040629182711.GM5243@alcor.net>
In-Reply-To: <20040629182711.GM5243@alcor.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Tue, 29 Jun 2004 19:55:51 -0400
To: Matt Zimmerman <mdz@debian.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, Marius Gedminas <mgedmin@b4net.lt>, 256873-forwarded@bugs.debian.org

Matt Zimmerman wrote:

>I am receiving many reports from my users that 2.4.26-1um is less functional
>than past versions, especially (but not exclusively) where hostfs is
>concerned.  Are others experiencing problems as well?  I am considering
>reverting the Debian packages to 2.4.24-1um, which was the last version
>which was stable for me (it had only one frustrating hostfs bug, where
>readdir() would read forever).
>  
>
Yeah, I upgraded about a hundred (non-critical) UMLs to a straight 
2.4.26-1um kernel about a two weeks ago, and immediately started getting 
2-3 crashes (like the one below) per hour.   When backups kicked off, 
they pretty much all went down at the same time.  (Unfortunately, I 
hadn't added automatic backtracing to the UMLazi codebase yet, so I 
didn't get backtraces.)

I ended up going with a 2.4.26 kernel, with the 2.4.24-1um UML patch, 
and http://vs165141.v.sectoor.de/uml-2.4.26-cmpxchg.patch . This 
combination is running over 600 UMLs for 8 days without a crash.

-James

>----- Forwarded message from Marius Gedminas <mgedmin@b4net.lt> -----
>
>  [...]
>  Checking that ptrace can change system call numbers...OK
>  openpty failed to allocate a pty
>  openpty failed to allocate a pty
>  POSIX conformance testing by UNIFIX
>  process 553 exited with status 0
>  Kernel panic: wait_for_stop failed to wait for 553 to stop with 19
>
>  In idle task - not syncing
>   <6>SysRq : Show Regs
>
>  Kernel panic: Segfault with no mm
>  In idle task - not syncing
>   <6>SysRq : Show Regs
>
>  EIP: 0023:[<a015f2e5>] CPU: 0 Not tainted ESP: 002b:a121feb4 EFLAGS: 00010202
>      Not tainted
>  EAX: 00000000 EBX: a02adee0 ECX: 00000001 EDX: a121c274
>  ESI: 00000070 EDI: 00000007 EBP: a121fecc DS: 002b ES: 002b
>  Call Trace: [<a016ecd0>] [<a015589f>] [<a0023b2d>] [<a0014c08>] [<a0154b0b>]
>     [<a0264a67>] [<a0201c44>] [<a0152503>] [<a0154f65>] [<a015f2e5>] [<a0159241>]
>     [<a0155062>] [<a0201b58>] [<a015f2e5>] [<a015f2c7>] [<a0263345>] [<a016ed6a>]
>     [<a016ecd0>] [<a015589f>] [<a0023b2d>] [<a0014c08>] [<a0155e6f>] [<a02814c0>]
>     [<a014f3cb>] [<a014f360>] [<a021a49a>]
>
>The process ID (553) seems to vary, but the other numbers stay constant,
>at a glance.
>
>----- End forwarded message -----
>
>  
>



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
