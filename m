Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATS0C-0007UU-TZ
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 12:29:08 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1ATS0A-0001BV-R7
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 12:29:07 -0800
Message-Id: <200312082042.hB8KgmAv029431@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Porting UML to other plattforms 
In-Reply-To: Your message of "Sat, 06 Dec 2003 23:45:35 +0100."
             <20031206224535.GF3376@hydra.joerghoh.de> 
References: <20031206224535.GF3376@hydra.joerghoh.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Mon, 08 Dec 2003 15:42:48 -0500
To: Joerg Hoh <joerg@devone.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

joerg@devone.org said:
> Can someone tell me, how hard is the job to port UML to other
> plattforms than i386 (how far went the ppc port?).

In principal, it shouldn't be too hard.  In practice, the immature arch 
abstraction layer inside UML is a problem, but this should be improved once
I get the x86_64 port merged.

More troublesome are are host-specific problems.  Every architecture that UML
has run on has exposed toolchain problems of one sort or another.  Host kernel
and hardware bugs are also somewhat common.  These are what will hold up any
new port, rather than any problems with UML itself.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
