Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqamT-0001sK-9U for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 10:02:53 -0700
Received: from brown.brainfood.com ([146.82.138.61]
	helo=gradall.private.brainfood.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BqamS-0001XB-W9 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 10:02:53 -0700
Received: from localhost ([127.0.0.1] ident=adam)
	by gradall.private.brainfood.com with esmtp (Exim 3.36 #1 (Debian))
	id 1BqamQ-00088V-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 30 Jul 2004 12:02:50 -0500
From: Adam Heath <doogie@brainfood.com>
Subject: Re: [uml-devel] uml-patch-2.4.26-2
In-Reply-To: <20040730144606.GA27236@memset.com>
Message-ID: <Pine.LNX.4.58.0407301202240.1450@gradall.private.brainfood.com>
References: <200407162019.i6GKJKqa003236@ccure.user-mode-linux.org>
	<20040730074833.GA22488@craig-wood.com>
	<878yd1itow.fsf@amaterasu.srvr.nix>
	<20040730144606.GA27236@memset.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Fri, 30 Jul 2004 12:02:49 -0500 (CDT)
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, 30 Jul 2004, Nick Craig-Wood wrote:

> However I view the above to be a bug in UML - it shouldn't lock up.
> Its entitled to miss events etc though.  gettimeofday(2) isn't
> guaranteed to be monotonic, but unfortunately there isn't a monotonic
> timer (like jiffies) that escapes to user space AFAIK.

rdtsc, but only on newer cpus.


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
