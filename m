Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Atunc-00033W-BE
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 19 Feb 2004 12:29:32 -0800
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Atua0-0001wo-EU
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 19 Feb 2004 12:15:28 -0800
Received: from list by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1Atui7-0003JR-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 19 Feb 2004 21:23:51 +0100
Received: from pd9ee3de9.dip.t-dialin.net ([217.238.61.233])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <user-mode-linux-devel@lists.sourceforge.net>; Thu Feb 19 20:23:51 2004
Received: from skoehler by pd9ee3de9.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <user-mode-linux-devel@lists.sourceforge.net>; Thu Feb 19 20:23:51 2004
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <c1360l$eei$1@sea.gmane.org>
References: <40338C1B.1070800@meisterwerk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <40338C1B.1070800@meisterwerk.net>
Subject: [uml-devel] Re: skas3 patch fails against vanilla-2.4.25
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
Date: Thu, 19 Feb 2004 21:27:01 +0100
To: user-mode-linux-devel@lists.sourceforge.net

> but these two i couldn't fix.
> ("copy_segments" function seems to be gone)

Bad news:

I applied the 2.6.3-rc2 patch to a 2.6.3 kernel. This patch cleanly 
applies and i can compile a UML-kernel.

Than i applied the SKAS-patch by Gerd Knorr from
   http://www.suse.de/~kraxel/uml/patches/
and guess what happened when i tried to compile my host-kernel:

   LD      .tmp_vmlinux1
mm/built-in.o(.text+0x1d86f): In function `write_proc_mm':
: undefined reference to `mm_copy_segments'
make: *** [.tmp_vmlinux1] Error 1

So the copy_segments function has been removed from 2.4.25 and 2.6.3.



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
