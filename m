Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CubWc-00069g-6B for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Jan 2005 11:11:22 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CubWX-0007Zm-Vl for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Jan 2005 11:11:22 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
References: <003e01c503b3$f3e46cb0$ac655e0a@sha.st.com>
In-Reply-To: <003e01c503b3$f3e46cb0$ac655e0a@sha.st.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200501282010.50020.blaisorblade@yahoo.it>
Subject: [uml-devel] Explaination of system call function flow in TT mode
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
Date: Fri, 28 Jan 2005 20:10:49 +0100
To: Alex LIU <alex.liu@st.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wednesday 26 January 2005 15:33, Alex LIU wrote:
> Hi,Blaisorblade:

> I have studied the TT mode of UML source code 2.6.7 for some time.But I
> still can't work out the system call function flow in TT mode.I have read
> some documents and comments on that but all of them are very rough...

> Is there any more detailed document about the system call function flow in
> UML TT mode?(had better to the function level)
I don't know if the slides on the main site could be of help for you (I don't 
think so, but you might try).

However, I've decided to post a thorough description of the flow to the list 
and to you... To be correct, I've studied the source while writing this 
mail... I had a rough idea of what happens, I just didn't dig enough to 
discover all details because I didn't need it yet.

First study man 2 ptrace, especially about PTRACE_SYSCALL.

However, the core mechanism is that tracer() ptrace()s the child:

(around line 235 of 
arch/um/kernel/tt/tracer.c, sorry but references are from around 2.6.9, it 
should not be too difficult).

        while(1){ //this is executed for the whole lifetime of the child.
                CATCH_EINTR(pid = waitpid(-1, &status, WUNTRACED));
...
                else if(WIFSTOPPED(status)){
...
                        sig = WSTOPSIG(status);
...
                        switch(sig){

 and when the tracee executes a syscall, as explained in ptrace docs, 
waitpid() will return that the child was stopped by a SIGTRAP, so we get 
here:

                        case SIGTRAP: //this has changed in recent kernels to 
                        case (SIGTRAP + 0x80):

do_syscall is called, and then this is done:

                                sig = SIGUSR2;
                                tracing = 0;
... after, this saves the new tracing value inside "task", which is a struct 
task_struct.

                       set_tracing(task, tracing);


afterwards, the set value of sig is used so:

//cont_type is normally set to PTRACE_SYSCALL, but since now tracing == 0, it 
will be PTRACE_CONT.

                       if(ptrace(cont_type, pid, 0, sig) != 0){
   }

and this makes sure with ptraces that the child sees a SIGUSR2 signal when 
resuming. (it's not done through kill(), see sig = SIGUSR2 and the ptrace() 
call near the end using it.) Since the signal is sent this way, it will be 
received and handled by the child thread. Now, we are resuming with 
PTRACE_CONT, because we are going to execute the UML code which will handle 
the syscall, so we don't want syscalls to be intercepted.

Then, the SIGUSR2 signal handler is invoked (it's sig_handler_common_tt which 
calls sig_info[SIGUSR2]-> handler, i.e. usr2_handler). It will call 
syscall_handler_tt, which will do the syscall execution (with tracing turned 
off) and saves the actual result (through SC_SET_SYSCALL_RETURN(sc, result), 
which manipulates the saved registers, specifically the value which will be 
stored back in EAX).

Finally, to switch back to the user mode, during the return path of  
sig_handler_common_tt(), set_user_mode(NULL) is called; if it sees that 
tracing is 0 (what it reads is the value set by set_tracing()) it sends a 
SIGUSR1 signal:

int set_user_mode(void *t)
{
        struct task_struct *task;

        task = t ? t : current;
        if(task->thread.mode.tt.tracing)
                return(1);
        task->thread.request.op = OP_TRACE_ON;
        os_usr1_process(os_getpid()); /*this is a wrapper for the kill() to 
send the signal.*/
        return(0);
}

Now, this signal is handled by tracer(): in fact, the child (who gets the 
signal) is ptraced, so the ptracer can examine each signal and decide what to 
do. (Above, for SIGUSR2, we said there was an exception, but it happened 
because the signal was sent using ptrace()).

Here is the piece of code:

                        switch(sig){
                        case SIGUSR1:
                                sig = 0; // so the child won't see the signal.
                                op = do_proc_op(task, proc_id);
                                switch(op){
                                case OP_TRACE_ON:
                                        arch_leave_kernel(task, pid);
                                        tracing = 1;
                                        break;

As you see, tracing is switched back to 1, so at the end this iteration we 
will resume the child with PTRACE_SYSCALL in user mode... and he will see the 
syscall return value. I hope I didn't miss anything.

> Thanks a lot!

> Alex
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
