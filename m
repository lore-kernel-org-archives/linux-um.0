Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AwT4z-0003mK-8V for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Feb 2004 13:30:01 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1AwShJ-00041c-JD
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Feb 2004 13:05:33 -0800
Received: from hirsch.in-berlin.de (localhost [127.0.0.1])
	by hirsch.in-berlin.de (8.12.11/8.12.11/Debian-1) with ESMTP id
	i1QLK1Pr002789 for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 26 Feb 2004 22:20:01 +0100
Received: (from uucp@localhost)
	by hirsch.in-berlin.de (8.12.11/8.12.11/Debian-1) with UUCP id
	i1QLA2PC001833 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Feb 2004 22:10:02 +0100
Received: from bytesex.org (kraxel@localhost [127.0.0.1])
	by bytesex.org (8.12.3/8.12.3/Debian-6.6) with ESMTP id i1QLAjnW005132
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 26 Feb 2004 22:10:45 +0100
References: <20040223172012.GA29046@bytesex.org>
	<200402252047.59002.blaisorblade_spam@yahoo.it>
	<87smgyamnx.fsf@bytesex.org>
	<200402262030.56198.blaisorblade_spam@yahoo.it>
From: Gerd Knorr <kraxel@bytesex.org>
In-Reply-To: <200402262030.56198.blaisorblade_spam@yahoo.it>
Message-ID: <87brnllf6y.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Re: post-2.6.3 build error
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
Date: 26 Feb 2004 22:10:45 +0100
To: user-mode-linux-devel@lists.sourceforge.net

BlaisorBlade <blaisorblade_spam@yahoo.it> writes:

> crashy. Luckily CONFIG_REGPARM is not in the stock kernel.

It is in Linus' bk tree, so 2.6.4 will have that ...

  Gerd



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
