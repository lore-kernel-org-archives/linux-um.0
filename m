Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0Unj-0007q5-DH for User-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Feb 2005 17:13:23 -0800
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252] ident=93)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D0Unh-0007xE-Vl
	for User-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Feb 2005 17:13:23 -0800
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Message-ID: <20050214011317.GG8859@parcelfarce.linux.theplanet.co.uk>
References: <opsl43d9yilfdzum@localhost.localdomain>
	<200502131813.j1DICsnW002251@ccure.user-mode-linux.org>
	<20050213164652.GE8859@parcelfarce.linux.theplanet.co.uk>
	<opsl5gb1holfdzum@localhost.localdomain>
	<200502132151.j1DLoxnW003492@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502132151.j1DLoxnW003492@ccure.user-mode-linux.org>
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
Date: Mon, 14 Feb 2005 01:13:17 +0000
To: Jeff Dike <jdike@addtoit.com>
Cc: Vadim Abrossimov <vadim_abrossimov@yahoo.com>, User-mode-linux-devel@lists.sourceforge.net

On Sun, Feb 13, 2005 at 04:50:59PM -0500, Jeff Dike wrote:
> vadim_abrossimov@yahoo.com said:
> > Apparently my changes to support 'O=' are quite obsolete:
> 
> Not entirely - it's nice to see the same changes from two different sources,
> although the first source was Al, which greatly reduces the chances that they
> are wrong...

Not particulary, seeing that I've done almost no work on kbuild-related
stuff...
 
> > The second change proposed in my patch concerned USER_OBJS
> > dependences: I removed specific rules using the generic Kbuild rule
> > just overwriting   'c_flags':
> 
> > I agree that it's not very elegant and robust but it does the job and
> >  could be useful until Kbuild will provide a clean way to do it. 
> 
> It is still better than what I have now.

ACK.  AFAICS, other parts of patch are already covered, except for adding
arch/um/include/sysdep to search path.  Why do we need that?  Files in
there get included as <sysdep/blah.h>, not <blah.h>, so...


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
