Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kaw3g-0003Qk-5x for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 10:22:20 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Kaw3e-0003NN-Js
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 10:22:20 -0700
Date: Wed, 3 Sep 2008 13:21:52 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080903172152.GB8769@c2.user-mode-linux.org>
References: <20080818230509.23819.90290.reportbug@carrera.home.cobb.me.uk>
	<20080819120155.GD7425@inferi.kami.home>
	<20080826202239.GG24342@c2.user-mode-linux.org>
	<200809030001.20439.g+debian@cobb.uk.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200809030001.20439.g+debian@cobb.uk.net>
Subject: Re: [uml-devel] [Pkg-uml-pkgs] Bug#495611:
	user-mode-linux:	page_mapcount(page) went negative!
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
To: Graham Cobb <g+debian@cobb.uk.net>
Cc: Mattia Dongili <malattia@linux.it>, 495611@bugs.debian.org, UML-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Sep 03, 2008 at 12:01:19AM +0100, Graham Cobb wrote:
> The bisection is complete.  It took longer than I expected as many of the 
> versions git-bisect wanted to test would not build UML without tracking down 
> some additional patches. 
> 
> The bug seems to have been introduced with git commit 
> 3963333fe6767f15141ab2dc3b933721c636c212 (uml: cover stubs with a VMA). 

Excellent, the backtrace now makes a bit of sense.  It looks like the
VMAs at the top of the address space are being overmapped by a call to
mmap.  The question is why does it look like there's a big enough hole
there, when it ends up unmapping the stubs in order to make room for
the mmap.

> With hindsight I suppose I could have guessed that would be the commit: the 
> crash seemed to be when unmapping a VMA.  If my reading of the page flags is 
> correct the problem is that the page has the PG_reserved flag set, so what is 
> it doing in the VMA which is being unmapped?

A page of kernel code is mapped into the process.  This page (and all
other pages containing kernel text) is marked reserved during boot.

> Let me know if you want me to run some more tests, for example if you want to 
> add some printk's in the code to understand more about what is going on.

I'm going to need some more information.  I'll get back to you with a
patch...

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
