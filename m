Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BL8tr-0007Si-To for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 May 2004 16:00:31 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BL8tr-0000ve-Bo
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 04 May 2004 16:00:31 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] [patch] ethtool support
Message-ID: <20040505054521.GA28847@bytesex.org>
References: <20040430094557.GA19219@bytesex.org>
	<200405042041.i44KfekI003899@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405042041.i44KfekI003899@ccure.user-mode-linux.org>
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
Date: Wed, 5 May 2004 07:45:21 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, May 04, 2004 at 04:41:40PM -0400, Jeff Dike wrote:
> kraxel@bytesex.org said:
> > Trivial patch for the uml network driver: basic ethtool support so it
> > returns name + version on ETHTOOL_GDRVINFO. 
> 
> Applied, thanks.  What's with the version == 42?

I didn't find a version for the driver, so I picked a random number.
Well, not completely random, just google for "42" ;)

  Gerd

-- 
Bei Debian kannst du dir aussuchen, woran du selbst schuld sein willst.
	-- Thiemo Seufer in dasr zu stable vs. testing


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
