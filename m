Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EYFmT-0001wa-55 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 20:35:53 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EYFmS-0003h5-5h
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 20:35:53 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance
	V19
Message-ID: <20051105052342.GB15683@ccure.user-mode-linux.org>
References: <1130917338.14475.133.camel@localhost>
	<200511041441.11896.rob@landley.net>
	<200511050042.49904.blaisorblade@yahoo.it>
	<200511041945.53507.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511041945.53507.rob@landley.net>
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
Date: Sat, 5 Nov 2005 00:23:42 -0500
To: Rob Landley <rob@landley.net>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Fri, Nov 04, 2005 at 07:45:53PM -0600, Rob Landley wrote:
> Another advantage of prezeroing: it maps really well to what we're trying to 
> do here.  It makes a class of not just free but zeroed memory (and madvise 
> zeroes the memory for us).  

Yeah, we would need to keep track of zeroed pages somehow.  This isn't 
currently done, and it would require some generic kernel hooks.  And it would 
require them in some delicate places.

If there were some sort of background zeroing and tracking of zeroed pages
already there, it would be a lot easier for UML.  Without that, I'm not sure
how to take advantage of the host's zeroing.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
