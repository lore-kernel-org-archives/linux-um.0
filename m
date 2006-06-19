Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FsBR0-0006Cu-6M for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 21:32:22 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FsBQy-00024d-RN
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jun 2006 21:32:22 -0700
Message-ID: <449628CB.6050206@theshore.net>
Date: Sun, 18 Jun 2006 23:32:11 -0500
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
References: <44961CC8.1060302@theshore.net>
In-Reply-To: <44961CC8.1060302@theshore.net>
Subject: Re: [uml-devel] 2.6.17-um - new uptime record (40 years!)
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

Christopher S. Aker wrote:
> root@none:~ # uname -a
> Linux none 2.6.17-linode20 #1 Sun Jun 18 00:04:18 EDT 2006 i686 GNU/Linux
> root@none:~ # uptime
>   23:37:50 up 14663 days, 20:54,  1 user,  load average: 0.00, 0.00, 0.00
> root@none:~ # cat /proc/uptime
> 1266958484.15 69449.04
> 
> -Chris

OK, 2.6.17 final missed Jeff's "Fix wall_to_monotonic initialization" 
patch...

http://marc.theaimsgroup.com/?l=linux-kernel&m=115016859504778&w=2

I can confirm that this fixes the issue.  Queue this sucker up for the 
next stable release!

I hope nothing else was missed, but so far this is the only snag we've 
hit with 2.6.17-um.  Rock on!  Maybe now I can finally stop making new 
deployments default to 2.4-um.

-Chris


_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
