Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DywP1-0002Bg-Qu	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2005 11:49:43 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1DywOy-0003Qb-0z
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2005 11:49:44 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507302134.20394.blaisorblade@yahoo.it>
Subject: [uml-devel] Fwd: Re: [patch 1/4] UML Support - Ptrace: adds the host
	SYSEMU support, for UML and general usage
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
Date: Sat, 30 Jul 2005 21:34:20 +0200
To: user-mode-linux-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>



----------  Forwarded Message  ----------

Subject: Re: [patch 1/4] UML Support - Ptrace: adds the host SYSEMU support, 
for UML and general usage
Date: Wednesday 27 July 2005 20:40
From: Blaisorblade <blaisorblade@yahoo.it>
To: "Charles P. Wright" <cwright@cs.sunysb.edu>
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, Jeff Dike 
<jdike@addtoit.com>

On Wednesday 27 July 2005 19:19, Charles P. Wright wrote:
> Paolo,
>
> I'm also using ptrace to emulate system calls for a file system project
> that I'm working on, so needless to say this patch is quite interesting
> for me.
>
> However, I'm not quite sure how the user-level interface is
> supposed to work from the comments.
>
> Normally the flow looks something like the following:
>
> pid = wait();  	/* To trap the syscall entry. */
> if (emulation) {
> 	/* Set the eax value to something invalid. */
> }
> ptrace(PTRACE_SYSCALL, pid); /* Let the call execute. */
> pid = wait();  	/* To trap the syscall exit. */
> if (emualation) {
> 	/* Force a return value. */
> }
> ptrace(PTRACE_SYSCALL);	/* To go back to user code. */
>
> Ideally,
>
> I would like to do the following as I only emulate some of the
> system calls,

Hmm, yes, this is a problem in the current SYSEMU interface, if to be used in
this way.

> and from the code, it seems like I should be able to:
>
> pid = wait();  	/* To trap the syscall entry. */
> if (emulation) {
> 	/* Force a return value. */
> 	ptrace(PTRACE_SYSEMU, pid); /* Go back to user code */
> } else {
> 	ptrace(PTRACE_SYSCALL); /* Let the call execute. */
> 	pid = wait();  	/* To trap the syscall exit. */
> 	ptrace(PTRACE_SYSCALL); /* To go back to user code. */
> }
>
> The comment here seems to indicate the interface is different:
> +       case PTRACE_SYSEMU: /* continue and stop at next syscall, which
> will not be executed */
>
> That would indicate to me that we run SYSEMU to get stopped at the next
> entry, and that call won't be executed (before we even know what it is).

Ok, yes, this is true.

Currently, SYSEMU allows us to switch from SYSEMU to SYSCALL, but the
execution mode for a syscall is determined from which mode was used on
syscall entry; if you use PTRACE_SYSCALL after syscall entry, this syscall is
completed as usual, and next syscall will run as under PTRACE_SYSCALL.

Actually, as a general purpose patch this might be a bit broken, I have to
admit, but it was written for UML's usage at the beginning. On 2.4 it
provided this behaviour automatically, on 2.6 it was fixed to conform to the
same interface.

But I think this is fixable; for the patch itself it should be trivial, the
problem is supporting it in UML: whether the syscall is executed or not, is
determined from the return value of do_syscall_trace(); as easily seen in the
code, the return value is read on syscall entry, and reused even after
running the debugger.

Also, I'm not that happy to change again UML to support yet another
 interface, but if needed it may be done I hope.

I think that this may be basically fixed in UML by using the same syscall
interception even for completing the syscall... at no performance cost.

The only cost would be adding yet another startup test for this new feature -
however, it is greatly outweighted by mainline inclusion.

> Charles

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
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
