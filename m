Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPUSE-0004JF-0v for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 15:22:14 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CPUSC-0008Ka-Ts for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 15:22:13 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] UML: Use PTRACE_KILL instead of SIGKILL to
	kill host-OS processes (take #2)
References: <20041103113736.GA23041@taniwha.stupidest.org>
	<200411032028.44376.blaisorblade_spam@yahoo.it>
	<20041103201836.GB29289@bytesex>
In-Reply-To: <20041103201836.GB29289@bytesex>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411040019.07884.blaisorblade_spam@yahoo.it>
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
Date: Thu, 4 Nov 2004 00:19:07 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>, Chris Wedgwood <cw@f00f.org>, Jeff Dike <jdike@addtoit.com>, Anton Altaparmakov <aia21@cam.ac.uk>, Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>

On Wednesday 03 November 2004 21:18, Gerd Knorr wrote:
> > I'm going to test this. I thought that Gerd Knorr patch (which I sent
> > cc'ing LKML and most of you) already solved this (I actually modified
> > that one,

> Not sure whenever tt is fixed with my patch, I've tested skas only

I've tested it, and it works in fact.

> (I'm 
> building skas-only dynamically linked kernels these days because due to
> working on x11 framebuffer stuff which needs dynamically linked libX11).
> So if Chris actually tested TT then his patch probably is ok and needed
> as well ...

Actually, from looking at Jeff Dike comment, it seem that the new kill (the 
one you've changed) is executed earlier and more reliably than the 1st one, 
the one Chris identified.

So we could ask Jeff to see if he can remove the earlier kill, the one 
affected by the Chris Wedgwood.


-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
