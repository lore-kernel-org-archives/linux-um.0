Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYAEW-0007Rn-3g	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 15:08:12 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DYAEU-0002ug-BR	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 15:08:11 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH] page.h warning fix
Message-ID: <20050517220301.GB10144@ccure.user-mode-linux.org>
References: <Pine.LNX.4.61.0505172033050.4083@mercury.foo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0505172033050.4083@mercury.foo>
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
Date: Tue, 17 May 2005 18:03:01 -0400
To: Dominik Hackl <dominik@hackl.dhs.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, May 17, 2005 at 09:09:45PM +0200, Dominik Hackl wrote:
> 
> 
> This patch removes a warning, caused by a cast of different sized types. 
> This patch simply adds a second cast to avoid the warning.
> 
> 	Signed-off-by: Dominik Hackl <dominik@hackl.dhs.org>

Yup, I already have this patch in my tree, and it's going to Andrew soon.

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
