Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E0ypq-0005zd-JT	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Aug 2005 02:49:50 -0700
Received: from fallback.mail.elte.hu ([157.181.151.13])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E0ypp-0000BO-6U
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Aug 2005 02:49:50 -0700
Received: from mx2.elte.hu (mx2.elte.hu [157.181.151.9])
	by fallback.mail.elte.hu (Postfix) with ESMTP id B6A4650378
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri,  5 Aug 2005 10:11:47 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20050805081013.GB6409@elte.hu>
References: <200508042124.36786.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508042124.36786.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: Bugs on your remap_file_pages protections
	implementations
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
Date: Fri, 5 Aug 2005 10:10:13 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net


* Blaisorblade <blaisorblade@yahoo.it> wrote:

> Hi Ingo, I'm the young UML hacker you met at OLS and who got your UML 
> patches sent ;-)
> 
> I've been studying your patch (and the whole Linux VM, indeed) in the 
> past days, and I have some remarks, about the version of the code in 
> 2.6.4-rc2-mm1 (which is the same you sent me) - I've now downloaded 
> the version dropped from 2.6.5-mm1, but it doesn't seem to address 
> those problems.
> 
> Btw, I've now seen why that patch was dropped, but not why it wasn't 
> resubmit.

was not resubmitted due to me only having 30 hours available to hack, 
per day ;) Feel free to pick the patch up.

> *) with your patch, remapped pages without MAP_INHERIT are IMHO not 
> safe across swapout; re-swapping them in will pass through the 
> arch-specific fault handler, which will check VMA's protections, and 
> fail if the VMA originally had MAP_NONE. Or am I missing something?

not sure, was a long time ago. I have checked swap-safeness, but only 
once. UML did work though, but i dont think i ever pushed it into 
swapping out its RAM-file.

	Ingo


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
