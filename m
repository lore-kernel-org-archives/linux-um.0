Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A6cph-0006kw-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 06 Oct 2003 14:23:57 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A6cpf-0004Ds-25
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 06 Oct 2003 14:23:55 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h96LDgj06815
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 6 Oct 2003 17:13:42 -0400
Message-Id: <200310062125.h96LPbGj020880@ccure.karaya.com>
Subject: Re: [uml-devel] skas & /proc/mm in the host kernel, yet /proc/mm 'not found' 
In-Reply-To: Your message of "Sun, 28 Sep 2003 16:45:28 BST."
             <87fzig533b.fsf@amaterasu.srvr.nix> 
References: <200309182037.h8IKbMEk028815@hongkong.cs.nmsu.edu> <20030919095020.294F93BCE4@home.petschge.de> <20030920173518.521B03BCE7@home.petschge.de> <Pine.LNX.4.58.0309220535000.28187@crystal.nuked.org> <200309232016.h8NKGNaK003251@ccure.karaya.com> <Pine.LNX.4.58.0309232330340.28187@crystal.nuked.org> <200309241619.h8OGJwaK006019@ccure.karaya.com>  <87fzig533b.fsf@amaterasu.srvr.nix> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 06 Oct 2003 17:25:37 -0400
To: Nix <nix@esperi.demon.co.uk>
Cc: Rod Moffitt <rodlist@rod.info>, user-mode-linux-devel@lists.sourceforge.net

nix@esperi.demon.co.uk said:
> hppfs_open : failed to open a socket in 'proc/uptime/r', err = 1
> Kernel panic: init_new_context_skas - new_mm failed, errno = -24 

I don't see how these can be related.  They are totally separate pieces of
code.

> (Plus, the init_new_context_skas is looking for /proc/mm on the
> *host*, isn't it?

Yes.

>  Hm, maybe I'm barking up a gum tree here.  Anyway, I
> haven't seen the init_new_context_skas error since I stopped using
> hppfs. It's still built in, just not mounted anymore.)

Hmmm, maybe there is some relationship, but I have no idea what it would be.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
