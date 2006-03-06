Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FG6m7-0003PT-0B for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Mar 2006 19:52:47 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FG6m5-00032h-RC
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 05 Mar 2006 19:52:47 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] patch for iomem uses
Message-ID: <20060306035354.GA22140@ccure.user-mode-linux.org>
References: <39134b110603051925y6f6176ffw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39134b110603051925y6f6176ffw@mail.gmail.com>
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
Date: Sun, 5 Mar 2006 22:53:54 -0500
To: wang lianwei <lianwei.wang@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Mar 06, 2006 at 11:25:37AM +0800, wang lianwei wrote:
>     the find_iomem function will case endless loop if you use two or more
> iomem to launch the UML kernel.

These look obviously correct.  Can you resend as a single, signed-off patch?

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
