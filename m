Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8O2T-0002k4-Ly for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Sep 2004 12:04:57 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C8O2R-0006Dz-Qa for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Sep 2004 12:04:57 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] skas3(-v3) for 2.4.27 with exec-shield
References: <20040916210145.GJ24624@shell.blacknet.de>
In-Reply-To: <20040916210145.GJ24624@shell.blacknet.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409172054.44049.blaisorblade_spam@yahoo.it>
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
Date: Fri, 17 Sep 2004 20:54:44 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Goetz Bock <bock+uml@blacknet.de>

On Thursday 16 September 2004 23:01, Goetz Bock wrote:
> Hi all,
>
> as I've no realy idea about the internal work of the skas patches, I'll
> have to bother you.
>
> I'd like to run a 2.4.27 kernel with exec-shield patch and skas3, if
> possible the -v3 version from BlaisorBlade, except that it does not
> apply :-(

> There are three conflicts in mm/mprotect.c but i suspect there are more
> not working sections.

> The patch seams to mainly change current->mm to mm, after defining
>
>     struct mm_struct * mm = vma->vm_mm;
>
> unfortunately i've no idea how current-> mm and vma->vm_mm (aka mm)
> relate. Are they the same?
Not at all; they must be different.
If you look below, you see that in the old code, sys_mprotect says: "I'm 
acting on current->mm"; the patch wants to be able to pass it any mm_struct 
(and this is done within mm/proc_mm.c), so I had to replace every reference 
to current->mm with a reference to the mm.

> Sorry, but obviosely I've no idea about the vm subsystem ... and not
> more about the rest of the kernel :-(
Don't worry.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
