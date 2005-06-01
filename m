Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DdZxU-0003vc-RP	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Jun 2005 13:37:00 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DdZxQ-0007HO-9L	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Jun 2005 13:37:00 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Problems applying patches to 2.6.12-rc5-mm1
Message-ID: <20050601203142.GB14652@ccure.user-mode-linux.org>
References: <s29d95a6.056@ORANGE.OUS.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s29d95a6.056@ORANGE.OUS.EDU>
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
Date: Wed, 1 Jun 2005 16:31:42 -0400
To: Anthony Brock <Anthony_Brock@ous.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, jdike@addtoit.com

On Wed, Jun 01, 2005 at 11:01:33AM -0700, Anthony Brock wrote:
> I'm now seeing new messages appear on the console with the
> 2.6.12-rc5-mm1 kernel that I haven't seen with the 2.6.11.x series
> kernels: 
> 
> sigio_handler: os_waiting_for_events: poll returned -1, errno = 4

That's EINTR, should be harmless.  I just need to check for that and
retry the poll.

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
