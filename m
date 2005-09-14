Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EFcKQ-0003bQ-PG	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 11:49:54 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EFcKM-0000dG-0s
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 14 Sep 2005 11:49:54 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] SYSEMU getting merged - but I'm in doubt
Message-ID: <20050914181914.GB9001@ccure.user-mode-linux.org>
References: <200509041702.18506.blaisorblade@yahoo.it>
	<20050906161032.GA6157@ccure.user-mode-linux.org>
	<43270396.5050102@fujitsu-siemens.com>
	<200509132023.10959.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509132023.10959.blaisorblade@yahoo.it>
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
Date: Wed, 14 Sep 2005 14:19:14 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>, "Charles P. Wright" <cwright@cs.sunysb.edu>

On Tue, Sep 13, 2005 at 08:23:10PM +0200, Blaisorblade wrote:
> Do you see contiguos codes? We jump from 24 to 31-32 (it was done for 
> something like having a common ABI with 2.4 and 2.6 hosts - don't ask me what 
> filled previous slots, however), so you shouldn't worry for this.

Whoops, didn't notice this.

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
