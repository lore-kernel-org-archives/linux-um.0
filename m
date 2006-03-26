Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FNaVC-0002GA-1D for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Mar 2006 11:02:14 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FNaVB-0003kb-4m
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 26 Mar 2006 11:02:14 -0800
Content-Disposition: inline
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200603262003.58195.blaisorblade@yahoo.it>
Subject: [uml-devel] Fwd: Re: Why uml-add-tls-support-debug-check-never-works
	is needed (was: Re: Fwd: Proposed additions to the ptrace(2)
	manpage, take 2)
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
Date: Sun, 26 Mar 2006 20:03:57 +0200
To: user-mode-linux-devel@lists.sourceforge.net



----------  Forwarded Message  ----------

Subject: Re: Why uml-add-tls-support-debug-check-never-works is needed (was: 
Re: Fwd: Proposed additions to the ptrace(2) manpage, take 2)
Date: Sunday 26 March 2006 19:43
From: Blaisorblade <blaisorblade@yahoo.it>
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@projects.sourceforge.net

On Saturday 25 March 2006 02:17, Jeff Dike wrote:
> On Sat, Mar 25, 2006 at 12:28:09AM +0100, Blaisorblade wrote:
> > BUT, this context switch at the thread born is special: the thread being
> > switched away switches to a new thread not in the body of the new
> > thread's call to switch_to_skas->switch_threads(), but in the body of
> > thread_wait()! At that point, we lose the call to arch_switch_to_skas()!
>
> Yuck yuck yuck.  Nice spotting.
>
> There's an obvious one-line fix for this, but I wonder if we ought to
> try some restructuring to avoid this sort of thing in the future.

Code which two people aren't able to understand until two years later _wants_
at least some comments and if possible restructuring. The problem is how, and
I'm not looking at the code right now. Off the top of my head, I get only
silly ideas, since we can't join the end of switch_to_skas() and
fork_handler().

> > Questions and notes:
> >
> > *) Why does arch/um/os-Linux/skas/process.c has still one siglongjmp()
> > call and sigjmp_buf vars, and that has no comments?
>
> I'm tempted to say that I just missed the call somehow.  I see no
> reason for that to be different, especially since it's preceded by a
> UML_SIGSETJMP.  As for the sigjmp_buf variables, I don't get your
> point.  Those haven't changed.

I didn't study softints, but setjmp() is supposed to use jmp_buf's, not
sigjmp_buf's (I know they are (almost) equal in the glibc headers I've seen,
but that equality is not guaranteed).

The fact that the code compiles without warnings can be seen as a bug in
 glibc headers.

> > *) Also, why thread_wait and thread_switch are almost identical, yet
> > they're two different functions?
>
> switch_threads?  In order to merge them, you'd have to pass in the 1
> and the INIT_JMP_REMOVE_SIGSTACK, which I have conceptual problems
> with.  First, that makes the callers know things that they probably
> shouldn't.

If you don't pass 1 and INIT_JMP_REMOVE_SIGSTACK but two further defines like
"JUMP_TO_INITIAL_THREAD" and "JUMP_BACK" (or actually meaningful names) the
caller won't know more than it knows now. Or you can keep the callers intact
- just by making switch_threads() and thread_wait() two inline wrappers.

> Second, the 1 and the INIT_JMP_REMOVE_SIGSTACK have
> completely different meanings.  One is a message to the initial thread
> that it has to do something.  The 1 is a message to setjmp that is has
> been longjmp-ed to.

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

-------------------------------------------------------

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
