Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZZaZ-00081a-OI for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Dec 2004 10:52:31 -0800
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CZZaT-0003kp-Ka for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Dec 2004 10:52:31 -0800
Message-ID: <41AE12E4.9080609@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] 2.6.9-bb3 on 2.6.9 host problem - triggering a host
	bug?
References: <200411292315.25368.blaisorblade_spam@yahoo.it>
	<200411301950.13529.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411301950.13529.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Wed, 01 Dec 2004 19:52:20 +0100
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, BlaisorBlade <blaisorblade_spam@yahoo.it>

Blaisorblade wrote:
> On Monday 29 November 2004 23:15, Blaisorblade wrote:
> 
> However, I've now discovered that it only happens when CONFIG_STATIC_LINK is 
> enabled - that makes the kernel die. The interesting thing is that it becomes 
> unkillable
Have found the reason for the task to become unkillable, i.e. state 'D'.

There is a bug in 2.6.9 and up in fs/exec.c

If the kernel does coredump_wait(), it tries to kill all other threads, that are
running on the same mm. Therefore it calls "force_sig_specific(SIGKILL, p)".
But if one of the threads is on a ptrace-stop, SIGKILL has no effect.
The killing thread will wait forever in "D".

Bodo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
