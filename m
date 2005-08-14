Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E47Sm-0001lf-UY	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Aug 2005 18:39:00 -0700
Received: from mx1.elte.hu ([157.181.1.137])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E47Sl-0003Qy-Lu
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Aug 2005 18:39:01 -0700
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20050814013849.GA23795@elte.hu>
References: <200508122033.06385.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508122033.06385.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [RFC] [patch 0/39] remap_file_pages protection
	support, try 2
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
Date: Sun, 14 Aug 2005 03:38:49 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>, user-mode-linux-devel@lists.sourceforge.net


* Blaisorblade <blaisorblade@yahoo.it> wrote:

> Ok, I've been working for the past two weeks learning well the Linux 
> VM, understanding the Ingo's remap_file_pages protection support and 
> its various weakness (due to lack of time on his part), and splitting 
> and finishing it.
> 
> Here follow a series of 39 _little_ patches against the git-commit-id 
> 889371f61fd5bb914d0331268f12432590cf7e85, which means between 
> 2.6.13-rc4 and -rc5.
> 
> Actually, the first 7 ones are unrelated trivial cleanups which 
> somehow get in the way on this work and that can probably be merged 
> even now (many are just comment fixes).
> 
> Since I was a VM newbie until two weeks ago, I've separated my changes 
> into many little patches.

hi. Great work! I'm wondering about this comment in 
rfp-fix-unmap-linear.patch:

> Additionally, add a missing TLB flush in both locations. However, 
> there'is some excess of flushes in these functions.

excess TLB flushes one of the reasons of bad UML performance, so you 
should really review them and not do spurious TLB flushes.

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
