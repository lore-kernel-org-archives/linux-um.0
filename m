Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4iIo-0000Kf-Nz for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 08:54:38 -0700
Received: from tharec.debianbase.de ([212.79.163.254] helo=mail2.debianbase.de)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C4iIm-0003at-M7 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Sep 2004 08:54:37 -0700
Received: from mail.debianbase.de (tha.vpn.local [192.168.100.1])
	by mail2.debianbase.de (Postfix) with ESMTP id 8D2489B5C
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue,  7 Sep 2004 17:54:26 +0200 (CEST)
Received: from vaiobook.tha.local (vaiobook.tha.local [10.0.0.9])
	by mail.tha.local (Postfix) with ESMTP id 3D2FAB70986
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue,  7 Sep 2004 17:54:36 +0200 (CEST)
From: Ralph =?iso-8859-1?q?Pa=DFgang?= <ralph@debianbase.de>
Subject: Re: [uml-devel] Host: 2.6.7, guest: 2.6.8.1, without SKAS
References: <Pine.LNX.4.61.0409071058020.25003@hosting.rdsbv.ro>
	<12503.1094564116@camelot-054>
In-Reply-To: <12503.1094564116@camelot-054>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409071754.25380.ralph@debianbase.de>
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
Date: Tue, 7 Sep 2004 17:54:25 +0200
To: user-mode-linux-devel@lists.sourceforge.net

Am Dienstag 07 September 2004 15:35 schrieb Michael Richardson:
> >>>>> "ux" == ux aka Dino <Catalin> writes:
>
>     ux> This is what I get when I run a 2.6.8.1 guest:
>
>     ux> Kernel panic: fix_range fixing wrong address space, current =
> 0xa3fba760 ux> <6>SysRq : Show Regs
>
>     ux> EIP: 0073:[<a01a2d9b>] CPU: 0 Not tainted ESP: 007b:a0369688
> EFLAGS: 00000246 ux> Not tainted
>
>   I get variously different failures, mostly at the same place.
>

I made some experience with 2.6 kernel and I think this are the two most 
common problems for a not correct starting uml:

1) in the fs of the uml you have to move /lib/tls to /lib/tls.disable (to 
disable ntpl)

2) if you don't use the skas mode, you HAVE to mount /tmp as tmpfs,  otherwise 
the uml will not start (kernel panics at diffrent locations while booting, 
smetimes it even works without tmpfs)

Point 2 seems to be a bug, but I don't analysed it enough to say why this 
happens...

--Ralph


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
