Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BiQHo-00012i-1a for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jul 2004 21:13:28 -0700
Received: from gtfw2.enterasys.com ([12.25.1.128] ident=firewall-user)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BiQHl-0005oQ-Qa for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Jul 2004 21:13:26 -0700
Received: from NHROCAVG2.ets.enterasys.com (nhrocavg2.enterasys.com
	[134.141.79.124])
	by gtfw2.enterasys.com (0.25.1/8.12.6) with ESMTP id i684DGOk001080
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 8 Jul 2004 00:13:16 -0400 (EDT)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <C28780ABC637504896EB86B4FB75FFBFA26E5E@MAANDMBX1.ets.enterasys.com>
From: "Bahi, David" <dbahi@enterasys.com>
Subject: [uml-devel] UML and valgrind
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
Date: Thu, 8 Jul 2004 00:13:16 -0400
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

back some time ago it seems like someone had more than a clue as to what
was requried to get valgrind working under UML... well as of 2.1.1 it
still ain't working.

http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=107066894230633&
w=2

I was wondering if a patch was available for our 'community' to make use
of this tool... for both running the UML as an application and for
running
applications within the UML.

It seems that for running valgrind within the UML there is a signal
handling
problem where 'restorer' is NULL and causes a panic in
setup_signal_stack_si

signal_kernel.c
  handle_signal()

	if (ka->sa.sa_flags & SA_RESTORER) restorer =
ka->sa.sa_restorer;
	else restorer = NULL;

	if(ka->sa.sa_flags & SA_SIGINFO)
		err = setup_signal_stack_si(sp, signr, (unsigned long)
handler,
					    restorer, regs, info,
&save);

thanks for any insight.

db

"The kernel is the only UNIX code that cannot be substituted by a user
to his own liking. For this reason, the kernel should make as few real
decisions as possible." -- K. Thompson


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
