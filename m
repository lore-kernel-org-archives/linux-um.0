Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CwmpB-0006Xu-QD for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Feb 2005 11:39:33 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Cwmp6-0005rj-V1 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Feb 2005 11:39:33 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] RE: Explaination of system call function flow in TT
	mode
References: <021201c5093c$0ec75780$ac655e0a@sha.st.com>
In-Reply-To: <021201c5093c$0ec75780$ac655e0a@sha.st.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502032038.37637.blaisorblade@yahoo.it>
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
Date: Thu, 3 Feb 2005 20:38:36 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Alex LIU <alex.liu@st.com>

On Wednesday 02 February 2005 16:29, Alex LIU wrote:
> Hi,Blaisorblade. You wrote:
> >do_syscall is called, and then this is done:
> >
> >                                sig = SIGUSR2;
> >                                tracing = 0;
> >... after, this saves the new tracing value inside "task", which is a
> > struct task_struct.
> >
> >                       set_tracing(task, tracing);
Pre-question: I hope for you that you use a ctags/etags enabled editor (or at 
least LXR) to help in source browsing, otherwise you'll get lost.

There is more than one good introduction about ctags (which is supported at 
least by Vim and Emacs, and maybe even by Kate).

> But what's the exact meaning of the task in the tracer function? It is
> defined as:
>
>  task = cpu_tasks[proc_id].task
>
> Is it the task struct of the traced thread?

Yes, it is... proc_id is the ID of the virtual processor (it will be always 0 
on a uniprocessor UML instance). 

If you look at the comment before that line (when it is re-executed) and at 
do_proc_op(), you'll see that when doing an exec the host process is changed.

> What's the difference between "task->pid" and
> "task->thread.mode.tt.extern_pid"?

> I know in TT mode every thread in UML 
> will has a corresponding thread in host.

Yes, and while task->pid (which is a field also existing in i386 Linux) is the 
pid you see inside UML for that task, extern_pid is the pid of the matching 
host thread.

> But I don't know the exact 
> relationship between them.

It's 1-1 I think, and the code does not show sign of working otherwise (even 
if, probably, it could be changed to make sure that multiple threads have 
only one corresponding host thread)...

I don't know the relation between tracer() running instances and childs... in 
SKAS mode, the scheduler does a context switch (through sigsetjmp() / 
siglongjmp()) between multiple tracers (i.e. ; when  a new tracer is 
scheduled inside UML, it makes the host process switch to the right thread 
and execute it.

Instead, in TT mode there is just one tracer, which does a waitpid() on every 
thread... a process is scheduled away by making it wait on a pipe 
(task->thread.mode.tt.switch_pipe[]).

> And I didn't found how UML creat the 
> corresponding thread in host.

To create a process (with fork(), vfork() or clone()) the do_fork() call is 
executed with appropriate flags...

The arch-dependent hook for the process creation is copy_thread()... and 
copy_thread_tt() calls start_fork_tramp() which creates the host thread with 
clone (actually with 2 clone calls, I dunno why) and returns the pid of the 
newly created thread, which is then assigned inside copy_thread to 
task->.....extern_pid.

Also notice the messages sent with SIGUSR1 named by OP_* (OP_FORK, OP_EXEC...)
> Thanks a lot!
Well, this was also an occasion to learn these things myself (I didn't need 
understanding it in detail until now since I've not been working on TT code, 
I had a feeling of what happened), so thanks to you.

Regards
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
