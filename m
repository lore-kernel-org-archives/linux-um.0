Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EBzkD-0002b6-J8	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Sep 2005 12:01:33 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EBzkB-00018z-3V
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 04 Sep 2005 12:01:33 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200509041702.18506.blaisorblade@yahoo.it>
Subject: [uml-devel] SYSEMU getting merged - but I'm in doubt
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
Date: Sun, 4 Sep 2005 17:02:18 +0200
To: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, "Charles P. Wright" <cwright@cs.sunysb.edu>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Ok, SYSEMU has been in -mm during 2.6.13 development and is now being merged 
in mainline, without many problems - it should be in Linus's git repository.

However, the point is that *I* have a problem with its current API.

Charles P. Wright expressed interest in using the interface, on private mail, 
however had problems with it - and actually, I cannot disagree with him, 
because the current API happened to be just "use the 2.4 API, and be 
compatible bug-to-bug".

When we intercept a syscall entry, we go to the trouble of saving the current 
kind of tracing (whether SYSEMU or SYSCALL) and then using it after notifying 
the ptracer. There's no actual need to do that, except compatibility with 
2.4, and I'd like to rip it out entirely.

Charles needs to check the syscall type before deciding whether to emulate it 
or not (he says he's working on a filesystem project, so I guess that he 
wants to intercept only some filesystem-related calls).

For UML, if we switch the syscall interception type, we can switch 
interception type one stop later.

I.e., if the user switches to SYSCALL, we resume the process still with 
SYSEMU, then at next stop we use SYSCALL. There's no increase in the number 
of system calls of or context switches.

Actually, /proc/sysemu is just a debugging toy, and supporting it is not that 
important (even if this helps excercising the code, i.e. finding those subtle 
bugs on switching).

Now, the point is: should I ask Linus to drop it for now, clean the interface, 
and resend the cleaned up one, with different ptrace call codes?

The changes aren't that big (a couple of lines), and UML can even keep 
supporting the old interface with a not-so-big cost (apart that 
if /proc/sysemu is not used, UML doesn't care which interface is used).

On the host side, instead, supporting both the broken API and the new one is 
more difficult.

What's your opinion on this? The options are:
1) merge it as-is
2) take it back for now, fix it and merge it for 2.6.15.

And then

2a) drop the trick, and avoid changing ptrace call numbers. Old UMLs will run 
fast, but crash with /proc/sysemu (only root-accessible).

2b) drop the trick and change the ABI - old UMLs will become slower, newer 
ones will support both things, and there will be no "same ABI but different 
behaviour" case.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
