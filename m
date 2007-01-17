Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H7DSY-0007jG-Ku for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Jan 2007 08:16:22 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H7DSP-0006ff-Ic
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Jan 2007 08:16:19 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Wed, 17 Jan 2007 17:15:35 +0100
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701171715.35504.blaisorblade@yahoo.it>
Subject: [uml-devel] UML/64bit is miscompiled by gcc 4.0.3 on Ubuntu 6.06 LTS
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
To: user-mode-linux-devel@lists.sourceforge.net

I've found now the time to run a test, and I found that while on Ubuntu, until 
now, I couldn't compile a 64bit UML (I thought of some regression I didn't 
have the time to debug), compiling the same code with gcc 3.4 gets a fully 
working UML.

The used UML is release 2.6.18.6.

Ubuntu's gcc is:

$ gcc -v
Using built-in specs.
Target: x86_64-linux-gnu
Configured 
with: ../src/configure -v --enable-languages=c,c++,java,f95,objc,ada,treelang --prefix=/usr --enable-shared --with-system-zlib --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --enable-nls --program-suffix=-4.0 --enable-__cxa_atexit --enable-clocale=gnu --enable-libstdcxx-debug --enable-java-awt=gtk-default --enable-gtk-cairo --with-java-home=/usr/lib/jvm/java-1.4.2-gcj-4.0-1.4.2.0/jre --enable-mpfr --disable-werror --enable-checking=release 
x86_64-linux-gnu
Thread model: posix
gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)


Without any errors, after these messages:

kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.

it hangs giving the following result at strace -p (I've printed two 
consecutive iterations of the same messages to show that they are the same):

--- SIGCHLD (Child exited) @ 0 (0) ---
wait4(31586, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}], WSTOPPED, NULL) = 
31586
ptrace(PTRACE_GETREGS, 31586, 0, 0x6096dac8) = 0
ptrace(PTRACE_GETFPREGS, 31586, 0, 0x6096dba0) = 0
ptrace(PTRACE_CONT, 31586, 0, SIGSEGV)  = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
wait4(31586, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGUSR1}], WSTOPPED, NULL) = 
31586
ptrace(PTRACE_SETREGS, 31586, 0, 0x6096dac8) = 0
ptrace(PTRACE_SETFPREGS, 31586, 0, 0x6096dba0) = 0
ptrace(PTRACE_SYSCALL, 31586, 0, SIG_0) = 0

--- SIGCHLD (Child exited) @ 0 (0) ---
wait4(31586, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGSEGV}], WSTOPPED, NULL) = 
31586
ptrace(PTRACE_GETREGS, 31586, 0, 0x6096dac8) = 0
ptrace(PTRACE_GETFPREGS, 31586, 0, 0x6096dba0) = 0
ptrace(PTRACE_CONT, 31586, 0, SIGSEGV)  = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
wait4(31586, [{WIFSTOPPED(s) && WSTOPSIG(s) == SIGUSR1}], WSTOPPED, NULL) = 
31586
ptrace(PTRACE_SETREGS, 31586, 0, 0x6096dac8) = 0
ptrace(PTRACE_SETFPREGS, 31586, 0, 0x6096dba0) = 0
ptrace(PTRACE_SYSCALL, 31586, 0, SIG_0) = 0

I'll have to verify whether some code in the stubs is miscompiled. But not 
until... well, I dunno when I'll be back...

Anybody else with the same problem?
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
