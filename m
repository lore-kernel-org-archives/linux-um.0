Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPTzM-0006WU-85 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 14:52:24 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CPTzK-00026i-C7 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 14:52:24 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to
	kill host-OS processes (take #2)
References: <20041103113736.GA23041@taniwha.stupidest.org>
	<200411032028.44376.blaisorblade_spam@yahoo.it>
	<20041103200930.GA10669@taniwha.stupidest.org>
In-Reply-To: <20041103200930.GA10669@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411032351.14860.blaisorblade_spam@yahoo.it>
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
Date: Wed, 3 Nov 2004 23:51:14 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Chris Wedgwood <cw@f00f.org>, Jeff Dike <jdike@addtoit.com>, Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>, Gerd Knorr <kraxel@bytesex.org>

On Wednesday 03 November 2004 21:09, Chris Wedgwood wrote:
> On Wed, Nov 03, 2004 at 08:28:44PM +0100, Blaisorblade wrote:
> > I'm going to test this.
>
> please do
The Gerd / mine patch seem to work nicely. No thread is left over.

> > I thought that Gerd Knorr patch (which I sent cc'ing LKML and most
> > of you) already solved this (I actually modified that one, replacing
> > his SIGCONT kill()ing with a PTRACE_KILL, but I did this in the
> > places he identified).

> it might, i'm going to check soon

> what worries me is that two very different code paths might be fixing
> the same problem which makes me think the flow of execution here is
> very vague and needs cleaninng up

Yes, but the cleanup should first be revierwed by Jeff Dike and put in his 
tree. I too don't understand the code. Don't CC Andrew on the first release 
of the cleanup at least.

To go to the actual fact, the code path I'm fixing didn't exist till a few 
releases ago.

Follows is the patch containing this fix against 2.4.27, with the changelog, 
from Jeff Dike.

This fixes a use-after-free bug in the context switching.  A process going out
of context after exiting wakes up the next process and then kills itself.  The
problem is that when it gets around to killing itself is up to the host and
can happen a long time later, including after the incoming process has freed
its stack, and that memory is possibly being used for something else.

The fix is to have the incoming process kill the exiting process just to
make sure it can't be running at the point that its stack is freed.

 um-linux-2.4.27-paolo/arch/um/kernel/tt/process_kern.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletion(-)

diff -puN arch/um/kernel/tt/process_kern.c~scheduler 
arch/um/kernel/tt/process_kern.c
--- um-linux-2.4.27/arch/um/kernel/tt/process_kern.c~scheduler  2004-11-02 
11:12:28.805815264 +0100
+++ um-linux-2.4.27-paolo/arch/um/kernel/tt/process_kern.c      2004-11-02 
11:12:28.807814960 +0100
@@ -25,7 +25,7 @@

 void *_switch_to_tt(void *prev, void *next)
 {
-       struct task_struct *from, *to;
+       struct task_struct *from, *to, *prev_sched;
        unsigned long flags;
        int err, vtalrm, alrm, prof, cpu;
        char c;
@@ -67,6 +67,17 @@ void *_switch_to_tt(void *prev, void *ne
        if(err != sizeof(c))
                panic("read of switch_pipe failed, errno = %d", -err);

+       /* If the process that we have just scheduled away from has exited,
+        * then it needs to be killed here.  The reason is that, even though
+        * it will kill itself when it next runs, that may be too late.  Its
+        * stack will be freed, possibly before then, and if that happens,
+        * we have a use-after-free situation.  So, it gets killed here
+        * in case it has not already killed itself.
+        */
+       prev_sched = current->thread.prev_sched;
+       if(prev_sched->state == TASK_ZOMBIE)
+               os_kill_process(prev_sched->thread.mode.tt.extern_pid, 1);
+
        /* This works around a nasty race with 'jail'.  If we are switching
         * between two threads of a threaded app and the incoming process
         * runs before the outgoing process reaches the read, and it makes

> also, check your return values for errors --- i bet you will see
> some. 

That is a separate, on-top of this patch.

> os_kill_process has this problem too --- many invocations of it 
> are pointless and fail, especially those from relase_thread_tt (i need
> to check the details here, this is all from memory and im getting old)

> > I guess that old_pid should either already be dead there or going to
> > die after a little, but I'm going to check (after I get UML to run
> > in the current snapshot...)

> it should build pretty close to as-is, if not let me know and i'll
> sent you what i have
No problem actually in UML, the build environment instead is very complicate. 
It refuses to work with NPTL, so I must build it in my old Mandrake chroot 
(it was a distro, now I keep it just for compilation).

Now, I must also run it on the Gentoo, or it gives problems... however, don't 
worry.

I'm also going to merge some patches (21 it should be).
Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
