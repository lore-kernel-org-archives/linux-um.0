Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuJA2-0005XF-1n for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Feb 2004 14:30:18 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuJ3x-0004Or-5J for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Feb 2004 14:24:01 -0800
From: M A Young <m.a.young@durham.ac.uk>
In-Reply-To: <200402201837.13918.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.58.0402202219290.23596@vega.dur.ac.uk>
References: <200402162004.i1GK4isq024309@ccure.user-mode-linux.org>
	<200402201837.13918.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: 2.4.24-1um - exec-shield - [PATCH][RFC] memory
	shortness fix
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
Date: Fri, 20 Feb 2004 22:23:51 +0000 (GMT)
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, 20 Feb 2004, BlaisorBlade wrote:

> The simple fix would be IMHO to add in setup_physmem:
>
>   offset -= UML_ROUND_UP(brk_start) - UML_ROUND_UP(&_end);

You can't do that because the memory you add to the physmem area isn't
empty, but includes memory used for other purposes, and using memory twice
isn't good!

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
