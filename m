Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EclwC-0005BO-Cx for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 07:44:36 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EclwB-0006aa-4J
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 07:44:36 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Getting the x86-64 rollup patch to work on my x86
	laptop.
Message-ID: <20051117163723.GA5878@ccure.user-mode-linux.org>
References: <200511161100.31053.rob@landley.net>
	<200511161811.38823.rob@landley.net>
	<20051117052622.GA12221@ccure.user-mode-linux.org>
	<200511170716.46519.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511170716.46519.rob@landley.net>
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
Date: Thu, 17 Nov 2005 11:37:23 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Nov 17, 2005 at 07:16:46AM -0600, Rob Landley wrote:
> is what I had to apply to 2.6.15-rc1 to get that to work).  I think that 
> included tls, but since the target system doesn't use it I don't know.

OK, well your recipe results in this

$ grep MODE obj1/.config
# CONFIG_MODE_TT is not set
# CONFIG_MODE_SKAS is not set

which is not a healthy config.  It fails to build here, but the errors are
different.

This case does need better error checking though.

Can you check a config that actually has a chance of running?

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
