Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KP5UX-00014c-Lp for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Aug 2008 18:01:05 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KP5UV-0002wd-SW
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Aug 2008 18:01:05 -0700
Date: Fri, 1 Aug 2008 21:00:44 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080802010044.GA16405@c2.user-mode-linux.org>
References: <20080801224125.GA13727@c2.user-mode-linux.org>
	<20080801230624.GA22233@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080801230624.GA22233@kroah.com>
Subject: Re: [uml-devel] [stable] [PATCH 1/14] uml: fix build when SLOB is
	enabled
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
To: Greg KH <greg@kroah.com>
Cc: WANG Cong <xiyou.wangcong@gmail.com>, stable@kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>

On Fri, Aug 01, 2008 at 04:06:24PM -0700, Greg KH wrote:
> On Fri, Aug 01, 2008 at 06:41:25PM -0400, Jeff Dike wrote:
> > >From 94409ded7768e15b0d0a5a172d611073c72308de Mon Sep 17 00:00:00 2001
> 
> These git commit ids don't match up to anything in Linus's tree at all
> :(

Hmmm, OK I'll figure out where the commit ids came from.  I
cherry-picked them from 2.6.26 into 2.6.25.13, so I guess they got new
ids when I did that.

I'll resend with the original ids...

> Oh, in the future it is simple to get patches into the -stable tree
> automatically, just add:
> 	Cc: Stable <stable@kernel.org>
> to the signed-off-by: area of the patch.  When it goes into Linus's
> tree, it will be automatically sent to us for inclusion in the next
> -stable release.

Yeah, I'll do that in future, but it was a little late for these
patches.

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
