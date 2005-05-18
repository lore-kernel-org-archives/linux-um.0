Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYT9o-0005Lo-QJ	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 11:20:36 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DYT9i-0001Xq-Na	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 May 2005 11:20:36 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200505182019.52676.blaisorblade@yahoo.it>
Subject: [uml-devel] Saving a signal delivery to improve fork() performance in
	SKAS mode
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
Date: Wed, 18 May 2005 20:19:52 +0200
To: Jeff Dike <jdike@addtoit.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Currently, for what I can see in SKAS code (better say I can't, since the code 
is quite convolute) for each do_fork() call, we need a (slow) signal 
delivery, and that is needed only to place the new stack on the allocated 
memory. In fact, this affects fork() performance, which is what makes us so 
slow when executing shell scripts, together with execve().

We can verify the latter is slow through UnixBench, and for the former there 
are the Xen microbenchmarks.

We end the signal handler with either do_exit(0) (in case of a kernel thread) 
or userspace (which never returns), so the "signal handler invocation" is 
just a costly jump (not even a call).

It's maybe true also in TT mode but I've not investigated a lot.

Can't we do that more roughly? An idea is this:

- save the stack address in one register, the target IP address into another;
- jmp (not call) a routine which sets ESP to the new value, and jumps where 
needed
(maybe the first jmp can even be removed and the routine be inlined, I don't 
remember why I complicated things)
- do what's needed (i.e. call the handler which then calls userspace(), which 
never returns).

The handler will work fine that way I think: a thread_wait(), which does not 
need anything saved on the stack. Nor I think sigsetjmp can have difficult 
requirements on the stack it runs onto (but it's to verify).

About setjmp: looking at the definitions in the header (and looking at the 
actual code), it simply saves/restores six registers, i.e. PC (EIP), ESP and 
EBP, EBX, ESI and EDI, and then does a call to sigprocmask into jmp_buf.

Below, a description of what happens during copy_thread_skas.

After copy_thread_skas->new_thread->new_thread_proc, we go running on the 
signal stack, and we (fork_handler or new_thread_handler), through 
thread_wait(), longjmp to the fork_buf on the father's stack (inside 
new_thread), which is saved in current->thread.fork_buf;

new_thread then disables the signal stack and returns to the caller (i.e. the 
forking thread), which can continue;

btw, this way it frees the switch_buf value it saved in current->thread; 
luckily, it's actually unused because it's replaced by the one inside 
thread_wait(), which is on the new stack.

Actually, this "sigjmp" scheme does not seem to be too overloaded and 
simplifiable, after understanding it.

Finally, the newly created thread is suspended during thread_wait is then 
resumed by the scheduler's call to switch_to that jumps in there.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
