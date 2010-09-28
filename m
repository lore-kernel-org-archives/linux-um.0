Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <cdfrey@foursquare.net>) id 1P0P7n-0004rA-Vn
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Sep 2010 01:36:55 +0000
Received: from nic.netdirect.ca ([216.16.235.2] helo=rubicon.netdirect.ca)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P0P7m-0001wq-Vq
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Sep 2010 01:36:55 +0000
Received: from localhost (nic.NetDirect.CA [216.16.235.2])
	by rubicon.netdirect.ca (8.13.8/8.13.8) with ESMTP id o8S1amN8030645
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 27 Sep 2010 21:36:48 -0400
Date: Mon, 27 Sep 2010 21:36:48 -0400
From: Chris Frey <cdfrey@foursquare.net>
Message-ID: <20100928013648.GA30506@foursquare.net>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] ext3 filesystem corruption in user mode linux
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I thought it might be useful to point to the linux-kernel thread on
the same topic, which can be found here:

	http://marc.info/?t=128530280700001&r=1&w=2

So far, Richard Weinberger and I have reproduced the problem.
Additional tips or fixes are quite welcome.

Thanks,
- Chris


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

