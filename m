Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Afjx7-0007MM-0y for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 10:04:45 -0800
Received: from 62-241-36-148.kunde.vdserver.de ([62.241.36.148] ident=mail)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Afjx6-0003db-K8 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 10:04:44 -0800
Mime-Version: 1.0
Message-Id: <a0602042ebc27404e43b0@[192.168.1.10]>
In-Reply-To: <200401111646.16322.blaisorblade_spam@yahoo.it>
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com>
	<200401111334.04252.blaisorblade_spam@yahoo.it>
	<a0602042dbc271a5a5e68@[192.168.1.10]>
	<200401111646.16322.blaisorblade_spam@yahoo.it>
From: Johannes Formann <johannes@formann.de>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip0x400e51a4
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
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
Date: Sun, 11 Jan 2004 19:04:28 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Chua <jchua@fedex.com>

At 16:46 Uhr +0100 11.01.2004, BlaisorBlade wrote:

>What you mean by "every module I tried"? You get that error on boot or not?
>And if you get the error on boot, what changed between trying the various
>modules? Do you use an initrd?

Strange, after aplying the 23-1 patch to 2.4.24 and aplying Chuas 
(the first and  longer one) patch by hand, everything seems to run no.

I'll test and report if something happens.

regards Johannes


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
