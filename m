Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dsk4O-0004zA-O9	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 09:26:48 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1Dsk4N-0000eh-3G	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 09:26:48 -0700
From: Chris Wright <chrisw@osdl.org>
Message-ID: <20050713162632.GL19052@shell0.pdx.osdl.net>
References: <20050712172838.271E8D9A84@zion.home.lan>
	<20050712185023.GY19052@shell0.pdx.osdl.net>
	<200507131533.00817.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507131533.00817.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [stable] [patch 1/1] uml: fix TT mode by reverting
	"use fork instead of clone"
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
Date: Wed, 13 Jul 2005 09:26:32 -0700
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Chris Wright <chrisw@osdl.org>, stable@kernel.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

* Blaisorblade (blaisorblade@yahoo.it) wrote:
> On Tuesday 12 July 2005 20:50, Chris Wright wrote:
> > * blaisorblade@yahoo.it (blaisorblade@yahoo.it) wrote:
> > > For now there's not yet a fix for this patch, so for now the best thing
> > > is to drop it (which was widely reported to give a working kernel).
> > 
> > And upstream will leave this in, working to real fix?
> 
> Preferably yes, but this depends on whether the fix is found. Otherwise this 
> exact patch will be merged upstream too.

OK, thanks, queued to -stable.
-chris


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
