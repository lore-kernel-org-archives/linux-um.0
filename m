Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AsdBN-0002U8-6B
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 23:28:45 -0800
Received: from mx1.redhat.com ([66.187.233.31])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Asd81-0004XI-AL
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 15 Feb 2004 23:25:17 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <20040215232525.7c2f38a8.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Segfault of UML-TT on FC1
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
Date: Sun, 15 Feb 2004 23:25:25 -0800
To: user-mode-linux-devel@lists.sourceforge.net
Cc: zaitcev@redhat.com, mingo@redhat.com, jdike@karaya.com

Hi:

I'm trying to run uml-patch-2.6.3-rc2-1 under Fedora Core 1, kernel
2.4.22-1.2149.nptl, glibc 2.3.2-101.1. The uml runs in TT mode (FC1 doesn't
have SKAS) and segfaults while trying to do
 remap_data(UML_ROUND_DOWN(&__bss_start), UML_ROUND_UP(brk_start), 1);

The reason is the hole between BSS and heap on my system. If I run
with gdb and break at main(), an instance of uml looks like this:

[zaitcev@niphredil linux-2.6.3-rc2-uml-1-t1]$ cat /proc/22415/maps
a0000000-a01c6000 rwxp 00000000 03:04 442599     /q/zaitcev/uml/linux-2.6.3-rc2-uml-1-t1
a01c6000-a0294000 rw-p 00000000 00:00 0
a1f12000-a1f33000 rw-p 00000000 00:00 0
bff58000-c0000000 rwxp fff9f000 00:00 0
[zaitcev@niphredil linux-2.6.3-rc2-uml-1-t1]$

The &__bss_start at this point is a01c6000, abd brk_start is a1f33000,
and so memcpy segfaults when it steps on the hole.

Does anyone have a suggestion what to do about this?

-- Pete


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
