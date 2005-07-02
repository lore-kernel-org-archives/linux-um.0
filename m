Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.91] (helo=sc8-sf-mx1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DopJY-0008Fk-HO	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 02 Jul 2005 14:14:16 -0700
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by sc8-sf-mx1-new.sourceforge.net with esmtp (Exim 4.44)
	id 1DopJW-0005jA-Tb	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 02 Jul 2005 14:14:16 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] Re: [PATCH 1/2] UML - skas0 - separate kernel address
 space on stock hosts
In-Reply-To: <200507020157.37593.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.61.0507022255500.26953@filer.marasystems.com>
References: <200507012131.j61LVCLi027276@ccure.user-mode-linux.org>
	<200507020157.37593.blaisorblade@yahoo.it>
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
Date: Sat, 2 Jul 2005 23:14:03 +0200 (CEST)
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, 2 Jul 2005, Blaisorblade wrote:

> [regarding uml-kill-some-useless-vmalloc-tlb-flushing.patch]
> However, for now it seems that I can't reproduce anyway the iptables crash,
> and even Jeff did some testing... so it seems it's ok.

If this is the same iptables crash due to vmalloc (or actually vfree) 
"randomly" mapping the wrong page for a while then it wasn't very easy to 
reproduce as it didn't always show up. But from what I recall we could 
always reproduce it by running iptables in a tight loop for a while (TT 
only, not SKAS).

http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=106982056512839&w=2
http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=107033811417279&w=2
http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=107038293326862&w=2

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
