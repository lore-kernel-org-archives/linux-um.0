Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dz0dp-0003Ph-Hl	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2005 16:21:17 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1Dz0dp-0000l2-8e
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Jul 2005 16:21:17 -0700
Message-ID: <42EC0C04.1050307@linode.com>
From: "Christopher S. Aker" <caker@linode.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] skas v8.2 results
References: <42EBEFAC.90208@rimuhosting.com>
In-Reply-To: <42EBEFAC.90208@rimuhosting.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Sat, 30 Jul 2005 18:23:48 -0500
To: Peter <peter.spamcatcher@rimuhosting.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Peter wrote:
> Hi.
> 
> We tried 2.6.12.3-skas3-v8.2 on a host server.  It kernel paniced (could 
> not capture the panic) after about 90 minutes.  I'd tried a 2.6.12 
> skasv8.2 a week or so back on another server and got the same result.

I had a similar problem a few weeks back when I attempted to run 
2.6.12.1 and skas-2.6.12-rc4-v9-pre4.  Crashed within 30 minutes or so, 
so I reverted back to 2.6.11.11 and skas-v8.  I haven't had the time to 
narrow down the problem.  It's on my to-do list for this week.

Incidentally, I've had kernel stability problems with the last dozen 
hosts I've placed online.  These machines crash with no console output 
after a few days to a few weeks uptime.  Haven't been able to track it 
down yet, but my hope is whatever it might be is fixed in more recent 
kernels.  It seems like a hardware or CPU speed and kernel version 
issue, since the identical kernel runs flawlessly on other, slower hosts.

I'll post more details in a few days.

-Chris


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
