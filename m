Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DdXEm-0003KG-Be	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Jun 2005 10:42:40 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DdXEk-0007dL-P4	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Jun 2005 10:42:40 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Problem with /dev/random and rngd daemon
Message-ID: <20050601173719.GA12514@ccure.user-mode-linux.org>
References: <s29d8993.000@ORANGE.OUS.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s29d8993.000@ORANGE.OUS.EDU>
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
Date: Wed, 1 Jun 2005 13:37:19 -0400
To: Anthony Brock <Anthony_Brock@ous.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Jun 01, 2005 at 10:09:50AM -0700, Anthony Brock wrote:
> I'm now running two systems with Jeff's patches for pulling entropy
> from the host's /dev/random. The first host I boot comes up fine
> (successfully loads rngd). However, the second fails to load rngd. I
> 'm getting back a return code of '1' from the daemon (the rng-source
> is misbehaving) after a pause of 10 seconds. Any ideas? 

strace it?

		Jeff


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
