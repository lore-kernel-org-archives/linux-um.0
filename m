Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Tom Hughes <thh@cyberscience.com>
Subject: Re: [Valgrind-users] Re: [uml-devel] Re: UML and valgrind 
Message-ID: <2b464bd94c.work@loxley.compton.nu>
References: <C28780ABC637504896EB86B4FB75FFBFA26E5E@MAANDMBX1.ets.enterasys.com>
	<410EFCDB.8080404@enterasys.com> 
	<200408030517.i735HZUE026250@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031028541.22157@hermes-1.csi.cam.ac.uk> 
	<200408031450.i73EoEvv002040@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031527320.22157@hermes-1.csi.cam.ac.uk> 
	<200408031750.i73HoMvv002966@ccure.user-mode-linux.org>
	<410FCC70.1050902@enterasys.com>
	<200408031931.i73JVkvv003367@ccure.user-mode-linux.org> 
	<yek3c33tk5o.fsf@audi.uk.cyberscience.com>
	<20040804153541.GA7237@ccure.user-mode-linux.org>
	<yekacxbrlvi.fsf@audi.uk.cyberscience.com> 
	<200408041800.i74I0Nvv007667@ccure.user-mode-linux.org>
In-Reply-To: <200408041800.i74I0Nvv007667@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Wed, 04 Aug 2004 18:57:15 +0100
To: jdike@addtoit.com
Cc: dbahi@enterasys.com, njn25@cam.ac.uk, user-mode-linux-devel@lists.sourceforge.net, valgrind-users@lists.sourceforge.net, jdike@sonycom.com

In message <200408041800.i74I0Nvv007667@ccure.user-mode-linux.org>
          Jeff Dike <jdike@addtoit.com> wrote:

> thh@cyberscience.com said:
> > Even doing that (if it's still possible) is quite dangerous as that
> > thread could accidentally damage valgrind's environment.
> 
> So?  It's also quite dangerous as that thread could damage another thread's
> environment.  That's the nature of multithreaded apps.

The problem is that the virtual environment seen by a program running
under valgrind may not be the same as the real environment - things like
signal handlers, signal masks, resource limits and son. That might be
confusing for the thread that isn't running under valgrind and might
even lead to that thread damaging the process state. I'm not saying
it will happen, just that it's something to beware of.

> > That would imply that the newly created thread was left to run on the
> > real CPU rather than the simulated CPU. If that's the case then I'm
> > not that it is possible anymore - I know we had to take out the stuff
> > that allowed valgrind to switch back to the real CPU after running a
> > specified number of basic blocks because it could no longer be made to
> > work.
> 
> We're not talking about a thread switching back and forth between the real
> CPU and the simulated one.  We're talking about a thread being created on
> the real CPU and staying there.

It's still switch from the simulated CPU to the real CPU though - the
thread of control arrives at the clone and then branches with one
branch continuing on the real CPU and one on the simulated CPU. That
sounds to me just the same (for the new thread) as the existing thread
of control continuing on the real CPU.

You probably really need Jeremy's thoughts on the matter - he's more
up on this stuff and I think he was involved in dropping the support
for switching back to the real CPU.

Tom

-- 
Tom Hughes (thh@cyberscience.com)
Software Engineer, Cyberscience Corporation
http://www.cyberscience.com/


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
