Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRyqq-0003fH-Lc for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 14:50:44 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FRyqo-0007tP-9F
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 14:50:44 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
	<20060407143107.19201.23684.stgit@zion.home.lan>
	<20060407160540.GB4962@ccure.user-mode-linux.org>
In-Reply-To: <20060407160540.GB4962@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604072350.33176.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [PATCH 08/17] uml: prepare fixing compilation output
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
Date: Fri, 7 Apr 2006 23:50:32 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Friday 07 April 2006 18:05, Jeff Dike wrote:
> On Fri, Apr 07, 2006 at 04:31:08PM +0200, Paolo 'Blaisorblade' Giarrusso 
wrote:
> > Move the build of user-offsets to arch/um/Kbuild, this will allow using
> > the normal user-objs machinery. I had written this to fixup for a Kbuild
> > change, but another fix was merged. This is still useful however.

> What's the benefit of this?
Er, just a style issue - or now it's a little cleanup just for style - I've 
thought to merge it anyway, even if I haven't converted it to a standard 
rule.
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
