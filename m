Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EvMUs-0005HI-RK for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Jan 2006 14:25:14 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EvMUr-00088J-Cy
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 07 Jan 2006 14:25:14 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [PATCH 4/9] UML - Better diagnostics for broken
	configs
Message-ID: <20060107231718.GA12226@ccure.user-mode-linux.org>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org>
	<20060105161436.GA4426@ccure.user-mode-linux.org>
	<Pine.LNX.4.61.0601052258350.27662@yvahk01.tjqt.qr>
	<200601061801.17497.rob@landley.net>
	<20060107023713.GA13285@ccure.user-mode-linux.org>
	<Pine.LNX.4.61.0601071612030.3578@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601071612030.3578@yvahk01.tjqt.qr>
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
Date: Sat, 7 Jan 2006 18:17:18 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org, linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 04:12:50PM +0100, Jan Engelhardt wrote:
> So there is no way to get UML compile on non-Linux.

Umm, no.  We're describing how it works on Linux.  That doesn't mean it
only can work on Linux.

The libc-dependent code movement which has been going into mainline is part
of making UML use VT (Intel hardware virtualization support), where the
runtime environment is different enough that it makes sense to handle this
as a port to a new OS.

There was also a nearly complete Windows port a few years ago which has
bitrotted since.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
