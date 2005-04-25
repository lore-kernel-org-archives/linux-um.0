Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQBQi-00015I-FI for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Apr 2005 14:47:48 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DQBQN-0004s3-Hf for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Apr 2005 14:47:48 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050425213448.GA6343@ccure.user-mode-linux.org>
References: <20050425191949.E56D145EBB@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425191949.E56D145EBB@zion>
Subject: [uml-devel] Re: [patch 1/1] uml ubd: handle readonly status
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
Date: Mon, 25 Apr 2005 17:34:48 -0400
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, axboe@suse.de

On Mon, Apr 25, 2005 at 09:19:49PM +0200, blaisorblade@yahoo.it wrote:
> +	/* This should no more be needed. And it didn't work anyway to exclude
> +	 * read-write remounting of filesystems.*/
> +	/*if((filp->f_mode & FMODE_WRITE) && !dev->openflags.w){
>  	        if(--dev->count == 0) ubd_close(dev);
>  	        err = -EROFS;
> -	}
> +	}*/

> +	/* This should be impossible now */

> +		/* This should be impossible now */

If code can't run any more because of now-impossible conditions, then just
delete it.

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
