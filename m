Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYOah-0003XT-FV for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 10:13:55 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KYOad-0005mx-UN
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Aug 2008 10:13:55 -0700
Date: Wed, 27 Aug 2008 13:13:31 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080827171331.GA10985@c2.user-mode-linux.org>
References: <20080818230509.23819.90290.reportbug@carrera.home.cobb.me.uk>
	<20080819120155.GD7425@inferi.kami.home>
	<20080826202239.GG24342@c2.user-mode-linux.org>
	<200808271605.25584.graham@cobb.uk.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200808271605.25584.graham@cobb.uk.net>
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
To: Graham Cobb <graham@cobb.uk.net>
Cc: Mattia Dongili <malattia@linux.it>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Aug 27, 2008 at 04:05:24PM +0100, Graham Cobb wrote:
> However, how would I go about bisecting through the large number of patches 
> which are the difference between these?  Is there somewhere I can get interim 
> kernel versions from?

Set up a git tree, and git-bisect will chose versions for you, telling
you which commit introduced the bug.

See http://lkml.org/lkml/2005/7/30/106

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
