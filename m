Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cdfrey@foursquare.net>) id 1Um7uD-0007Od-FI
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jun 2013 19:37:29 +0000
Received: from nic.netdirect.ca ([216.16.235.2] helo=rubicon.netdirect.ca)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Um7uC-0000yK-JY
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jun 2013 19:37:29 +0000
Received: from localhost (nic.NetDirect.CA [216.16.235.2])
	by rubicon.netdirect.ca (8.13.8/8.13.8) with ESMTP id r5AJbMbT023230
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 10 Jun 2013 15:37:22 -0400
Date: Mon, 10 Jun 2013 15:37:22 -0400
From: Chris Frey <cdfrey@foursquare.net>
Message-ID: <20130610193722.GA23009@foursquare.net>
Mime-Version: 1.0
Content-Disposition: inline
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
Subject: [uml-devel] kernel warning and hang in 3.4.47
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I'm running a 3.4.47 UML kernel on a 3.4.47 system.

Recently I got the following warning, just before the UML guest system
became unresponsive:

------------[ cut here ]------------
WARNING: at kernel/softirq.c:159 local_bh_enable+0x3b/0x8b()
Modules linked in:
21274430:  [<081f3adb>] dump_stack+0x1c/0x20

This is little to go on, I'm guessing.  What should I do to provide
more data?

Thanks,
- Chris


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

