Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AsoRI-00071b-94
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 11:29:56 -0800
Received: from mx2.elte.hu ([157.181.151.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AsoI2-0004BI-Rm
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 11:20:23 -0800
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [uml-devel] Re: Diagnosed and repeatable kernel mode panic in schedule() for 2.6!
Message-ID: <20040216192703.GA13746@elte.hu>
References: <200402151911.11890.blaisorblade_spam@yahoo.it> <20040216095335.GA27377@elte.hu> <200402162025.24853.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402162025.24853.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 16 Feb 2004 20:27:03 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net


* BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:

> However, I discovered that an old 2.6.0 kernel works well. I think
> that had 2.6.0-test9 patch; so I think that this is related with the
> NET: Registered ... hang, which was solved with the same patch. That
> does not happen on different compilation env.s, but I think that is
> random: a crazy pointer failing in different places.

i cannot reproduce using 2.6.2-rc3-mm1, so it's likely some recent
breakage.

	Ingo


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
