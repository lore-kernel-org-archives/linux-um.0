Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H7FLt-0005Mh-Vd for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Jan 2007 10:17:38 -0800
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1H7FLr-0003Oo-GO
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Jan 2007 10:17:37 -0800
Message-ID: <45AE684D.7070802@theshore.net>
Date: Wed, 17 Jan 2007 12:17:49 -0600
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
References: <200701171715.35504.blaisorblade@yahoo.it>
In-Reply-To: <200701171715.35504.blaisorblade@yahoo.it>
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
[snip]
> Without any errors, after these messages:
> 
> kjournald starting.  Commit interval 5 seconds
> EXT3-fs: mounted filesystem with ordered data mode.
> VFS: Mounted root (ext3 filesystem) readonly.
> 
> it hangs giving the following result at strace -p (I've printed two 
> consecutive iterations of the same messages to show that they are the same):
> 
> --- SIGCHLD (Child exited) @ 0 (0) ---
> wait4(31586, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}], WSTOPPED, NULL) = 
> 31586
> ptrace(PTRACE_GETREGS, 31586, 0, 0x6096dac8) = 0
> ptrace(PTRACE_GETFPREGS, 31586, 0, 0x6096dba0) = 0
> ptrace(PTRACE_CONT, 31586, 0, SIGSEGV)  = 0
> --- SIGCHLD (Child exited) @ 0 (0) ---
> wait4(31586, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGUSR1}], WSTOPPED, NULL) = 
> 31586
> ptrace(PTRACE_SETREGS, 31586, 0, 0x6096dac8) = 0
> ptrace(PTRACE_SETFPREGS, 31586, 0, 0x6096dba0) = 0
> ptrace(PTRACE_SYSCALL, 31586, 0, SIG_0) = 0
> 
> --- SIGCHLD (Child exited) @ 0 (0) ---
> wait4(31586, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}], WSTOPPED, NULL) = 
> 31586
> ptrace(PTRACE_GETREGS, 31586, 0, 0x6096dac8) = 0
> ptrace(PTRACE_GETFPREGS, 31586, 0, 0x6096dba0) = 0
> ptrace(PTRACE_CONT, 31586, 0, SIGSEGV)  = 0
> --- SIGCHLD (Child exited) @ 0 (0) ---
> wait4(31586, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGUSR1}], WSTOPPED, NULL) = 
> 31586
> ptrace(PTRACE_SETREGS, 31586, 0, 0x6096dac8) = 0
> ptrace(PTRACE_SETFPREGS, 31586, 0, 0x6096dba0) = 0
> ptrace(PTRACE_SYSCALL, 31586, 0, SIG_0) = 0
> 
> I'll have to verify whether some code in the stubs is miscompiled. But not 
> until... well, I dunno when I'll be back...
> 
> Anybody else with the same problem?


Isn't this is the same problem we discussed a few months back?  What 
I've discovered since then is this is a regression introduced after 
2.6.16 on the _host_.  Any post-2.6.16 host kernel, either skas v8.2 or 
v9.pre causes Ubuntu (and other distros, I believe) to hang after "VFS 
mounting root".

http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=116008558424368&w=2
http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=116711159414443&w=2

-Chris


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
