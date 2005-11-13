Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eb5uG-0001F1-1U for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 16:39:40 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Eb5uE-0006b9-Me
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 12 Nov 2005 16:39:40 -0800
Received: from localhost.localdomain (localhost [127.0.0.1])
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id jAD2D45e021414
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 12 Nov 2005 21:13:04 -0500
From: Rob Landley <rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511121839.25818.rob@landley.net>
Subject: [uml-devel] 2.6.15-rc1 build break on x86-64.
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
Date: Sat, 12 Nov 2005 18:39:25 -0600
To: user-mode-linux-devel@lists.sourceforge.net

Ok, I got it to build on x86 (kconfig behavior changed, which broke my build).  
Wandered over to the x86-64 system and tried to build there, and got this:

  CC      lib/rwsem.o
lib/rwsem.c: In function `__rwsem_do_wake':
lib/rwsem.c:57: warning: implicit declaration of function 
`rwsem_atomic_update'
lib/rwsem.c:57: error: `RWSEM_ACTIVE_BIAS' undeclared (first use in this 
function)
lib/rwsem.c:57: error: (Each undeclared identifier is reported only once
lib/rwsem.c:57: error: for each function it appears in.)
lib/rwsem.c:59: error: `RWSEM_ACTIVE_MASK' undeclared (first use in this 
function)
lib/rwsem.c:108: error: `RWSEM_WAITING_BIAS' undeclared (first use in this 
function)
lib/rwsem.c:113: warning: implicit declaration of function `rwsem_atomic_add'
lib/rwsem.c: In function `rwsem_down_failed_common':
lib/rwsem.c:163: error: `RWSEM_ACTIVE_MASK' undeclared (first use in this 
function)
lib/rwsem.c: In function `rwsem_down_read_failed':
lib/rwsem.c:193: error: `RWSEM_WAITING_BIAS' undeclared (first use in this 
function)
lib/rwsem.c:193: error: `RWSEM_ACTIVE_BIAS' undeclared (first use in this 
function)
lib/rwsem.c: In function `rwsem_down_write_failed':
lib/rwsem.c:210: error: `RWSEM_ACTIVE_BIAS' undeclared (first use in this 
function)
make[1]: *** [lib/rwsem.o] Bd 1
make: *** [lib] Bd 2

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
