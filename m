Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H830p-00046x-AN for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Jan 2007 15:19:11 -0800
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1H830l-0002ZQ-E6
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 19 Jan 2007 15:19:11 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 20 Jan 2007 00:18:30 +0100
References: <200701171715.35504.blaisorblade@yahoo.it>
	<20070117232644.GC15745@ccure.user-mode-linux.org>
In-Reply-To: <20070117232644.GC15745@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701200018.30165.blaisorblade@yahoo.it>
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Thursday 18 January 2007 00:26, Jeff Dike wrote:
> On Wed, Jan 17, 2007 at 05:15:35PM +0100, Blaisorblade wrote:
> > kjournald starting.  Commit interval 5 seconds
> > EXT3-fs: mounted filesystem with ordered data mode.
> > VFS: Mounted root (ext3 filesystem) readonly.
> >
> > it hangs giving the following result at strace -p (I've printed two
> > consecutive iterations of the same messages to show that they are the
> > same):
>
> I'm chasing something on i386 with the same symptoms, but I think it's
> a different problem.  What I'm seeing is init segfaulting on some
> hosts, but not others.
>
> Figure out what the segfault is, and where it's happening.
I've started an attempt. I'm also compiling uml 2.6.16-bs3 - with gcc 3.4 
there is no problem, we'll see now with gcc 4.0.
All these tests are run on a custom 2.6.18.6 64-bit kernel, without SKAS (and 
with my RFP patches , but this won't make a difference).

Ok, I hope I remembered correctly how to debug such faults (I'm posting the 
full procedure so you can give a look)
(gdb) where
#0  userspace (regs=0x60a5cac8) 
at /home/paolo/Admin/kernel/6/VCS/linux-2.6.18/arch/um/os-Linux/skas/process.c:275
#1  0x0000000060010192 in new_thread_handler (sig=<value optimized out>) 
at /home/paolo/Admin/kernel/6/VCS/linux-2.6.18/arch/um/kernel/skas/process_kern.c:68
#2  <signal handler called>
#3  0x000000006017a829 in kill () at swab.h:135
#4  0x000000006001d7c9 in set_signals (enable=12139) 
at /home/paolo/Admin/kernel/6/VCS/linux-2.6.18/arch/um/os-Linux/signal.c:228
#5  0x00000000602a3330 in init_thread_union ()
#6  0x00000000602a34e0 in init_thread_union ()
#7  0x00000000600204a4 in new_thread (stack=Cannot access memory at address 
0xfffffffffffffe38
) 
at /home/paolo/Admin/kernel/6/VCS/linux-2.6.18/arch/um/os-Linux/skas/process.c:457
Previous frame inner to this frame (corrupt stack?)

(gdb) print/x regs->skas.regs[16]  	# HOST_IP
$22 = 0x4042f92f			# Always this one
(gdb) print pid
$25 = 12191

bash $ grep 4042f000 /proc/12191/maps
4042f000-40430000 r-xs 019a5000 00:13 
72548                              /tmp/vm_file-eTomUL (deleted)

Finally:
(gdb) print/x uml_physmem + 0x019a5000 + 0x92f
$24 = 0x619a592f
(that's uml_physmem, plus mmap offset from /proc/<child>/maps, + the offset 
inside the vma).

With disassemble I got:

0x00000000619a590f:     nop
0x00000000619a5910:     mov    $0x15,%rax		    # 21 = __NR_access on x86_64.
0x00000000619a5917:     syscall
0x00000000619a5919:     cmp    $0xfffffffffffff001,%rax	    # 
that's -4095, -MAX_ERRNO
0x00000000619a591f:     jae    0x619a5922
0x00000000619a5921:     retq
0x00000000619a5922:     mov    1549599(%rip),%rcx        # 0x61b1fe48
0x00000000619a5929:     xor    %rdx,%rdx
0x00000000619a592c:     sub    %rax,%rdx
0x00000000619a592f:     mov    %edx,%fs:(%rcx)  #faulting instruction.
0x00000000619a5932:     or     $0xffffffffffffffff,%rax
0x00000000619a5936:     jmp    0x619a5921

And there is also a caller:

0x00000000619a5940:     push   %rbx
0x00000000619a5941:     mov    %esi,%ebx
0x00000000619a5943:     sub    $0x90,%rsp
0x00000000619a594a:     mov    1549783(%rip),%rax        # 0x61b1ff28
0x00000000619a5951:     mov    (%rax),%edx
0x00000000619a5953:     test   %edx,%edx
0x00000000619a5955:     jne    0x619a5969
0x00000000619a5957:     callq  0x619a5910
0x00000000619a595c:     mov    %eax,%edx
0x00000000619a595e:     add    $0x90,%rsp
0x00000000619a5965:     mov    %edx,%eax
0x00000000619a5967:     pop    %rbx

This looks like part of the code emitted for __syscall_return, with %fs:$rcx 
seeming like a move into errno (i.e. that's actually glibc code).
This is from a Sarge-64 root_fs (the one from Antoine Martin).

RCX there is (long)regs->skas.regs[11] = -64, and for FS, since HOST_FS = 25, 
I get:

print/x regs->skas.regs[25]
$45 = 0x63

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
