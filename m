Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DXyzk-0008JJ-Pd	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 03:08:12 -0700
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DXyzi-0002r9-48
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 03:08:12 -0700
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20050517100317.GB20584@bytesex>
References: <200505170005.43629.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505170005.43629.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: uml-general-protection-fault even more kludgy but
	mergeable
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
Date: Tue, 17 May 2005 12:03:17 +0200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

> So, in practice, it's correct to call bad_segv() as done in the patch, but we 
> miss some cases. Only this time I've verified this well enough that I feel we 
> could merge your patch. However, I've not found any possible *realistic* 
> source of general protection faults. Especially I didn't find what expected 
> (i.e. I/O errors).

The case I trapped into was an attempt to access I/O ports of a
process running inside the uml.  The uml kernel then tried to
handle that as page fault, which didn't work very well ...

  Gerd

-- 
-mm seems unusually stable at present.
	-- akpm about 2.6.12-rc3-mm3


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
