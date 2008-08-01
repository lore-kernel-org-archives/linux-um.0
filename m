Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KP3k5-0007Lx-Eq for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Aug 2008 16:09:01 -0700
Received: from bombadil.infradead.org ([18.85.46.34])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KP3k3-00061Q-0s
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Aug 2008 16:09:01 -0700
Date: Fri, 1 Aug 2008 16:06:24 -0700
From: Greg KH <greg@kroah.com>
Message-ID: <20080801230624.GA22233@kroah.com>
References: <20080801224125.GA13727@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080801224125.GA13727@c2.user-mode-linux.org>
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
To: Jeff Dike <jdike@addtoit.com>
Cc: WANG Cong <xiyou.wangcong@gmail.com>, stable@kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>

On Fri, Aug 01, 2008 at 06:41:25PM -0400, Jeff Dike wrote:
> >From 94409ded7768e15b0d0a5a172d611073c72308de Mon Sep 17 00:00:00 2001

These git commit ids don't match up to anything in Linus's tree at all
:(

Can you resend these patches with the git ids of the patches already in
Linus's tree so that we can properly match them up?

Oh, in the future it is simple to get patches into the -stable tree
automatically, just add:
	Cc: Stable <stable@kernel.org>
to the signed-off-by: area of the patch.  When it goes into Linus's
tree, it will be automatically sent to us for inclusion in the next
-stable release.

thanks,

greg k-h

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
