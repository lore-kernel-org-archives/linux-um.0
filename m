Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bqcpa-00016O-QX for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 12:14:14 -0700
Received: from brown.brainfood.com ([146.82.138.61]
	helo=gradall.private.brainfood.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bqcpa-00052p-GR for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 12:14:14 -0700
From: Adam Heath <doogie@brainfood.com>
Subject: Re: [uml-devel] uml-patch-2.4.26-2
In-Reply-To: <200407301849.i6UIn9UE003219@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.58.0407301413450.1450@gradall.private.brainfood.com>
References: <200407162019.i6GKJKqa003236@ccure.user-mode-linux.org>
	<20040730074833.GA22488@craig-wood.com>
	<878yd1itow.fsf@amaterasu.srvr.nix>
	<20040730144606.GA27236@memset.com>
	<Pine.LNX.4.58.0407301202240.1450@gradall.private.brainfood.com>
	<200407301849.i6UIn9UE003219@ccure.user-mode-linux.org>
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
Date: Fri, 30 Jul 2004 14:14:08 -0500 (CDT)
To: Jeff Dike <jdike@addtoit.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Fri, 30 Jul 2004, Jeff Dike wrote:

> doogie@brainfood.com said:
> > rdtsc, but only on newer cpus.
>
> Is it monotonic on SMP boxes when you get moved from one CPU to another?
>
> This question, and some others, are what convinced me to use gettimeofday
> instead.

Actually, that's a good point.  rdtsc is per-cpu, I believe.  Which means I
have a bug in my java profiler code. :|


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
