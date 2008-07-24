Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KLqta-00022a-Vp for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Jul 2008 19:49:35 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KLqtZ-0006xF-Hl
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Jul 2008 19:49:35 -0700
Date: Wed, 23 Jul 2008 22:49:14 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080724024914.GA20556@c2.user-mode-linux.org>
References: <20080723154650.GA15682@c2.user-mode-linux.org>
	<20080723125925.6ac68198.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080723125925.6ac68198.akpm@linux-foundation.org>
Subject: Re: [uml-devel] [PATCH] UML - Fix boot crash
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: torvalds@linux-foundation.org, stable@kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Jul 23, 2008 at 12:59:25PM -0700, Andrew Morton wrote:
> Needed in 2.6.26.x, but also applies to 2.6.25.  Is it also needed in
> 2.6.25.x?

It does apply nicely, but I think it's not needed for -stable.  AIUI,
-stable is for actual, realized bugs, and this one is more latent,
being enabled by the unit-at-a-time change during 2.6.26-rc.

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
