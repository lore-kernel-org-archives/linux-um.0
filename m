Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZ8zw-0006bH-5S for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 07:33:28 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EZ8zu-0001Qg-KT
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 07:33:28 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Does UML 2.6.14 work under x86-64?
Message-ID: <20051107162541.GB4954@ccure.user-mode-linux.org>
References: <200511061723.32848.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511061723.32848.rob@landley.net>
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
Date: Mon, 7 Nov 2005 11:25:41 -0500
To: Rob Landley <rob@landley.net>
Cc: David Lang <dlang@invendra.net>, user-mode-linux-devel@lists.sourceforge.net

On Sun, Nov 06, 2005 at 05:23:32PM -0600, Rob Landley wrote:
> >> Kernel panic - not syncing: get_skas_faultinfo : failed to wait for
> >> SIGUSR1/SIGTRAP, pid = 16411, n = 16411, errno
> >> ? 0, status = 0xb7f

Can you apply the stub debugging patch (the first of the 10 patches I sent
to Andrew last week) and show us the output and the disassembly of 
stub_segv_handler?

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
