Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXkj4-0003Ri-PX	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 11:54:02 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DXkj2-0001XR-13	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 May 2005 11:54:02 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Removing call to function pointer in inner loop of
	copy_from_user()
Message-ID: <20050516184857.GA8171@ccure.user-mode-linux.org>
References: <200505152044.44400.blaisorblade@yahoo.it>
	<20050516150055.GA4977@ccure.user-mode-linux.org>
	<200505161904.14197.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505161904.14197.blaisorblade@yahoo.it>
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
Date: Mon, 16 May 2005 14:48:57 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Mon, May 16, 2005 at 07:04:13PM +0200, Blaisorblade wrote:
> I could move maybe move sigsetjmp to kernelspace code; 

How are you going to get a definition of jmp_buf in there?

> however, another 
> possibility would be to use the exception handler tables we've always 
> supported without using them (only drawback is that the code *must* be 
> inlined, and possibly the need for some assembler code, which however is 
> probably avoidable).

Maybe.  That's worth looking in to.  I've used the setjmp scheme in preference
to that because it's portable, but maybe we should switch back in some places.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
