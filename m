Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C9Sz4-0001r3-7T for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Sep 2004 11:33:54 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1C9Sz3-0004WW-DR for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Sep 2004 11:33:54 -0700
From: Paolo Giarrusso <blaisorblade_personal@yahoo.it>
Subject: Re: [uml-devel] Managing 2.6 merge - url for the patches sent to merge
References: <200409181944.58072.blaisorblade_personal@yahoo.it>
	<200409191338.12871.blaisorblade_personal@yahoo.it>
	<878yb51drm.fsf@bytesex.org>
In-Reply-To: <878yb51drm.fsf@bytesex.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409202030.49422.blaisorblade_personal@yahoo.it>
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
Date: Mon, 20 Sep 2004 20:30:49 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>, Jeff Dike <jdike@addtoit.com>

On Monday 20 September 2004 11:38, Gerd Knorr wrote:
> Paolo Giarrusso <blaisorblade_personal@yahoo.it> writes:
> > I have a lot of experience about kbuild, so I can put appropriate care
> > about makefiles quality.
>
> kbuild wishlist item #1: working parallel builds aka "make -j" for UML.
Done and posted to Jeff - the complete set of patches which I posted him is 
now available at this URL (no link in the page, sorry):

http://www.user-mode-linux.org/~blaisorblade/newSite/patches/guest/patches-to-merge-for-2.6.tar.bz2

Don't use uml-use-va_end.patch, it breaks UML on rebooting. The Makefile 
patches are near the end of "series".

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
