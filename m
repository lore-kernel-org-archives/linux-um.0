Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRynD-0003FK-Jx for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 14:46:59 -0700
Received: from smtp008.mail.ukl.yahoo.com ([217.12.11.62])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FRynA-0007DP-Vs
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 14:46:59 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
	<20060407143054.19201.89200.stgit@zion.home.lan>
	<20060407160218.GA4962@ccure.user-mode-linux.org>
In-Reply-To: <20060407160218.GA4962@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604072346.45225.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [PATCH 03/17] uml: fix 2 harmless cast warnings for
	64-bit
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
Date: Fri, 7 Apr 2006 23:46:44 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Friday 07 April 2006 18:02, Jeff Dike wrote:
> On Fri, Apr 07, 2006 at 04:30:54PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> >
> > Fix two harmless warnings in 64-bit compilation (the 2nd doesn't trigger
> > for now because of a missing __attribute((format)) for cow_printf, but
> > next patches fix that).

> I don't object to this bit, but it doesn't seem to match the comment.  Was
> there another cast that you meant to have here, but missed?

No, the below one was a whitespace change which slipped in without mention 
(but that I confirm).

> > -		n = min((size_t)len, ARRAY_SIZE(console_buf) - console_index);
> > +		n = min((size_t) len, ARRAY_SIZE(console_buf) - console_index);

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
