Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C9kI0-0003Lg-E1 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Sep 2004 06:02:36 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1C9kHy-0007Yl-M4
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Sep 2004 06:02:36 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Managing 2.6 merge - url for the patches sent to merge
Message-ID: <20040921123704.GA20191@bytesex>
References: <200409181944.58072.blaisorblade_personal@yahoo.it>
	<200409191338.12871.blaisorblade_personal@yahoo.it>
	<878yb51drm.fsf@bytesex.org>
	<200409202030.49422.blaisorblade_personal@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409202030.49422.blaisorblade_personal@yahoo.it>
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
Date: Tue, 21 Sep 2004 14:37:04 +0200
To: Paolo Giarrusso <blaisorblade_personal@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Mon, Sep 20, 2004 at 08:30:49PM +0200, Paolo Giarrusso wrote:
> On Monday 20 September 2004 11:38, Gerd Knorr wrote:
> > kbuild wishlist item #1: working parallel builds aka "make -j" for UML.
> Done and posted to Jeff - the complete set of patches which I posted him is 
> now available at this URL (no link in the page, sorry):

Works great, thanks.  It took some time to figure that the kernel binary
is vmlinux now and not linux any more through, guess that will surprise
a few other people as well.  Is there some good reason for that change?

  Gerd

-- 
return -ENOSIG;


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
