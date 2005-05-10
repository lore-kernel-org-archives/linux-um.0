Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVdj0-000313-0q	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 May 2005 16:01:14 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DVdiy-0005xo-KF
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 May 2005 16:01:13 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1DVdit-0000bF-MF	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 May 2005 16:01:09 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050510225114.GA31101@ccure.user-mode-linux.org>
References: <200505102323.26945.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505102323.26945.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: About puncuation-fixes in incrementals
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
Date: Tue, 10 May 2005 18:51:14 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, May 10, 2005 at 11:23:26PM +0200, Blaisorblade wrote:
> - we have sysdep inside arch/um/include, and include "sysdep/...."; that's 
> nice.
> 
> - we should do the same for os-, moving arch/um/os-Linux/include/* to 
> arch/um/include/os-Linux/*, and include "os/file.h" (by doing a symlink)
> 
> - also, the same (without symlinking) should be done for arch/um/include/skas 
> and arch/um/include/tt, so that we include "skas/mode_kern.h" and 
> "tt/mode_kern.h". Without fiddling with include path depending on the mode 
> and so on.

Yeah, I agree, this sounds better than what we have now.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
