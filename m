Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DsPq4-0000WV-Ov	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 11:50:40 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.44)
	id 1DsPq4-0007zx-KG	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 11:50:40 -0700
From: Chris Wright <chrisw@osdl.org>
Message-ID: <20050712185023.GY19052@shell0.pdx.osdl.net>
References: <20050712172838.271E8D9A84@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050712172838.271E8D9A84@zion.home.lan>
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
Date: Tue, 12 Jul 2005 11:50:23 -0700
To: blaisorblade@yahoo.it
Cc: stable@kernel.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

* blaisorblade@yahoo.it (blaisorblade@yahoo.it) wrote:
> Revert the following patch, because of miscompilation problems in different
> environments leading to UML not working *at all* in TT mode; it was merged
> lately in 2.6 development cycle, a little after being written, and has caused
> problems to lots of people; I know it's a bit too long, but it shouldn't have
> been merged in first place, so I still apply for inclusion in the -stable
> tree. Anyone using this feature currently is either using some older kernel
> (some reports even used 2.6.12-rc4-mm2) or using this patch, as included in my
> -bs patchset.
> 
> For now there's not yet a fix for this patch, so for now the best thing is to
> drop it (which was widely reported to give a working kernel).

And upstream will leave this in, working to real fix?

thanks,
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
