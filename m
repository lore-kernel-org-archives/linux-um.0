Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KM2qK-0005pB-Kd for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Jul 2008 08:35:00 -0700
Received: from bombadil.infradead.org ([18.85.46.34])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KM2qI-0001jz-PH
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 24 Jul 2008 08:35:00 -0700
Date: Thu, 24 Jul 2008 08:32:47 -0700
From: Greg KH <greg@kroah.com>
Message-ID: <20080724153247.GA11012@kroah.com>
References: <20080723154650.GA15682@c2.user-mode-linux.org>
	<20080723125925.6ac68198.akpm@linux-foundation.org>
	<20080724025237.GB20556@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080724025237.GB20556@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [stable] [PATCH] UML - Fix boot crash
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
Cc: torvalds@linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, akpm@linuxfoundation.org, stable@kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Jul 23, 2008 at 10:52:37PM -0400, Jeff Dike wrote:
> On Wed, Jul 23, 2008 at 12:59:25PM -0700, Andrew Morton wrote:
> > Needed in 2.6.26.x, but also applies to 2.6.25.  Is it also needed in
> > 2.6.25.x?
> 
> ... and just to be clear, I mean I think it's not exactly 2.6.25.x
> material.  It is definite 2.26.6.x material.

Ok, fair enough, I'll queue it up when it hits Linus's tree.

Neat hack:  If you add the line
  cc: stable <stable@kernel.org>
to the signed-off-by area of a patch, when it is applied by Linus it
will be sent automatically to the stable team as well and we will know
then that it is safe to apply to our trees.  No additional work from you
would be needed then.

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
