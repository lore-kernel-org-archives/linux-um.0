Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AfofQ-0002xj-HL for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 15:06:48 -0800
Received: from mx13.sac.fedex.com ([199.81.197.53])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AfofQ-0002hJ-40
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 15:06:48 -0800
Received: from inet03.prod.fedex.com (inet03.prod.fedex.com [199.81.10.43])
	by mx13.sac.fedex.com (8.12.6p2/8.12.3) with ESMTP id i0BN6Ww1065775
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 11 Jan 2004 17:06:32 -0600 (CST) (envelope-from jchua@fedex.com)
Received: from entpm11.apac.fedex.com (entpm11.apac.fedex.com [155.161.92.11])
	by inet03.prod.fedex.com (8.12.10/8.12.10) with ESMTP id
	i0BN6UN9020813 for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 11 Jan 2004 17:06:31 -0600 (CST)
From: Jeff Chua <jchua@fedex.com>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip0x400e51a4
In-Reply-To: <200401111646.16322.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.58.0401120702070.4503@silk.corp.fedex.com>
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com>
	<200401111334.04252.blaisorblade_spam@yahoo.it>
	<a0602042dbc271a5a5e68@[192.168.1.10]>
	<200401111646.16322.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Mon, 12 Jan 2004 07:04:58 +0800 (SGT)
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Johannes Formann <johannes@formann.de>, Jeff Chua <jchua@fedex.com>


On Sun, 11 Jan 2004, BlaisorBlade wrote:

> Also, Jeff, when you compiled LVM, did you compile it as module(as you speak
> about initrd) or statically?

LVM dm-mod (device mapper) is module.

If I don't load this and not start vgscan, mount lvm devices, I don't see
klog segmentation fault.

Jeff



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
