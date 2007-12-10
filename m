Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J1kp7-0005Lo-An for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Dec 2007 07:45:37 -0800
Received: from apollo.fprintf.net ([208.75.87.34])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J1kp4-0007lg-3V
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Dec 2007 07:45:35 -0800
From: Daniel Gryniewicz <dang@gentoo.org>
In-Reply-To: <20071208141753.GA4667@c2.user-mode-linux.org>
References: <20071208141753.GA4667@c2.user-mode-linux.org>
Date: Mon, 10 Dec 2007 10:45:32 -0500
Message-Id: <1197301533.6483.440.camel@athena.fprintf.net>
Mime-Version: 1.0
Subject: Re: [uml-devel] SKAS3 for 2.6.23
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: greg@enjellic.com, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Sat, 2007-12-08 at 09:17 -0500, Jeff Dike wrote:
> A skas3 patch which works on 2.6.23 is below. 

BTW, it would appear that applying this patch breaks building the
resulting kernel as a guest kernel, at least on x86_64.
asm-x86_64/proc_mm.h doesn't end up in asm/, and the #includes don't use
asm/arch.  I don't know if it's intended that this should work as a
guest kernel?

Daniel


-------------------------------------------------------------------------
SF.Net email is sponsored by: 
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
