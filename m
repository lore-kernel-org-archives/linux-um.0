Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9Bu9-0003mu-Do for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 16:51:57 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1D9Bu6-000419-Ui
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 16:51:57 -0800
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20050309165122.47221983.akpm@osdl.org>
In-Reply-To: <200503100216.j2A2G6DN015238@ccure.user-mode-linux.org>
References: <200503100216.j2A2G6DN015238@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [PATCH 5/9] UML - change semaphores to completions
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
Date: Wed, 9 Mar 2005 16:51:22 -0800
To: Jeff Dike <jdike@addtoit.com>
Cc: torvalds@osdl.org, simlo@phys.au.dk, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Jeff Dike <jdike@addtoit.com> wrote:
>
> @@ -197,13 +197,14 @@
>   		{ .list 	 	= LIST_HEAD_INIT(port->list),
>   		  .wait_count		= ATOMIC_INIT(0),
>   		  .has_connection 	= 0,
>  -		  .sem 			= __SEMAPHORE_INITIALIZER(port->sem, 
>  -								  0),
>   		  .lock 		= SPIN_LOCK_UNLOCKED,
>   		  .port 	 	= port_num,
>   		  .fd  			= fd,
>   		  .pending 		= LIST_HEAD_INIT(port->pending),
>   		  .connections 		= LIST_HEAD_INIT(port->connections) });
>  +
>  +	init_completion(&port->done), 
>  +

I'll convert that to a semicolon...


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
