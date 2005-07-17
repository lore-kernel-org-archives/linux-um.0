Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Du3xb-000802-3C	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 Jul 2005 00:53:15 -0700
Received: from lon-del-03.spheriq.net ([195.46.50.99])
	by sc8-sf-mx1.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1Du3xZ-0005Kh-Ko
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 17 Jul 2005 00:53:15 -0700
Received: from lon-out-01.spheriq.net ([195.46.50.129])
	by lon-del-03.spheriq.net with ESMTP id j6H7r3vw006523
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 17 Jul 2005 07:53:03 GMT
Received: from lon-cus-02.spheriq.net (lon-cus-02.spheriq.net [195.46.50.38])
	by lon-out-01.spheriq.net with ESMTP id j6H7r43M009541
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 17 Jul 2005 07:53:04 GMT
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by lon-cus-02.spheriq.net with ESMTP id j6H7qxqq012322verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 17 Jul 2005 07:53:02 GMT
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DBC89DA41
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 17 Jul 2005 07:52:58 +0000 (GMT)
Received: from zeta.dmz-ap.st.com (localhost [127.0.0.1])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6EE38520CA
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 17 Jul 2005 07:52:58 +0000 (UTC)
Received: from mail1.sha.st.com (mail1.sha.st.com [10.94.100.2])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D0448132B6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 17 Jul 2005 07:52:57 +0000 (GMT)
From: Alex LIU <alex.liu@st.com>
Subject: RE: [uml-devel] Segmentation fault with kernel thread in UML-2.6.7 TT
	mode
Message-ID: <000901c58aa4$86288800$9eb3c68a@SHZ.ST.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
In-Reply-To: <200507152025.01288.blaisorblade@yahoo.it>
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
Date: Sun, 17 Jul 2005 15:52:46 +0800
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

On 16 July 2005, Blaisorblade wrote:

> Hmm, but where's the caller to return? In most cases it won't exist. I 
> don't understand what's your purpose, and the behaviour you'd want to 
> reproduce. Sorry, but *which* userspace should it go to? What you're 
> modifying is the execution path of kernel_thread.

In fact I want to port Bproc to UML. Now Bproc is based on i386. And a part of the main work Bproc does is about the kernel thread...Bproc create a new kernel thread function with the name bproc_kernel_thread in i386 and let the Bproc kernel thread go to the user space rather than exit. Bproc will call the new kernel thread function while other i386 programs still call the original i386 kernel thread function kernel_thread.

The reason why Bproc create it's own bproc_kernel_thread function is below:
------------------------------------------------------
Bproc provides the process migration facilities for processes running in a cluster. The administrator can control all the cluster processes on the master node(or front end) locally. The place holders in the master's process tree are called ghost processes. There is one ghost for every remote process. Ghost processes are lightweight kernel thread.

In i386, the child process created by kernel_thread cannot become a normal user process again.  Not easily in any case.  
In Bproc, if a process migrates back to the front end, the ghost process must effectively becomes a normal process again.  Then the ghost thread will have to 'return' to user space. 

Normally, a process is running in user space, does a syscall, some kernel code runs and it returns back to user space.  In the Bproc case where a process moves back onto its ghost.  The ghost has to be able to get back to user space.  Bproc implemented that by allowing the ghost thread function to return.

If the process moved off the front end the stack will contain something like syscall(move) ghost_thread.  If the ghost was created by forking on the slave node, the stack won't have the syscall on it. 
It'll just have ghost_thread.  bproc_kernel_thread adds that bit of stack stuff so that the ghost_thread_function looks like it was called from syscall.

Another important difference is that it passes a pointer to struct pt_regs so that the ghost thread can setup registers for the user space process.  The pt_regs are placed on the stack so that the syscall return code will find them and restore them.
-----------------------------------------------------

The Bproc's own kernel thread function(for i386) is below:

---------------------------------------------
/*
 * 1 - it does not force a CLONE_VM on you
 * 2 - it simulates syscall entry on the child by setting
 *     aside room for a struct pt_regs.  A pointer to this is
 *     the first argument to the child.  This way, the child can
 *     fill in the regs and "return" to user space if it wants to.
 */
                                                                                                                             
