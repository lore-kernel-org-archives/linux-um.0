Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ba3zO-0000b1-6W for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jun 2004 19:47:54 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Ba3zN-00020Y-Mc
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jun 2004 19:47:53 -0700
Message-Id: <200406150339.i5F3d5Fm025944@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: The SKAS4 patch?? + ideas for 0 context-switch 
In-Reply-To: Your message of "Sat, 12 Jun 2004 16:01:35 +0200."
	<200406121601.35801.blaisorblade_spam@yahoo.it> 
References: <200406071949.04220.blaisorblade_spam@yahoo.it>
	<200406080455.i584tad2023374@ccure.user-mode-linux.org>
	<200406121601.35801.blaisorblade_spam@yahoo.it> 
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
Date: Mon, 14 Jun 2004 23:39:05 -0400
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> Or better, if "tagged TLBs" means that the processor knows with which
> process  a TLB is associated, then I understand what you mean and
> agree with you. 

Yes.  Tagged TLBs don't require a full flush on a memory switch, and some
process memory context can survive a switch out and back, so the process doesn't
need to start from a context switch with a cold cache.

> I.e. they (Andrea Arcangeli and Ingo Molnar) agree that the cost of a
> TLB  flush changes depending on the number of filled TLBs. And they
> seem to also  agree that there is a "secondary cost", the cost of the
> TLB misses (which is  IMHO the one which changes depending on how much
> entries you flush). 

I didn't really see a clear statement of that in there.  You need to look
at the manuals to be sure.

> The Intel Manual 3 (Intel System Programming Guide - 253668 -15.pdf)
> says, at  page 4-1 (page 107 in the PDF), that limit checking has no
> performance cost,  

I don't see any discussion of performance there.  My copy of the spec dates
from Jan 2002.  Page 107 in the pdf is page 4-3 for me.  Section 4.3 on page
4-4 talks about limit checking, but nothing about performance.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
