Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0PlN-00084L-MI for User-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Feb 2005 11:50:37 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D0PlL-0002XY-Kb for User-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Feb 2005 11:50:37 -0800
Message-Id: <200502132151.j1DLoxnW003492@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Sun, 13 Feb 2005 19:58:39 +0100."
	<opsl5gb1holfdzum@localhost.localdomain> 
References: <opsl43d9yilfdzum@localhost.localdomain>
	<200502131813.j1DICsnW002251@ccure.user-mode-linux.org>
	<20050213164652.GE8859@parcelfarce.linux.theplanet.co.uk>
	<opsl5gb1holfdzum@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: [PATCH] uml: support a separate build tree;
	support USER_OBJS dependencies
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
Date: Sun, 13 Feb 2005 16:50:59 -0500
To: Vadim Abrossimov <vadim_abrossimov@yahoo.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, User-mode-linux-devel@lists.sourceforge.net

vadim_abrossimov@yahoo.com said:
> Apparently my changes to support 'O=' are quite obsolete:

Not entirely - it's nice to see the same changes from two different sources,
although the first source was Al, which greatly reduces the chances that they
are wrong...

> The second change proposed in my patch concerned USER_OBJS
> dependences: I removed specific rules using the generic Kbuild rule
> just overwriting   'c_flags':

> I agree that it's not very elegant and robust but it does the job and
>  could be useful until Kbuild will provide a clean way to do it. 

It is still better than what I have now.

> If you think useful, I may create a patch with this change only.
> Should I do it against 2.6.10 as an add-on to the   http://
> user-mode-linux.sourceforge.net/patches.html tarball? 

Yup, that would be useful.

> That lead me to another question: why we don't use directly BitKeeper?
> We   could have a repository for uml development. 

I used BK for a while.  I just found that quilt fits my development style
better.

				Jeff



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
