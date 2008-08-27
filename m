Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYG1J-0000uv-It for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 01:04:49 -0700
Received: from zaphod.cobb.me.uk ([80.68.91.167])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYG1I-0005bV-4g
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 01:04:49 -0700
From: Graham Cobb <g+debian@cobb.uk.net>
Date: Wed, 27 Aug 2008 09:04:29 +0100
References: <20080813175125.19829.80844.reportbug@carrera.home.cobb.me.uk>
	<20080819114704.GB7425@inferi.kami.home>
	<20080826202012.GF24342@c2.user-mode-linux.org>
In-Reply-To: <20080826202012.GF24342@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200808270904.30873.g+debian@cobb.uk.net>
Subject: Re: [uml-devel] Bug#494995: user-mode-linux: static build fails
	with multiple definition of `strrchr'
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
Cc: Mattia Dongili <malattia@linux.it>, 494995@bugs.debian.org, UML-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tuesday 26 August 2008 21:20:12 Jeff Dike wrote:
> A symbol clash between libc and the kernel.   Try this:
>...

The patch itself didn't apply for me (probably because I copy/paste'd it from 
the email) but making the change by hand to the Makefile worked and fixed the 
problem.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
