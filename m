Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AfhT9-0001Z3-O6 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 07:25:39 -0800
Received: from 62-241-36-148.kunde.vdserver.de ([62.241.36.148] ident=mail)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AfhT9-0003hn-6w for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 07:25:39 -0800
Mime-Version: 1.0
Message-Id: <a0602042dbc271a5a5e68@[192.168.1.10]>
In-Reply-To: <200401111334.04252.blaisorblade_spam@yahoo.it>
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com>
	<200401072025.02885.blaisorblade_spam@yahoo.it>
	<a06020426bc2611122f8b@[192.168.1.10]>
	<200401111334.04252.blaisorblade_spam@yahoo.it>
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
Date: Sun, 11 Jan 2004 16:25:31 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

At 13:34 Uhr +0100 11.01.2004, BlaisorBlade wrote:

>Why do you say "modules"? I.e. do you get that problem in a special situation,
>like Jeff Chua that sees it only when he uses LVM? Does your UML uses an
>initrd to load some modules?

I've found that problem with ecery module I reyed (tun, ipv6, and a few more)

>Jeff Chua posted 2 patches. The second was shorter BUT I'm *at all* sure it
>cannot do anything (by having read and understood it).

The shorter Patch shows no change in the behavior, and the longer one 
doesn't work (seems like mem.c has changed a bit more since 22-5um)

>I think you should
>apply his first change, or, as a workaround, disable klogd from inside UML

That could be a bit handy,

>  or
>remove /dev/kmem.

But that sounds manageable, I'll have only to llok where I can 
disable that (I'm usind defs, but I'm shure I can find that.


Thanks for your hint

regatds Johannes


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
