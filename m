Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.92] (helo=sc8-sf-mx2-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DnAn2-00057o-VE	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Jun 2005 00:45:52 -0700
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by sc8-sf-mx2-new.sourceforge.net with esmtp (Exim 4.44)
	id 1DnAn0-0004kL-JB	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Jun 2005 00:45:53 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] NPTL can't be disabled in fc4?
In-Reply-To: <Pine.LNX.4.63.0506271724020.6543@sparrow>
Message-ID: <Pine.LNX.4.61.0506280925270.32041@filer.marasystems.com>
References: <Pine.LNX.4.63.0506271708560.6415@sparrow>
 <Pine.LNX.4.63.0506271724020.6543@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Tue, 28 Jun 2005 09:45:37 +0200 (CEST)
To: William Stearns <wstearns@pobox.com>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>

On Mon, 27 Jun 2005, William Stearns wrote:

> "raidautorun /dev/md0"
>       758 Segmentation fault      | nash --quiet

nash is statically linked

   ldd /sbin/nash
         not a dynamic executable

Why they use nash in the rc.sysinit script beats me. It is only supposed 
to be used in the initrd while bringing up the base hardware required to 
boot, not the full system.

You should be able to replace this with and mdadm call, given a suitable 
/etc/mdadm.conf file. Or disable it entirely if raid support is not 
needed.

> /etc/rc.d/rc.sysinit: line 340:   762 Segmentation fault /sbin/lvm.static
> vgscan --mknodes --ignorelockingfailure >/dev/null 2>&1

similar problem here.. lvm.static is a statically linked binary.

Regards
Henrik


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
