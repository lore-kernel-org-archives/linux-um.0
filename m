Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CRZol-0006Qv-Ep for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 09:30:07 -0800
Received: from brown.brainfood.com ([146.82.138.61]
	helo=gradall.private.brainfood.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CRZoj-0006d2-Uw for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Nov 2004 09:30:07 -0800
From: Adam Heath <doogie@debian.org>
Subject: Re: [uml-devel] Re: Stop at startup on 2.6 NPTL hosts
In-Reply-To: <4190F385.1000802@fujitsu-siemens.com>
Message-ID: <Pine.LNX.4.58.0411091129180.1276@gradall.private.brainfood.com>
References: <20041029092641.8558.qmail@web26102.mail.ukl.yahoo.com>
	<200411021952.09095.blaisorblade_spam@yahoo.it>
	<4190F385.1000802@fujitsu-siemens.com>
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
Date: Tue, 9 Nov 2004 11:29:59 -0600 (CST)
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, 9 Nov 2004, Bodo Stroesser wrote:

> To work around, we could use the by-hand-syscall for os_getpid(). I didn't test it,
> but I'm quite shure, that it fixes the problem.

That would mean each arch has separate asm blocks.  Why not just use the
_syscall macros?


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
