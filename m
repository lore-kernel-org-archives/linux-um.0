Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATUZ3-0000mt-GJ
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 15:13:17 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1ATUZ1-0007tt-Mo
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 15:13:15 -0800
Message-Id: <200312082326.hB8NQxAv030427@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Porting UML to other plattforms 
In-Reply-To: Your message of "Mon, 08 Dec 2003 23:14:00 +0100."
             <20031208221400.GC3553@hydra.joerghoh.de> 
References: <20031206224535.GF3376@hydra.joerghoh.de> <200312082042.hB8KgmAv029431@ccure.user-mode-linux.org>  <20031208221400.GC3553@hydra.joerghoh.de> 
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
Date: Mon, 08 Dec 2003 18:26:59 -0500
To: Joerg Hoh <joerg@devone.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

joerg@devone.org said:
> How does a hardware bug affect UML? The bugs should be "fixed" by the
> host kernel and therefore noone should see them (expect some very
> lowlevel software and the kernel). Can you explain this point to me? 

If the host kernel (or its maintainer) hasn't seen the bug yet, it's hard
to work around it.

And sometimes there is no workaround.  You need to fix the chip.

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
