Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Asoqr-0004lu-JD
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 11:56:21 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Asoha-0007bC-8U
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 11:46:46 -0800
Message-Id: <200402162020.i1GKKMsq024335@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] syscall sysinfo error 
In-Reply-To: Your message of "Sun, 15 Feb 2004 17:35:13 +0100."
             <20040215163513.GA26606@neo.wh-stuttgart.de> 
References: <20040215163513.GA26606@neo.wh-stuttgart.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Mon, 16 Feb 2004 15:20:22 -0500
To: Martin =?iso-8859-1?Q?Thei=DF?= <mtheiss@neo.wh-stuttgart.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

mtheiss@neo.wh-stuttgart.de said:
> recently i tried to run debian-installer on a 2.6.2 uml kernel. it
> didn't work. i determined the problem has to be the syscall sysinfo.
> it return zeroed values for totalram and totalswap.

Nice diagnosis.  This looks fixed to me in the 2.6.3-rc2 UML.  I fixed
a bug with totalram_pages being duplicate (and leaving the generic totalram
at zero).  However, I didn't do anything with totalswap.

Now, /proc/meminfo shows
	SwapTotal:     1049592 kB
	SwapFree:      1049592 kB

and your little demo shows

	info.mem_unit  = 1
	info.totalram  = 128688128
	info.totalswap = 1074782208

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
