Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQ7AD-0002EL-H1 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Aug 2008 14:00:21 -0700
Received: from ip-212-081-022-089.static.nextra.sk ([212.81.22.89]
	helo=meduna.org) by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1KQ7AC-0002wv-4Y for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Aug 2008 14:00:21 -0700
Received: from [192.168.130.27] (lnxtleo01004.meduna.lan [192.168.130.27])
	by meduna.org (Postfix) with ESMTP id E2DBA9C434
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon,  4 Aug 2008 23:08:08 +0200 (CEST)
Message-ID: <48976DB8.3020001@meduna.org>
Date: Mon, 04 Aug 2008 22:59:36 +0200
From: Stanislav Meduna <stano@meduna.org>
MIME-Version: 1.0
References: <48970AEC.6020503@meduna.org>
	<20080804203319.GA14732@c2.user-mode-linux.org>
In-Reply-To: <20080804203319.GA14732@c2.user-mode-linux.org>
Subject: Re: [uml-devel] sysconf(_SC_NPROCESSORS_CONF) returning zero
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:

> sysconf seems to be looking at /proc/stat, which looks like this here:
> 
> 	cpu  80 0 157 12771 984 0 0 0 0
> 	cpu0 80 0 157 12771 984 0 0 0 0
> 	intr 15259 12519 0 75 0 2590 0 0 0 0 0 0 74 0 0 1
> 	ctxt 8081
> 	btime 1217881784
> 	processes 1144
> 	procs_running 3
> 	procs_blocked 0
> 
> I'd guess it's looking at the cpu0 (and cpu<n>) lines.

# cat /proc/stat
cpu  38822 537 3376 46871329 174924 0 9 0 0
cpu0 38822 537 3376 46871329 174924 0 9 0 0
intr 47644940 47088997 0 5 0 395871 160067 0 0 0 0 0 0 0 0 0
ctxt 9822902
btime 1217412992
processes 26529
procs_running 2
procs_blocked 0


Hmmm... so I have cpu0 similar to yours. What version
of UML and libc do you have?

-- 
                                   Stano

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
