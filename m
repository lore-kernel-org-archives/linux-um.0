Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1NJh-0002tk-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 02:49:13 -0700
Received: from solar.nuked.org ([66.11.174.19])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A1NJg-0007iP-9S
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 22 Sep 2003 02:49:12 -0700
From: Rod Moffitt <rodlist@rod.info>
In-Reply-To: <20030920173518.521B03BCE7@home.petschge.de>
Message-ID: <Pine.LNX.4.58.0309220535000.28187@crystal.nuked.org>
References: <200309182037.h8IKbMEk028815@hongkong.cs.nmsu.edu>
 <20030919095020.294F93BCE4@home.petschge.de> <20030920173518.521B03BCE7@home.petschge.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] skas & /proc/mm in the host kernel, yet /proc/mm 'not found'
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
Date: Mon, 22 Sep 2003 05:49:41 -0400 (EDT)
To: user-mode-linux-devel@lists.sourceforge.net

I have been trying to build a recent host kernel with the host-skas3.patch
however when I attempt to run a skas aware UML kernel it claims /proc/mm
is 'not found', even though the skas3 patch was detected:

  Checking for the skas3 patch in the host...found
  Checking for /proc/mm...not found

Eventually I get a kernel panic:

  Mounted devfs on /dev
  Kernel panic: init_new_context_skas - new_mm failed, errno = -2

However /proc/mm does exist (it's 0222) on the machine.

I tried patching stock kernels including 2.4.19, 20, 21 and 22 and the
same thing occurs on all of them. I understand there might be some
tweaking needed for the later kernels, however I was under the impression
that this patch was meant for a stock 2.4.19.

Any help would be appreciated.

Thanks,

- Rod

--
                         ___  ____  ___    _      ___
 Rod Moffitt            / _ \/ __ \/ _ \  (_)__  / _/__
 http://rod.info       / , _/ /_/ / // / / / _ \/ _/ _ \
 rodANTISPAM@rod.info /_/|_|\____/____(*)_/_//_/_/ \___/
 ========================================================
 ~ Where loved ones are remembered: http://memoriam.org ~



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
