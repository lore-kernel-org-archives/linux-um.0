Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DtMzk-0000w9-FC	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jul 2005 03:00:36 -0700
Received: from lon-del-01.spheriq.net ([195.46.50.97])
	by sc8-sf-mx1.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1DtMzj-0000XJ-A9
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 15 Jul 2005 03:00:36 -0700
Received: from lon-out-01.spheriq.net ([195.46.50.129])
	by lon-del-01.spheriq.net with ESMTP id j6FA0N4c025549
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 15 Jul 2005 10:00:23 GMT
Received: from lon-cus-02.spheriq.net (lon-cus-02.spheriq.net [195.46.50.38])
	by lon-out-01.spheriq.net with ESMTP id j6FA0M3q009971
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 15 Jul 2005 10:00:22 GMT
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by lon-cus-02.spheriq.net with ESMTP id j6FA0FhL020983verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 15 Jul 2005 10:00:21 GMT
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id EE558DA4B
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 15 Jul 2005 10:00:12 +0000 (GMT)
Received: from zeta.dmz-ap.st.com (localhost [127.0.0.1])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3A0F5520CB
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 15 Jul 2005 10:00:12 +0000 (UTC)
Received: from mail1.sha.st.com (mail1.sha.st.com [10.94.100.2])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5334B132C9
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 15 Jul 2005 10:00:10 +0000 (GMT)
From: Alex LIU <alex.liu@st.com>
Message-ID: <001401c58923$f6dee2b0$9eb3c68a@SHZ.ST.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [uml-devel] Segmentation fault with kernel thread in UML-2.6.7 TT
	mode
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
Date: Fri, 15 Jul 2005 17:59:59 +0800
Content-Transfer-Encoding: 8bit
To: UML-dev <user-mode-linux-devel@lists.sourceforge.net>

Hi,all:

I just modified the kernel thread function in UML 2.6.7 tt mode. I want the kernel thread go to the user space after finished the kernel function rather than exit. It's just like a system call return or a return from fork...

But now the problem is that there will be segmentation fault just before the kernel thread go to the user space. After tracing I found when the segmentation fault occur, in handle_page_fault function, (!(vma->vm_flags & VM_GROWSDOWN)) is true and the err is -14. What's the meaning of such value?

I modified the new_thread_handler function with regarding to finish_fork_handler function. (also add pt_regs as a parameter of the kernel thread function)
My modified new_thread_handler function is following:
-------------------------------------------------------
static void new_thread_handler(int sig)
{
        unsigned long disable;
        int (*fn)(void *);
        void *arg;
        struct pt_regs *regs;
                                                                                                                             
        fn = current->thread.request.u.thread.proc;
        arg = current->thread.request.u.thread.arg;
                                                                                                                             
        regs = &current->thread.regs;
                                                                                                                             
        UPT_SC(&current->thread.regs.regs) = (void *) (&sig + 1);
        disable = (1 << (SIGVTALRM - 1)) | (1 << (SIGALRM - 1)) |
                (1 << (SIGIO - 1)) | (1 << (SIGPROF - 1));
        SC_SIGMASK(UPT_SC(&current->thread.regs.regs)) &= ~disable;                                                                                                                             
                                                                       
        suspend_new_thread(current->thread.mode.tt.switch_pipe[0]);
                                                                                                                             
        force_flush_all();
        if(current->thread.prev_sched != NULL)
                schedule_tail(current->thread.prev_sched);
        current->thread.prev_sched = NULL;
                                                                                                                             
        init_new_thread_signals(1);
        enable_timer();
                                                                                                                             
        change_sig(SIGVTALRM, 1);
        local_irq_enable();
        if(current->mm != current->parent->mm)
                protect_memory(uml_reserved, high_physmem - uml_reserved, 1,
                               1, 0, 1);
        task_protections((unsigned long) current_thread);
                                                                                                                             
                                                                                                                             
        free_page(current->thread.temp_stack);
        set_cmdline("(bproc kernel thread)");
                                                                                                                             
        change_sig(SIGUSR1, 1);
        change_sig(SIGPROF, 1);
                                                                                                                             
        if(!run_kernel_thread(fn, regs, arg, &current->thread.exec_buf)){
                local_irq_disable();
                change_sig(SIGUSR1, 0);
                set_user_mode(current);
        }
                                                                                                                             
        /* XXX No set_user_mode here because a newly execed process will
         * immediately segfault on its non-existent IP, coming straight back
         * to the signal handler, which will call set_user_mode on its way
         * out.  This should probably change since it's confusing.
         */
}
----------------------------------------------
For convenience,I also attached the original UML functions:

void finish_fork_handler(int sig)
{
        UPT_SC(&current->thread.regs.regs) = (void *) (&sig + 1);
        suspend_new_thread(current->thread.mode.tt.switch_pipe[0]);
                                                                                                                             
        force_flush_all();
        if(current->thread.prev_sched != NULL)
                schedule_tail(current->thread.prev_sched);
        current->thread.prev_sched = NULL;
                                                                                                                             
        enable_timer();
        change_sig(SIGVTALRM, 1);
        local_irq_enable();
        if(current->mm != current->parent->mm)
                protect_memory(uml_reserved, high_physmem - uml_reserved, 1,
                               1, 0, 1);
        task_protections((unsigned long) current_thread);
                                                                                                                             
        free_page(current->thread.temp_stack);
        local_irq_disable();
        change_sig(SIGUSR1, 0);
        set_user_mode(current);
}

static void new_thread_handler(int sig)
{
        unsigned long disable;
        int (*fn)(void *);
        void *arg;
                                                                                                                             
        fn = current->thread.request.u.thread.proc;
        arg = current->thread.request.u.thread.arg;
                                                                                                                             
        UPT_SC(&current->thread.regs.regs) = (void *) (&sig + 1);
        disable = (1 << (SIGVTALRM - 1)) | (1 << (SIGALRM - 1)) |
                (1 << (SIGIO - 1)) | (1 << (SIGPROF - 1));
        SC_SIGMASK(UPT_SC(&current->thread.regs.regs)) &= ~disable;
                                                                                                                             
        suspend_new_thread(current->thread.mode.tt.switch_pipe[0]);
                                                                                                                             
        force_flush_all();
        if(current->thread.prev_sched != NULL)
                schedule_tail(current->thread.prev_sched);
        current->thread.prev_sched = NULL;
                                                                                                                             
        init_new_thread_signals(1);
        enable_timer();
        free_page(current->thread.temp_stack);
        set_cmdline("(kernel thread)");
                                                                                                                             
        change_sig(SIGUSR1, 1);
        change_sig(SIGVTALRM, 1);
        change_sig(SIGPROF, 1);
        local_irq_enable();
        if(!run_kernel_thread(fn, arg, &current->thread.exec_buf))
                do_exit(0);
                                                                                                                             
        /* XXX No set_user_mode here because a newly execed process will
         * immediately segfault on its non-existent IP, coming straight back
         * to the signal handler, which will call set_user_mode on its way
         * out.  This should probably change since it's confusing.
         */
}
------------------------------------------------
I also modified the copy_thread_tt function and create the sigcontext for the kernel thread just like fork:
------------------------------------------------
         sc_to_sc(UPT_SC(&p->thread.regs.regs),
                UPT_SC(&current->thread.regs.regs));
         SC_SET_SYSCALL_RETURN(UPT_SC(&p->thread.regs.regs), 0);
         if(sp != 0) SC_SP(UPT_SC(&p->thread.regs.regs)) = sp;
------------------------------------------------

Any ideas? 
Thanks a lot!

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
