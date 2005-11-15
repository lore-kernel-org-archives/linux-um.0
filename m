Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eboxe-0006Pe-Ij for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 16:46:10 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Eboxd-00040O-BQ
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Nov 2005 16:46:10 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH] Ok, I build x86-64 -skas0,
	and it still segfaults.
Message-ID: <20051115013855.GA12719@ccure.user-mode-linux.org>
References: <200511121936.41697.rob@landley.net>
	<20051114215517.GA9579@ccure.user-mode-linux.org>
	<200511141724.55055.rob@landley.net>
	<200511141745.44703.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511141745.44703.rob@landley.net>
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
Date: Mon, 14 Nov 2005 20:38:55 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>

On Mon, Nov 14, 2005 at 05:45:44PM -0600, Rob Landley wrote:
> The breakage, by the way, (which occurs when you fix the failing hunk #2 up by 
> hand) stems from the inability to find asm/signal.h:

What distro is this?  asm/signal is in glibc-kernheaders here:

% rpm -q -f /usr/include/asm/signal.h
glibc-kernheaders-2.4-9.1.94


				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
