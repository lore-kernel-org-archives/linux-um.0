Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AxySz-0002ls-K4 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Mar 2004 17:13:01 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AxxzK-0004uu-Oe
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 Mar 2004 16:42:23 -0800
Message-Id: <200403020131.i221VAM9025692@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] fix writing into /dev/kmem 
In-Reply-To: Your message of "Sun, 29 Feb 2004 13:25:40 +0100."
	<200402291325.40644.blaisorblade_spam@yahoo.it> 
References: <20040229023636.GB8272@ccure.user-mode-linux.org>
	<200402291325.40644.blaisorblade_spam@yahoo.it> 
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
Date: Mon, 01 Mar 2004 20:31:10 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

blaisorblade_spam@yahoo.it said:
> This patch is like the one for the read from /dev/kmem (i.e. the one
> fixing  the panic when one does "cat /dev/kmem": you can reproduce
> this panic on  Uml2.6): it makes it behave like /dev/mem (man 4 mem is
> indeed helpful!). So  it is basically not *the right way*. 

Well, if you look at read_kmem, the thing that it reads is physical memory
plus kernel virtual memory.  I.e. /dev/kmem is /dev/mem + the kernel virtual
memory areas.

Addmittedly, I don't see how x86 gets away with dereferencing address 0, but
I don't see what's wrong with my fixes.  The file offsets being passed in
are effectively physical addresses, which need to be converted into virtual
addresses before being dereferenced, with is what __va() does, and __pa()
undoes.

Also, read_mem does the _va() correctly:
	if (copy_to_user(buf, __va(p), count))
		return -EFAULT;

while read_kmem does not:
	if (copy_to_user(buf, (char *)p, read))
		return -EFAULT;

The only out that I can see is that readers of kmem are supposed to pass in 
kernel virtual addresses, 0xc0000000 and up.  But, if so, those guys
fundamentally aren't going to work on UML because those addresses will be 
wrong.

It would be nice to see exactly what klogd is doing.

> To read the physical address  0x1with /dev/kmem, you are supposed to
> read 0xc0000001; so with that patch  any proper user of /dev/kmem will
> overflow p.

0xa0000001, actually, which is what __va does.

				Jeff



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
