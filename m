Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQ0hE-0008CW-6N for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Apr 2005 03:20:08 -0700
Received: from ns.virtualhost.dk ([195.184.98.160] helo=virtualhost.dk)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1DQ0hB-00028g-V2
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Apr 2005 03:20:07 -0700
From: Jens Axboe <axboe@suse.de>
Message-ID: <20050425101625.GD1671@suse.de>
References: <20050424181924.EAFCB55D06@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050424181924.EAFCB55D06@zion>
Subject: [uml-devel] Re: [patch 7/7] uml ubd: handle readonly status
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
Date: Mon, 25 Apr 2005 12:16:26 +0200
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, bstroesser@fujitsu-siemens.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sun, Apr 24 2005, blaisorblade@yahoo.it wrote:
> @@ -1099,6 +1104,7 @@ static int prepare_request(struct reques
>  	if((rq_data_dir(req) == WRITE) && !dev->openflags.w){
>  		printk("Write attempted on readonly ubd device %s\n", 
>  		       disk->disk_name);
> +		WARN_ON(1); /* This should be impossible now */
>  		end_request(req, 0);
>  		return(1);
>  	}

I don't think that's a sound change. The WARN_ON() is strictly only
really useful for when you need the stack trace for something
interesting. As the io happens async, you will get a boring trace that
doesn't contain any valuable information.

-- 
Jens Axboe



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
