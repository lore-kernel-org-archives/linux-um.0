Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuC5i-0005hn-Df
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 20 Feb 2004 06:57:22 -0800
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuBzp-0006ma-4t
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 20 Feb 2004 06:51:17 -0800
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1AuBzm-0007Nt-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 20 Feb 2004 15:51:16 +0100
Received: from pd9ee386d.dip.t-dialin.net ([217.238.56.109])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <user-mode-linux-devel@lists.sourceforge.net>; Fri Feb 20 14:51:16 2004
Received: from skoehler by pd9ee386d.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <user-mode-linux-devel@lists.sourceforge.net>; Fri Feb 20 14:51:16 2004
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <c156t0$g3b$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] kernel BUG at kernel/exit.c:793!
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 20 Feb 2004 15:54:28 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

UML crashed with the following message:
Kernel panic: kernel BUG at kernel/exit.c:793!

I was just about to execute a pstree-command inside UML.
Than it crashed. There were several processes running:
- makewhatis cronjob
- emerge -upD (python program, starting many shells)

I'm running kernel 2.6.3 patched with 2.6.3-rc2-1 UML patch on a 2.6.3 
host patched with 2.6.3-rc2-1 UML patch and Gerd Knorr's SKAS patches.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
