Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CDC9X-0004yA-Ia for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Sep 2004 18:24:07 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CDC9J-000638-Tf
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 30 Sep 2004 18:24:07 -0700
Message-Id: <200410010230.i912UCqR004674@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Signal handling: signal mask incorrect after segfault
In-Reply-To: Your message of "Thu, 30 Sep 2004 16:31:37 +0200."
	<8B6FF516CBA0194AB0996705076B02520F7C3E@ABGEX01E.abg.fsc.net> 
References: <8B6FF516CBA0194AB0996705076B02520F7C3E@ABGEX01E.abg.fsc.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Thu, 30 Sep 2004 22:30:12 -0400
To: "Stroesser, Bodo" <Bodo.Stroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

Bodo.Stroesser@fujitsu-siemens.com said:
> If the user stack limit is reached or the signal stack assigned with
> sigaltstack() is invalid when a user signal handler with SA_ONSTACK
> has to be started, the signal mask of the interrupted user program is
> modified. This happens because the mask, that should be used with the
> handler only, is written to "current->blocked" even if the handler
> could not be started. But without a handler, no rewrite of the
> original mask at sys_sigreturn will be done.

I don't see where current->blocked is modified up to that point.  It looks 
like this could be fixed by checking err in the !SA_DEFER case:

	if (!err && !(ka->sa.sa_flags & SA_NODEFER)) {

> A slightly different case
> is sys_sigsuspend(), where the mask is already modified when
> kern_do_signal() is started. "*oldset" and "current->blocked" are not
> equal here and thus current->blocked has to be set to *oldset, if an
> error occurs in handle_signal(). For both cases I've written small
> tests, and with the patch the result is OK. 

The existing code looks OK to me.  If there's an error writing the signal
frame, then it will get a SIGSEGV.  If that is caught (and somehow succeeds,
like it's going to a good stack), and it returns, then that's where your
sigreturn and mask restoration is going to happen.

If none of the above happen, then the process is dead meat, of course.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
