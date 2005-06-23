Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DlS3J-00040b-4F	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Jun 2005 06:47:33 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DlS3H-0002Rw-Gj	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Jun 2005 06:47:33 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: Skas0 general testing?
Message-ID: <20050623031135.GA16989@ccure.user-mode-linux.org>
References: <200506230238.35960.blaisorblade@yahoo.it>
	<20050623011255.GB15548@ccure.user-mode-linux.org>
	<200506230336.28927.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506230336.28927.blaisorblade@yahoo.it>
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
Date: Wed, 22 Jun 2005 23:11:35 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jun 23, 2005 at 03:36:26AM +0200, Blaisorblade wrote:
> I specified "operations done on the host" exactly for this purpose. That patch 
> will touch SKAS3 code, but if I set all three options to "yes" the code 
> should do the same things (again, in terms of strace output).
> 
> But however, if to keep the code clean we change (let's say) where a certain 
> signal handler is set to later in the boot process, *hoping* that it does not 
> hurt, that's against my definition.

OK, you sounded at first like you wanted stronger guarantees of no changes.
strace output being the same isn't that strong, but if you're happy with it,
that's fine by me.

You're OK with sending in skas0 and skas0-clone without first having a
complete, fully-polished patchset?

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
