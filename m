Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxziZ-00008i-Rp for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Mar 2004 18:33:11 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AxzWV-00014n-JU
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Mar 2004 18:20:43 -0800
Message-Id: <200403020251.i222pMM9026039@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Overhead of UML-skas 
In-Reply-To: Your message of "Mon, 01 Mar 2004 19:55:16 EST."
	<Pine.LNX.4.44.0403011920310.23055-100000@stclair.eecs.umich.edu> 
References: <Pine.LNX.4.44.0403011920310.23055-100000@stclair.eecs.umich.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Mon, 01 Mar 2004 21:51:22 -0500
To: George Washington Dunlap III <dunlapg@umich.edu>
Cc: William Stearns <wstearns@pobox.com>, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

dunlapg@umich.edu said:
> Our standard mode of operation is to have ayncronous I/O turned off by
> default, because of the extra process that's created.  

Have the build on the host do it on a O_SYNC filesystem and see how fast it
goes.

> (It has to do
> with the research we're doing right now.)  I explicitly enabled it for
> this build, and verified that the helper process was being created. It
> resulted in a marked speed increase (about 6% for this benchmark, if
> you're interested). 

FWIW, I'd expect a 20-30% slowdown from the host on a kernel build.  I see
25-30% on my laptop, Matt Ayes in #uml said he saw 20% on one of his servers.

				Jeff



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
