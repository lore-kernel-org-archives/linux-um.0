Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AfPnP-000239-8J for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Jan 2004 12:33:23 -0800
Received: from 62-241-36-148.kunde.vdserver.de ([62.241.36.148] ident=mail)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AfPnN-0005HC-6F for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Jan 2004 12:33:21 -0800
Mime-Version: 1.0
Message-Id: <a06020426bc2611122f8b@[192.168.1.10]>
In-Reply-To: <200401072025.02885.blaisorblade_spam@yahoo.it>
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com>
	<a0602040dbc20be564c59@[192.168.1.10]>
	<Pine.LNX.4.58.0401070325360.1840@boston.corp.fedex.com>
	<200401072025.02885.blaisorblade_spam@yahoo.it>
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
Date: Sat, 10 Jan 2004 21:33:18 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

At 20:25 Uhr +0100 07.01.2004, BlaisorBlade wrote:

>The fix maybe is not perfect but something must go in. Also, if that doesn't
>work, maybe the error is somewhere else (and triggered by this change, as
>easily happens).

Has anyone found an workaround to get modules working with 23-1?

For the Simpel Patch doesn't work, and I think Jeff has change a few 
things more in mem.c between 22-5 and 23-1.

If anyone can't reproduce that Bug, I can give .configs, sources and 
or bianries away to someone who tries to trace that Bug.

regards

Johannes


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
