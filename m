Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DdFP5-000468-1e	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 31 May 2005 15:40:07 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DdFP2-0000kK-GO	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 31 May 2005 15:40:06 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Problems applying patches to 2.6.12-rc5-mm1
Message-ID: <20050531220021.GA12091@ccure.user-mode-linux.org>
References: <s29c447f.050@ORANGE.OUS.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s29c447f.050@ORANGE.OUS.EDU>
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
Date: Tue, 31 May 2005 18:00:21 -0400
To: Anthony Brock <Anthony_Brock@ous.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, May 31, 2005 at 11:03:23AM -0700, Anthony Brock wrote:
> patching file arch/um/kernel/main.c
> Hunk #1 FAILED at 1.
> File arch/um/kernel/main.c is not empty after patch, as expected
> 1 out of 1 hunk FAILED -- rejects in file arch/um/kernel/main.c
> patching file arch/um/kernel/um_arch.c
> patching file arch/um/os-Linux/Makefile
> patching file arch/um/os-Linux/main.c
> Patch os-main does not apply (enforce with -f)
> # 

Grab the patches again.  I may have synced the patches when I didn't have
them all pushed.  I just synced again, and everything is applied, so these
should work.

Then get a stack trace from that.  I promise not to change too much in the
next day or two, so your line numbers should still match mine.

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
