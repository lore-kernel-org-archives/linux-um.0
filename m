Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuGMG-0005Hm-O0 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Feb 2004 11:30:44 -0800
Received: from [69.93.28.254] (helo=unix.easyadmin ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AuG7I-0001Sn-Op for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Feb 2004 11:15:16 -0800
From: Matt Ayres <matta@tektonic.net>
Content-Type: text/plain
Message-Id: <1077305069.8412.62.camel@wopr.tektonic.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] [PATCH] skas3 for x86_64 arch
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
Date: Fri, 20 Feb 2004 14:24:31 -0500
To: user-mode-linux-devel@lists.sourceforge.net

Hi,

I just did a quick port of the skas3 patch to the x86_64 architecture. 
Everything seems very straightforward except for the do_mmap2 function. 

I don't have a x86_64 machine or an emulator so I can't even verify this
even compiles.  I would appreciate if someone able to test this could
let me know if it compiles/works and if there are any problems provide
verbose information.  If it doesn't compile, pasting the errors of the
build should be enough. If it compiles but panics I would appreciate the
oops to be run through ksymoops and that output sent.

The patch is at: http://www.tektonic.net/public/host-skas3-x86_64.patch

Thanks!

-- 
Matt Ayres <matta@tektonic.net>
TekTonic



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
