Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoieJ-0003R5-Lh
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 05 Feb 2004 04:30:27 -0800
Received: from mx2.elte.hu ([157.181.151.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AoieJ-0000uB-8d
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 05 Feb 2004 04:30:27 -0800
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20040205123057.GA23555@elte.hu>
References: <20040118235730.GC21046@ccure.user-mode-linux.org> <20040119075351.GA4088@elte.hu> <20040119082805.GA4412@elte.hu> <Pine.GSO.4.58.0401200008240.6442@altair.dur.ac.uk> <20040120002301.GA5708@elte.hu> <Pine.LNX.4.58.0401232125410.8188@vega.dur.ac.uk> <Pine.GSO.4.58.0401232342360.24271@altair.dur.ac.uk> <Pine.LNX.4.58.0401241215200.21419@vega.dur.ac.uk> <200401241820.i0OIKHY3002399@ccure.user-mode-linux.org> <Pine.LNX.4.58.0401241923510.27438@vega.dur.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401241923510.27438@vega.dur.ac.uk>
Subject: [uml-devel] Re: tt mode tls/glibc crash with 2.6 (Was: Re: uml-patch-2.6.0)
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
Date: Thu, 5 Feb 2004 13:30:57 +0100
To: M A Young <m.a.young@durham.ac.uk>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>


* M A Young <m.a.young@durham.ac.uk> wrote:

> Yes, that fixes it (I tried a similar fix by setting AT_SYSINFO_EHDR
> directly to NULL, both work).

does skas mode work for you? I tried a FC1 image today and even with
this change, in tt mode, it gets stuck pretty early into the bootup (but
not in init like before).

in tt mode, booting up into /bin/bash seems to work fine and simple
commands work.

in skas mode, booting up into /bin/bash works but the first /bin/ls (or
any other process) again gets stuck (infinite pagefaults or #GPF's again
i suspect).

	Ingo


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
