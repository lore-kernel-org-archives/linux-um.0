Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DIw1W-0008Bi-KI for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Apr 2005 14:55:50 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DIw1U-0006oj-Di for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 05 Apr 2005 14:55:50 -0700
Received: from ccure.user-mode-linux.org (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.11.2) with ESMTP id j35L6B430085
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 5 Apr 2005 17:06:11 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] 2.6.9-bs7 panic on check_sysemu
Message-ID: <20050406002456.GA5430@ccure.user-mode-linux.org>
References: <4250729B.7040407@rimuhosting.com>
	<200504041532.23866.blaisorblade@yahoo.it>
	<200504051323.47160.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504051323.47160.rob@landley.net>
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
Date: Tue, 5 Apr 2005 20:24:56 -0400
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>, Peter <peter.spamcatcher@rimuhosting.com>

On Tue, Apr 05, 2005 at 01:23:47PM -0400, Rob Landley wrote:
> What's the minimal patch set that _just_ adds -SKAS0 mode to something like a 
> 2.6.11 kernel?  I'd like to try it out, but every time I sit down to whack at 
> it my interest budget runs out sifting through a mountain of unrelated x86-64 
> patches to try to figure out what exactly I need to apply to get just 
> SKAS0...

There isn't really one right now.  Those patches need to be cleaned up, 
merged, and disentanged from other stuff.

				Jeff


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
