Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ds8aK-00078S-Up	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 17:25:16 -0700
Received: from smtp2.oregonstate.edu ([128.193.4.8] ident=postfix)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1Ds8aI-00059W-NC	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jul 2005 17:25:16 -0700
Received: from localhost (localhost [127.0.0.1])
	by smtp2.oregonstate.edu (Postfix) with ESMTP id EE4BE1702CD
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 11 Jul 2005 17:25:13 -0700 (PDT)
Received: from smtp2.oregonstate.edu ([127.0.0.1])
 by localhost (smtp2 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04045-04 for <user-mode-linux-devel@lists.sourceforge.net>;
 Mon, 11 Jul 2005 17:25:13 -0700 (PDT)
Received: from wakeisland.nws.oregonstate.edu (wakeisland.nws.oregonstate.edu
	[128.193.126.4])
	by smtp2.oregonstate.edu (Postfix) with ESMTP id C9DE0170263
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 11 Jul 2005 17:25:13 -0700 (PDT)
From: Anthony Brock <Anthony_Brock@ous.edu>
Content-Type: text/plain
Message-Id: <1121127912.9308.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Kernel 2.6.13-rc2 host kernel configuration
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
Date: Mon, 11 Jul 2005 17:25:12 -0700
To: user-mode-linux-devel@lists.sourceforge.net

I'm about to build a 2.6.13-rc2 kernel for testing as a host kernel.
I've patched it with the '-mm1' patches and the 'skas-2.6.12-v8.2'
patch. The later applied with a minor tweak to 'mm/Makefile'.

However, I'm now trying to build a configuration for the newer kernel.
Unfortunately, I'm not certain how to best answer some of the questions
for a machine whose primary purpose is to host UML instances.
Specifically, any idea concerning the "Timer frequency" option? Here is
the help provided during configuration:


Timer frequency
  1. 100 HZ (HZ_100) (NEW)
> 2. 250 HZ (HZ_250) (NEW)
  3. 1000 HZ (HZ_1000) (NEW)
choice[1-3?]: ?

Allows the configuration of the timer frequency. It is customary
to have the timer interrupt run at 1000 HZ but 100 HZ may be more
beneficial for servers and NUMA systems that do not need to have
a fast response for user interaction and that may experience bus
contention and cacheline bounces as a result of timer interrupts.
Note that the timer interrupt occurs on each processor in an SMP
environment leading to NR_CPUS * HZ number of timer interrupts
per second.


Are timer interrupts used by a UML instance? If so, should I select
"1000 HZ"? Or would "100 HZ" free up system resources and allow the
instances to run with less contention?

Thanks!

Tony



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
