Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B291f-0007iI-R7 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Mar 2004 05:18:03 -0800
Received: from mekong.darkman.de
	([217.69.160.53] helo=mail.darkman.de ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B291e-0007ls-Un for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Mar 2004 05:18:03 -0800
Received: from darkman.de (ezri.darkman.de [23.23.23.42])
	by mail.darkman.de (Postfix) with ESMTP id 350B32EF84
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 13 Mar 2004 14:17:51 +0100 (CET)
Message-ID: <405309FE.6020603@darkman.de>
From: "Sven 'Darkman' Michels" <sven@darkman.de>
MIME-Version: 1.0
Subject: Re: [uml-devel] /dev/random oddity
References: <20040313014957.GB13419@speedy.schwinge.homeip.net>
In-Reply-To: <20040313014957.GB13419@speedy.schwinge.homeip.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Sat, 13 Mar 2004 14:17:50 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Thomas Schwinge wrote:
> On UML the entropy pool seems never to be refilled - not matter how long
> I keep a key pressed; I don't have a mouse there - so AFAICT /dev/random
> stops working at the time the pool gets empty.

never is wrong, you can 'fill' the pool by doing some work like find /
ps aux etc, but this is really slow in filling up the pool. Maybe
other things should be used to fill the pool, too. Jeff? Blaisor?
anyone? ;)

Regards,
Sven



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
