Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CDKDg-0004wu-4K for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Oct 2004 03:00:56 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CDKDI-0001mZ-K0 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Oct 2004 03:00:56 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [uml-devel] Signal handling: signal mask incorrect after segfault
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C43@ABGEX01E.abg.fsc.net>
From: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
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
Date: Fri, 1 Oct 2004 11:53:59 +0200
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

> Bodo.Stroesser@fujitsu-siemens.com said:
> > If the user stack limit is reached or the signal stack assigned with
> > sigaltstack() is invalid when a user signal handler with SA_ONSTACK 
> > has to be started, the signal mask of the interrupted user program
is 
> > modified. This happens because the mask, that should be used with
the 
> > handler only, is written to "current->blocked" even if the handler 
> > could not be started. But without a handler, no rewrite of the 
> > original mask at sys_sigreturn will be done.
> 
> I don't see where current->blocked is modified up to that point.  It
looks like this could be fixed by checking err in the !SA_DEFER case:
> 
> 	if (!err && !(ka->sa.sa_flags & SA_NODEFER)) {

Yes. That is, what the patch does. It uses:

if (err) {
}
else if (!(ka->sa.sa_flags & SA_NODEFER)) {

> > A slightly different case
> > is sys_sigsuspend(), where the mask is already modified when
> > kern_do_signal() is started. "*oldset" and "current->blocked" are
not 
> > equal here and thus current->blocked has to be set to *oldset, if an

> > error occurs in handle_signal(). For both cases I've written small 
> > tests, and with the patch the result is OK.
> 
> The existing code looks OK to me.  If there's an error writing the
signal frame, then it will get a SIGSEGV.  If that is caught (and
somehow succeeds, like it's going to a good stack), and it returns, then
that's where your sigreturn and mask restoration is going to happen.

No. sys_sigsuspend() modifies current->blocked before calling
kern_do_signal(). Because of that, it takes a copy of the original mask
and passes it to kern_do_signal(). This mask has to be restored by the
signal handler at sys_sigreturn. But if an error occurs, the handler
will not be started and the mask will not be restored. Then
kern_do_signal returns to sys_sigsuspend() with the wrong mask set,
sys_sigsuspend() returns (the original mask is lost at that moment) and
the SIGSEGV-handler is started later when passing interrupt_end(), which
calls do_signal() again. The SIGSEGV handler doesn't even see the real
"original mask", because do_signal() now calls kern_do_signal() with
current->blocked as oldset, which is the mask modified by
sys_sigsuspend(). So I believe, handle_signal() should restore the
original mask if setup_signal_stack_XX() returns an error. (For the
first case I described, this is a NOOP.)

On the other hand: with the patch "deliver segfault immediately"
applied, this is redundant, because the "oldset" used to build the next
handler's stack frame will be the same as before, as kern_do_signal()
doesn't return after an error. At least a handler for SIGSEGV will be
started and it will restore the mask, or the process will die.

> 
> If none of the above happen, then the process is dead meat, of course.
> 
> 				Jeff

Bodo


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
