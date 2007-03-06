Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOjT2-0006aq-0N for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Mar 2007 15:53:16 -0800
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1HOjSy-00072M-6n
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Mar 2007 15:53:16 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Wed, 7 Mar 2007 00:52:55 +0100
References: <3aab51dc0703061532g4b5e763co8927b5abeabcc2d@mail.gmail.com>
In-Reply-To: <3aab51dc0703061532g4b5e763co8927b5abeabcc2d@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200703070052.56034.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Question about system call trap in UML
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

On Wednesday 07 March 2007 00:32, Haifeng He wrote:
> Hi,
>
> I am beginner of UML. I have a question about how the system call
> trap happens in UML in skas0 mode. Suppose a user application
> within UML initialed a system call. How does UML track the
> system call and is the host OS the one to actually handle the system
> call?

The base tool is ptrace  (see man 2 ptrace).
Basically ptrace(PTRACE_SYSCALL) (also used by the strace tool - look at man 
strace) is used to intercept the syscalls to the host. Registers are modified 
so that getpid() is executed (it is a syscall doing no harm), and the syscall 
is then executed by the UML kernel.

arch/um/os-Linux/skas/process.c contains the core code: the main loop in 
userspace() runs for the process lifetime, once for each process.

handle_trap() does the above trick with getpid and ptrace and calls 
handle_syscall(), which performs the actual syscall.

Assume local_using_sysemu == 0; that does not change the core, it's just a 
faster API to tell the host "don't execute this syscall" than changing the 
syscall to getpid().

No difference about this exists in SKAS0 and SKAS3, that I remember (I think 
it's also valid for TT mode, with a few differences).

> Particularly, I found a file: arch/um/sys-i386/stub.S. Is the file used
> for handling syscalls in user application?

No. That code is injected in all user applications within UML.
When we need that the user process does a certain syscall, we change EIP to 
point to that piece of code, write the syscalls to perform and their 
arguments in a fixed location, and resume the process with ptrace().

The 'virtual RAM' of a UML instance is represented by a file, which is mapped 
with MAP_SHARED.

So, memory mappings for userspace processes are installed by making that stub 
call mmap() with certain arguments decided by UML; munmap() and mprotect() 
are also used.

Since demand paging is used, when mmap is called no mapping is installed; when 
a page is allocated and page tables are modified, we can call mmap() to 
install the mapping.

> Can somebody explain the 
> process to me?
The above is just a little start, to let you explore more and ask more 
specific questions.

Bye
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
