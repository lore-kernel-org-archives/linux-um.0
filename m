Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AueFR-0000jU-DX for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Feb 2004 13:01:17 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Audyw-0004kc-JU for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 21 Feb 2004 12:44:14 -0800
From: M A Young <m.a.young@durham.ac.uk>
Subject: Re: [uml-devel] Re: 2.4.24-1um - exec-shield - [PATCH][RFC] memory
	shortness fix
In-Reply-To: <200402211651.27584.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.58.0402212049160.25949@vega.dur.ac.uk>
References: <200402162004.i1GK4isq024309@ccure.user-mode-linux.org>
	<200402201837.13918.blaisorblade_spam@yahoo.it>
	<Pine.LNX.4.58.0402202219290.23596@vega.dur.ac.uk>
	<200402211651.27584.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Sat, 21 Feb 2004 20:54:03 +0000 (GMT)
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, 21 Feb 2004, BlaisorBlade wrote:

> Yes, you are perfectly right and what I wrote is at all foolish and stupid - I
> should have written len += UML_ROUND_UP(brk_start) - UML_ROUND_UP(&_end); (or
> something similar).

That doesn't help you either, because increasing len within setup_physmem
writes to memory that is going to be used for other purposes. The only way
around this amounts to increasing physmem_size anyway.

	Michael Young


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
