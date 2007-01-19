Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H83DD-0005H2-7d for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Jan 2007 15:31:59 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H83D9-00065R-JP
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Jan 2007 15:31:59 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 20 Jan 2007 00:31:22 +0100
References: <200701171715.35504.blaisorblade@yahoo.it>
	<45AE684D.7070802@theshore.net>
In-Reply-To: <45AE684D.7070802@theshore.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701200031.22334.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML/64bit is miscompiled by gcc 4.0.3 on Ubuntu
	6.06 LTS
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net, Antoine Martin <antoine@nagafix.co.uk>
Cc: "Christopher S. Aker" <caker@theshore.net>

On Wednesday 17 January 2007 19:17, Christopher S. Aker wrote:
> Blaisorblade wrote:
> [snip]
>
> > Without any errors, after these messages:
> >
> > kjournald starting.  Commit interval 5 seconds
> > EXT3-fs: mounted filesystem with ordered data mode.
> > VFS: Mounted root (ext3 filesystem) readonly.
> >
> > it hangs giving the following result at strace -p (I've printed two
> > consecutive iterations of the same messages to show that they are the
> > same):
> >
> > --- SIGCHLD (Child exited) @ 0 (0) ---
> > wait4(31586, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}], WSTOPPED, NULL)
> > = 31586
> > ptrace(PTRACE_GETREGS, 31586, 0, 0x6096dac8) = 0
> > ptrace(PTRACE_GETFPREGS, 31586, 0, 0x6096dba0) = 0
> > ptrace(PTRACE_CONT, 31586, 0, SIGSEGV)  = 0
> > --- SIGCHLD (Child exited) @ 0 (0) ---
> > wait4(31586, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGUSR1}], WSTOPPED, NULL)
> > = 31586
> > ptrace(PTRACE_SETREGS, 31586, 0, 0x6096dac8) = 0
> > ptrace(PTRACE_SETFPREGS, 31586, 0, 0x6096dba0) = 0
> > ptrace(PTRACE_SYSCALL, 31586, 0, SIG_0) = 0
> >
> > --- SIGCHLD (Child exited) @ 0 (0) ---
> > wait4(31586, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}], WSTOPPED, NULL)
> > = 31586
> > ptrace(PTRACE_GETREGS, 31586, 0, 0x6096dac8) = 0
> > ptrace(PTRACE_GETFPREGS, 31586, 0, 0x6096dba0) = 0
> > ptrace(PTRACE_CONT, 31586, 0, SIGSEGV)  = 0
> > --- SIGCHLD (Child exited) @ 0 (0) ---
> > wait4(31586, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGUSR1}], WSTOPPED, NULL)
> > = 31586
> > ptrace(PTRACE_SETREGS, 31586, 0, 0x6096dac8) = 0
> > ptrace(PTRACE_SETFPREGS, 31586, 0, 0x6096dba0) = 0
> > ptrace(PTRACE_SYSCALL, 31586, 0, SIG_0) = 0
> >
> > I'll have to verify whether some code in the stubs is miscompiled. But
> > not until... well, I dunno when I'll be back...
> >
> > Anybody else with the same problem?
>
> Isn't this is the same problem we discussed a few months back?  What
> I've discovered since then is this is a regression introduced after
> 2.6.16 on the _host_.  Any post-2.6.16 host kernel, either skas v8.2 or
> v9.pre causes Ubuntu (and other distros, I believe) to hang after "VFS
> mounting root".
Not at all.

I'm running:

64bit host - 2.6.18 on the host, Ubuntu 6.06 LTS. It would use 2.6.15 as 
default kernel, however (which implies their glibc is compiled against it).

Without SKAS.

Guest - 32bit is all fine with Debian (my usual testcase)
- 64bit is fine only with gcc 3.4, with gcc 4.0 I get troubles.

Also, since now I don't have the time to read everything frequently, I start 
forgetting (I used to have a mental db of such problems, when I worked on 
them a lot). We should use http://bugzilla.kernel.org/.

Since both you and Antoine are hitting that same bug, I'm cc'ing both of you.
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
