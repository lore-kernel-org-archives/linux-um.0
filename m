Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ayhvb-0003J5-KZ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Mar 2004 17:45:35 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AyhP6-0004Uc-SL
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Mar 2004 17:12:01 -0800
Message-Id: <200403040202.i2422GWo008953@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] fix writing into /dev/kmem 
In-Reply-To: Your message of "Tue, 02 Mar 2004 19:41:52 +0100."
	<200403021941.52257.blaisorblade_spam@yahoo.it> 
References: <20040229023636.GB8272@ccure.user-mode-linux.org>
	<200402291325.40644.blaisorblade_spam@yahoo.it>
	<200403020131.i221VAM9025692@ccure.user-mode-linux.org>
	<200403021941.52257.blaisorblade_spam@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Wed, 03 Mar 2004 21:02:16 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> Well, on *i386* that is 0xc0000001; since klogd is built with i386
> kernel  headers, it will use those. 

This was the stupidity that I was refusing to believe in.  This means that
if you take a normal klogd and move it to a 2G/2G system, where the kernel
starts at 0x80000000, it won't work.

> Anyway, here comes that copy_{to,from}_user are buggy. Since fixing
> those  would have a good performance hit (to test, but that will
> probably be  sensitive

In skas mode, I wasn't expecting any legitimate unfixable kernel mode access
faults, so I wasn't setting up the fault_catcher.  So, what I did was add
a wrapper around the guts of copy_user which does a setjmp, and returns
whether it got longjmp-ed back to.

Reading /dev/kmem now produces -EFAULT.  Writing to it still causes a hang
because write_kmem doesn't check the return value of do_write_mem.  With that
fixed, everything produces -EFAULT.

The fix will be in the next patch.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
