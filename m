Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eb584-0008BN-PT for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 15:49:52 -0800
Received: from scrub.xs4all.nl ([194.109.195.176] ident=mail)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Eb583-0006zD-L1
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 15:49:53 -0800
From: Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <200511121731.25982.rob@landley.net>
Message-ID: <Pine.LNX.4.61.0511130042530.1610@scrub.home>
References: <200511121656.29445.rob@landley.net>
	<200511121731.25982.rob@landley.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: Why did oldconfig's behavior change in 2.6.15-rc1?
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
Date: Sun, 13 Nov 2005 00:49:34 +0100 (CET)
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Hi,

On Sat, 12 Nov 2005, Rob Landley wrote:

> Why did oldconfig switch off CONFIG_MODE_SKAS?  It didn't do that before.  
> Hmmm...  Rummage, rummage...  Darn it, it's position dependent.  _And_ 
> version dependent.

It's _not_ position dependent, but the behaviour with multiple equal 
symbols is undefined.

> Ok, now I have to put the new entries at the _beginning_.  Appending them 
> doesn't work anymore, it now ignores any symbol it's already seen, so you 
> can't easily start with allnoconfig, switch on just what you want, and expect 
> oldconfig to do anything intelligent.

Now you can put them in allno.config instead and allnoconfig will do the 
right thing.

bye, Roman


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