/*
 * This gets run with %ebx containing the
 * function to call, and %edx containing
 * the "args".
 */
void bproc_kernel_thread_helper(void);
__asm__(
".align 4\n"
"bproc_kernel_thread_helper:\n"
                                                                                                                             
/* Move our stack pointer so that we have a struct pt_regs on the
 * stack and nothing else.
 *
 * 8132 = 8k (stack size) - 60 (struct pt_regs size)
 */
"    movl  %esp, %eax                            \n"
"    andl $-"__stringify(THREAD_SIZE)",   %eax   \n"
"    addl $"__stringify(THREAD_SIZE)"-60, %eax   \n"
"    movl  %eax, %esp                            \n"
                                                                                                                             
"    pushl %edx             \n" /* arg2 = user pointer */
"    pushl %eax             \n" /* arg1 = pointer to regs */
"    call *%ebx             \n" /* call func */
"    addl  $8, %esp         \n" /* pop args */

"    movl  %esp, %ebx       \n" /* Store EAX to return to user space */
"    movl  %eax, 0x18(%ebx) \n" /* Set EAX to return to process */
                                                                                                                             
/* syscall_exit requires thread_info pointer in ebp */
"    movl  %esp, %ebp                            \n"
"    andl $-"__stringify(THREAD_SIZE)", %ebp     \n"
"    jmp syscall_exit                            \n"
);
                                                                                                                             
/*
 * Create a kernel thread
 */
int bproc_kernel_thread(int (*fn)(struct pt_regs *, void *),
                        void * arg, unsigned long flags)
{
        struct pt_regs regs;
                                                                                                                             
        memset(&regs, 0, sizeof(regs));
                                                                                                                             
        regs.ebx = (unsigned long) fn;
        regs.edx = (unsigned long) arg;
        regs.ecx = flags;
                                                                                                                             
        regs.xds = __USER_DS;
        regs.xes = __USER_DS;
        regs.orig_eax = -1;
        regs.eip = (unsigned long) bproc_kernel_thread_helper;
        regs.xcs = __KERNEL_CS;
        regs.eflags = 0x286;
                                                                                                                             
        /* Ok, create the new process.. */
        return do_fork(flags, 0, &regs, 0, NULL, NULL);
}
-------------------------------------------------

> Now, let's take a call to
> kernel_thread from the initial thread, before init is executed, or a similar 
> situation (ksoftirqd and such things must surely be kernel_thread'ed from 
> somewhere). Where should it continue? Neither in kernel code because it's now 
> hidden (or it should be, anyhow this isn't supposed to work), nor in 
> userspace code because no one has been specified.

> Now, surely, there are cases where a userspace context will exist. For
> instance, modprobe <some module spawning a kernel thread in initialization>, 
> or mount ext3/reiserfs fs. In both cases, the kernel code will spawn a kernel 
> thread; but the userspace caller will already have continued with the system 
> call return code when the kernel thread exits (or, probably, the caller will 
> have died).

Sorry, I don't want to substitude the original UML kernel_thread function. I just create a new one with the name bproc_kenel_thread, which will be called by Bproc in UML just like Bproc in i386. So UML programs which will call kernel thread still call the original UML kernel thread. Sorry for my unclear words...

I know in UML tt mode, process fork/clone and kernel thread are handled differently. In copy_thread_tt, I found process forking will call fork_tramp and finish_fork_handler while kernel thread will call new_thread_proc and new_thread_handler. 

In UML, I think the forked child process will also return to user space like in i386 ret_from_fork. So I used finish_fork_handler for reference and modified new_thread_handler to create the bproc_new_thread_handler. My purpose is that in bproc_new_thread_handler the new created kernel thread will return to the user space rather than exit. 

In UML,I found in finish_fork_handler, set_user_mode is called at last. I think it's purpose is to let the new forked process go to the user space like ret_from_fork in i386. So I add the set_user_mode in bproc_new_thread_handler after run_kernel_thread to let the kernel thread also go to the user space. I Also create the sigcontext for the bproc kernel thread like forking in copy_thread_tt.

But currently there is the segmentation fault problem as I mentioned in my last mail. Any ideas? Thanks a lot!

Alex




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id492&op�k
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
