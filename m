Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C7Anj-00054w-Fu for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Sep 2004 03:44:43 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C7Ane-0006rb-3o for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Sep 2004 03:44:43 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] handle_trap - failed to wait at end of syscall
References: <200408120541.i7C5faJd010923@ccure.user-mode-linux.org>
	<200409132139.33256.blaisorblade_spam@yahoo.it>
	<200409132214.i8DMEwL7003829@ccure.user-mode-linux.org>
In-Reply-To: <200409132214.i8DMEwL7003829@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409141241.21480.blaisorblade_spam@yahoo.it>
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
Date: Tue, 14 Sep 2004 12:41:20 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Joe Marzot <gmarzot@nortelnetworks.com>

On Tuesday 14 September 2004 00:14, Jeff Dike wrote:
> blaisorblade_spam@yahoo.it said:
> > However, it is not possible nor desirable to do this in CATCH_EINTR -
> > retry if  errno == EINTR is a general rule valid in every Unix program
> > ever, while this  is very specific to this call.
> >
> > do {
> >    CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
> > } while (WIFSTOPPED(status) && (STOPSIG(status) == SIGHUP))
>
> I'd still like to understand exactly what's going on here.  UML interprets
> a SIGHUP to itself as a "shut down now" command, while it should not see
> SIGHUP from a terminal going away.
>
> Figuring out why it is should point us at the correct fix.

Well, I've a situation where I consistently get SIGSEGV instead of SIGHUP 
here, but only on 2.6 host. The scenario is to do "echo 0 > /proc/sysemu". 
You can test that with 2.6.9-rc2 or with 2.6.7-bb6 (both include /proc/sysemu 
support).

The problem (at least in my scenario) is that the signal in 2.4 is delivered 
only to the kernel thread, while on 2.6 (for some reason) it is delivered 
first to the userspace thread. You too mentioned 2.6 signal delivery changes 
as the reason for some fixes.

So, Joe, since you can get this panic consistently, could you try reproducing 
the scenario on a 2.4 host kernel? I guess you shouldn't be able, but I could 
be wrong. Also, a 2.4 RH kernel does not qualify as a true 2.4 host kernel, 
since it contains some NPTL code - if you can, try just a 2.4 vanilla + SKAS.

About the fix, most signals get delivered to all threads, so we can probably 
safely ignore them when received through waitpid(). But Ulrich Drepper says 
here:
 
http://people.redhat.com/drepper/posix-signal-model.xml

that SIGSEGV should be delivered only to the generating thread; the document 
lists changes to be done to Linux, so maybe this is implemented in 2.6 and 
not in 2.4. However, OTOH, he also says that signal handlers are 
process-wide, so we should be safe anyway. And anyway, the code works 
perfectly on 2.4 hosts.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
