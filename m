Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EuWwh-0007Mi-R4 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Jan 2006 07:22:31 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EuWwg-0000Zb-9a
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Jan 2006 07:22:31 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060105161436.GA4426@ccure.user-mode-linux.org>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org>
	<Pine.LNX.4.61.0601050844550.10161@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601050844550.10161@yvahk01.tjqt.qr>
Subject: [uml-devel] Re: [PATCH 4/9] UML - Better diagnostics for broken
	configs
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
Date: Thu, 5 Jan 2006 11:14:36 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jan 05, 2006 at 08:45:36AM +0100, Jan Engelhardt wrote:
> >Produce a compile-time error if both MODE_SKAS and MODE_TT are disabled.
>
> What would happen if both were disabled?
> Say, if the host system does not have SKAS and I did not want any 
> tracing/debugging stuff?

You get a UML that can't run.  TT mode isn't tracing/debugging stuff.  It's 
a basic mode of UML operation.  Also, UML doesn't need the skas patch on
the host in order to use skas mode any more.  It helps, but is not necessary.

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
