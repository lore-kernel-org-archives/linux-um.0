Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EWyqi-0001Fm-4r for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Nov 2005 08:19:00 -0800
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EWyqZ-0007QH-MW
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Nov 2005 08:18:54 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1EWyqV-0005Rc-UE for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Nov 2005 08:18:50 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH 9/10] UML - Big memory fixes
Message-ID: <20051101170633.GB6448@ccure.user-mode-linux.org>
References: <200510310439.j9V4dgqP000878@ccure.user-mode-linux.org>
	<200511011611.09532.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511011611.09532.blaisorblade@yahoo.it>
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
Date: Tue, 1 Nov 2005 12:06:33 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org, linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 04:11:04PM +0100, Blaisorblade wrote:
> I think this came up because there's (in -mm) Andi Kleen created a new zone 
> (ZONE_DMA32) for devices using 32-bit only DMA - but it seems it's not in 
> mainline).  (I don't know if that patch is in -mm actually, but I guess it 
> from this patch content).

Correct, nice spotting.

This chunk leaked from my -mm tree accidentally, so it is appropriate for -mm,
but it should be its own separate -mm-only patch.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
