Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AC5fF-0000mY-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 21 Oct 2003 16:11:45 -0700
Received: from parcelfarce.linux.theplanet.co.uk
	([195.92.249.252] helo=www.linux.org.uk ident=93)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.22)
	id 1AC5eu-0006hm-Qa
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 21 Oct 2003 16:11:24 -0700
From: Matthew Wilcox <willy@debian.org>
Message-ID: <20031021230932.GM18370@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] asm/smplock.h is dead
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
Date: Wed, 22 Oct 2003 00:09:32 +0100
To: Ralf Baechle <ralf@linux-mips.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Jeff Dike <jdike@karaya.com>
Cc: linux-mips@linux-mips.org, user-mode-linux-devel@lists.sourceforge.net


asm/smplock.h is dead, you're the only three arches that still have it.
Can you delete next time you merge?  Thanks.

$ find -type f |xargs grep smplock.h      
./arch/mips/sibyte/sb1250/bcm1250_tbprof.c:#include <asm/smplock.h>
./include/asm-h8300/smplock.h: * <asm/smplock.h>
./include/asm-um/smplock.h:#include "asm/arch/smplock.h"
$ find -name smplock.h
./include/asm-h8300/smplock.h
./include/asm-mips/smplock.h
./include/asm-um/smplock.h

(the sibyte driver can just lose this line.  it doesn't do any SMP locking)

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
