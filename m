Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Auk4D-0008IU-LT for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Feb 2004 19:14:05 -0800
Received: from mail-10.iinet.net.au ([203.59.3.42] helo=mail.iinet.net.au)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AujnJ-0001aP-3X for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Feb 2004 18:56:37 -0800
Received: from cameron by cp.yi.org with local (Exim 3.36 #1 (Debian))
	id 1AujxJ-0002fQ-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 22 Feb 2004 11:06:57 +0800
From: Cameron Patrick <cameron@patrick.wattle.id.au>
Subject: Re: [uml-devel] [PATCH] skas3 for x86_64 arch
Message-ID: <20040222030657.GE5190@patrick.wattle.id.au>
References: <1077305069.8412.62.camel@wopr.tektonic.net>
	<200402202155.44773.blaisorblade_spam@yahoo.it>
	<1077311125.8412.78.camel@wopr.tektonic.net>
	<20040221094519.GB31609@patrick.wattle.id.au>
	<51445.68.81.41.201.1077418309.squirrel@www.tektonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51445.68.81.41.201.1077418309.squirrel@www.tektonic.net>
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
Date: Sun, 22 Feb 2004 11:06:57 +0800
To: user-mode-linux-devel@lists.sourceforge.net

matta@tektonic.net wrote:

| Yes, I installed bochs and just tried the AMD64 kernel provided by SuSe on
| their site and when it booted up it stated my CPU wasn't capable of
| 64-bit.  So it looks like it does support it, but only when running under
| a 64-bit CPU.

It works for me on my Athlon XP.  (Well, I didn't try to actually do
anything with it, but the kernel prints out messages and stuff.)  This
is using the Debian unstable `bochs' package.

Screenshot- http://cp.yi.org/cameron/bochs.png

That said, a real Opteron would be a lot more practical for most
things; especially, e.g. running gcc :-)

Cameron.


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
