Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQb7A-0006kF-Uh for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 17:08:48 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BQb7A-00055k-Gn
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 19 May 2004 17:08:48 -0700
Message-Id: <200405200054.i4K0smDt002144@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [patch] uml network problem fix. 
In-Reply-To: Your message of "Thu, 13 May 2004 18:24:40 +0200."
	<20040513162440.GA28107@bytesex.org> 
References: <20040513162440.GA28107@bytesex.org> 
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
Date: Wed, 19 May 2004 20:54:48 -0400
To: Gerd Knorr <kraxel@bytesex.org>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

kraxel@bytesex.org said:
> Further investigations shows that the uml network driver irq handler
> isn't called for some reason.  Maybe because the socket fifo already
> is full and only _new_ data arriving is signaled via SIGIO?

Hmmm.  There's no atomic open-and-setup-sigio operation, so there's an
inherent race there.

> I've cured the issue with the one-liner patch below, which simply
> receives any pending packets after up'ing the interface.  I'm not sure
> if it is the right way to fix that through. 

It seems reasonable at first glance.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
