Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFGAP-0006sd-JK	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Sep 2005 12:10:05 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EFGAN-0004yl-Dh
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Sep 2005 12:10:05 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: sys_ptrace consolidation and S390 port
Message-ID: <20050913190248.GA8634@ccure.user-mode-linux.org>
References: <200508121855.02633.blaisorblade@yahoo.it>
	<4326D06A.9070206@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4326D06A.9070206@fujitsu-siemens.com>
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
Date: Tue, 13 Sep 2005 15:02:48 -0400
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Tue, Sep 13, 2005 at 03:13:14PM +0200, Bodo Stroesser wrote:
> Thank you for the hint.
> I'll have to reinsert SUBARCH_PTRACE_SPECIAL later.

Yes, it's generally a good idea to submit a user whenever you add 
infrastructure.  Makes it easier to review.

So, this should be closely tied to the s390 patch.

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
