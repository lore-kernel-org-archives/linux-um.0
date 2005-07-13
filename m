Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DshF9-0003e6-AQ	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 06:25:43 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.44)
	id 1DshF4-0004os-IL	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 06:25:43 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20050712172838.271E8D9A84@zion.home.lan>
	<20050712185023.GY19052@shell0.pdx.osdl.net>
In-Reply-To: <20050712185023.GY19052@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507131533.00817.blaisorblade@yahoo.it>
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
Date: Wed, 13 Jul 2005 15:33:00 +0200
To: Chris Wright <chrisw@osdl.org>
Cc: stable@kernel.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tuesday 12 July 2005 20:50, Chris Wright wrote:
> * blaisorblade@yahoo.it (blaisorblade@yahoo.it) wrote:
> > Revert the following patch, because of miscompilation problems in
> > different environments leading to UML not working *at all* in TT mode; it
> > was merged lately in 2.6 development cycle, a little after being written,
> > and has caused problems to lots of people; I know it's a bit too long,
> > but it shouldn't have been merged in first place, so I still apply for
> > inclusion in the -stable tree. Anyone using this feature currently is
> > either using some older kernel (some reports even used 2.6.12-rc4-mm2) or
> > using this patch, as included in my -bs patchset.

> > For now there's not yet a fix for this patch, so for now the best thing
> > is to drop it (which was widely reported to give a working kernel).

> And upstream will leave this in, working to real fix?
Preferably yes, but this depends on whether the fix is found. Otherwise this 
exact patch will be merged upstream too.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
