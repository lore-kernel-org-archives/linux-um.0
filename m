Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AfitN-00057o-RG for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 08:56:49 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AfitK-0002gw-9g for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 11 Jan 2004 08:56:46 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Kernel mode fault at addr 0x48965000, ip0x400e51a4
References: <Pine.LNX.4.58.0312300027110.24938@silk.corp.fedex.com>
	<200401111334.04252.blaisorblade_spam@yahoo.it>
	<a0602042dbc271a5a5e68@[192.168.1.10]>
In-Reply-To: <a0602042dbc271a5a5e68@[192.168.1.10]>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401111646.16322.blaisorblade_spam@yahoo.it>
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
Date: Sun, 11 Jan 2004 16:46:16 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Johannes Formann <johannes@formann.de>, Jeff Chua <jchua@fedex.com>

Alle 16:25, domenica 11 gennaio 2004, Johannes Formann ha scritto:
> At 13:34 Uhr +0100 11.01.2004, BlaisorBlade wrote:
> >Why do you say "modules"? I.e. do you get that problem in a special

> > situation, like Jeff Chua that sees it only when he uses LVM? Does your
> > UML uses an initrd to load some modules?
>
> I've found that problem with ecery module I reyed (tun, ipv6, and a few
> more)
Sorry if I can seem dumb, but I need to understand well what you did.

What you mean by "every module I tried"? You get that error on boot or not? 
And if you get the error on boot, what changed between trying the various 
modules? Do you use an initrd?

I'm interested in this because the bug is caused by the disposition of kernel 
memory and maybe loading modules changes that disposition.

Also, Jeff, when you compiled LVM, did you compile it as module(as you speak 
about initrd) or statically?

Bye
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
