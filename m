Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPRvd-0007Pc-GU for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 12:40:25 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CPRvb-00008I-PO
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 12:40:25 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to
	kill host-OS processes (take #2)
Message-ID: <20041103201836.GB29289@bytesex>
References: <20041103113736.GA23041@taniwha.stupidest.org>
	<1099482457.16445.1.camel@imp.csi.cam.ac.uk>
	<20041103120829.GA23182@taniwha.stupidest.org>
	<200411032028.44376.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411032028.44376.blaisorblade_spam@yahoo.it>
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
Date: Wed, 3 Nov 2004 21:18:36 +0100
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Chris Wedgwood <cw@f00f.org>, Jeff Dike <jdike@addtoit.com>, Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>

> I'm going to test this. I thought that Gerd Knorr patch (which I sent cc'ing 
> LKML and most of you) already solved this (I actually modified that one, 

Not sure whenever tt is fixed with my patch, I've tested skas only (I'm
building skas-only dynamically linked kernels these days because due to
working on x11 framebuffer stuff which needs dynamically linked libX11).
So if Chris actually tested TT then his patch probably is ok and needed
as well ...

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
