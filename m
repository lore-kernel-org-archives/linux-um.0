Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AbOqB-0005D6-BI
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 30 Dec 2003 10:43:39 -0800
Received: from mta10.adelphia.net ([68.168.78.202])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AbOqB-0008DP-1E
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 30 Dec 2003 10:43:39 -0800
From: Matt Zimmerman <mdz@debian.org>
Subject: Resolution (Re: [uml-devel] 2.4.22-[67] problems)
Message-ID: <20031230184330.GD1365@alcor.net>
References: <20031220011323.GW18100@alcor.net> <20031220171450.GB10692@ccure.user-mode-linux.org> <20031221005257.GF9354@alcor.net> <20031221010656.GH9354@alcor.net> <20031228093317.GK17472@alcor.net> <20031228095115.GL17472@alcor.net> <20031228101240.GN17472@alcor.net> <20031228113042.GO17472@alcor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031228113042.GO17472@alcor.net>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 30 Dec 2003 10:43:30 -0800
To: user-mode-linux-devel@lists.sourceforge.net, 224431@bugs.debian.org

On Sun, Dec 28, 2003 at 03:30:42AM -0800, Matt Zimmerman wrote:

> On Sun, Dec 28, 2003 at 02:12:40AM -0800, Matt Zimmerman wrote:
> 
> > So, the sequence of events in handle_trap is this:
> > 
> > 1. UPT_SYSCALL_NR(regs) == 78
> > 
> > 2. ptrace(PTRACE_POKEUSER,...)
> > 
> > 3. UPT_SYSCALL_NR(regs) == 78 (still OK)
> > 
> > 4. ptrace(PTRACE_SYSCALL,...)
> > 
> > 5. UPT_SYSCALL_NR(regs) == 78 (still OK)
> > 
> > 6. waitpid(pid,...)
> > 
> > 7. UPT_SYSCALL_NR(regs) == 0 (boom)
> > 
> > I have no idea why.
> 
> I added some code to dump the regs struct before and after waitpid, and it
> turns out that in fact, the syscall element is the only one which is
> different; the rest of the structure is untouched.  Corruption seems
> unlikely, and the waitpid call certainly shouldn't be touching this...could
> another thread be clobbering it somehow?

It turns out that this problem seems to be due to compiler incompatibility.
UML had been built with gcc 2.95 due to old breakage, and when built with
gcc 3.3 (as glibc is), everything starts working again.  My suspicion is
that this is due to certain recent changes in pthreads.

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
