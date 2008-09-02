Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KaesN-0000HN-QD for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 16:01:31 -0700
Received: from zaphod.cobb.me.uk ([80.68.91.167])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KaesM-0003SY-D6
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 16:01:31 -0700
From: Graham Cobb <g+debian@cobb.uk.net>
Date: Wed, 3 Sep 2008 00:01:19 +0100
References: <20080818230509.23819.90290.reportbug@carrera.home.cobb.me.uk>
	<20080819120155.GD7425@inferi.kami.home>
	<20080826202239.GG24342@c2.user-mode-linux.org>
In-Reply-To: <20080826202239.GG24342@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200809030001.20439.g+debian@cobb.uk.net>
Subject: Re: [uml-devel] [Pkg-uml-pkgs] Bug#495611: user-mode-linux:
	page_mapcount(page) went negative!
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Mattia Dongili <malattia@linux.it>, 495611@bugs.debian.org, UML-devel <user-mode-linux-devel@lists.sourceforge.net>

The bisection is complete.  It took longer than I expected as many of the 
versions git-bisect wanted to test would not build UML without tracking down 
some additional patches. 

The bug seems to have been introduced with git commit 
3963333fe6767f15141ab2dc3b933721c636c212 (uml: cover stubs with a VMA). 

Note the bisection didn't quite complete: the previous commit (git commit 
42a2b54ce8c7b9d4f418995a7950e7e2e15e52ce (uml: clean up TASK_SIZE usage))  
also causes a panic but it is different from the one reported in this bug and 
occurs immediately init is started so I presume it is not the same problem. 
The version before these two commits works.  

With hindsight I suppose I could have guessed that would be the commit: the 
crash seemed to be when unmapping a VMA.  If my reading of the page flags is 
correct the problem is that the page has the PG_reserved flag set, so what is 
it doing in the VMA which is being unmapped?

Let me know if you want me to run some more tests, for example if you want to 
add some printk's in the code to understand more about what is going on.


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
