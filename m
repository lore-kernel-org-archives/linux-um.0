Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CDIVh-0000b5-8h for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Oct 2004 01:11:25 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CDIVW-0006YV-VI for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Oct 2004 01:11:25 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [uml-devel] Signal handling: deliver segfault immediately 
Message-ID: <8B6FF516CBA0194AB0996705076B02520F7C41@ABGEX01E.abg.fsc.net>
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
Date: Fri, 1 Oct 2004 10:10:52 +0200
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

> > -	if(sig > 0){
> > +	while ( (sig = get_signal_to_deliver(&info, &ka_copy, regs,
> > NULL)) ) {
> 
> This one makes me nervous.  I never checked that nesting signal frames
for multiple pending signals works, although the frame format is
identical, so it should.
> 
> Have you checked that?
> 
> 				Jeff
No, this will not produce nested frames.
If setup_signal_stack_XX() returns an error, no signal frame is
generated. But a new SIGSEGV signal is queued. Normally do_signal() is
called from interrupt_end(), so without the patch the user code will be
started next without any signal handler being delivered and the SIGSEGV
staying in queue! Call me pedantic, but I believe, that's not correct.
I've seen this occur with one of my small tests. Calling sigprocmask()
before the kernel is entered again, one could mask the SIGSEGV
(intentional or by accident).
The patch changes this, so that the next signal is taken from queue, if
the last stack frame creation failed.

And, yes. I've tested this.

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
