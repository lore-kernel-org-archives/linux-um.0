Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9Ip1-0008QC-1W for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Mar 2005 00:15:07 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1D9Ip0-00018F-9I
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Mar 2005 00:15:06 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] Re: Fw: [patch] uml: terminal cleanup
Message-ID: <20050310081340.GC17880@bytesex>
References: <20041128010910.1b5478c7.akpm@osdl.org>
	<200503051858.05050.blaisorblade@yahoo.it>
	<20050308082502.GB23067@bytesex>
	<200503091938.46936.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503091938.46936.blaisorblade@yahoo.it>
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
Date: Thu, 10 Mar 2005 09:13:40 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

> No, this does not happen... the normal situation currently is that the kernel 
> skips printing part of the initial output.
> 
> $ ./OldKernels/vmlinux-2.6.11-rc3
> Checking for /proc/mm...found
> Checking for the skas3 patch in the host...found
> Checking PROT_EXEC mmap in /tmp...OK
> ject_hotplug - call_usermodehelper returned -1
> io scheduler noop registered
> NET: Registered protocol family 2
> IP: routing cache hash table of 256 buckets, 4Kbytes
> TCP established hash table entries: 2048 (order: 3, 32768 bytes)
> TCP bind hash table entries: 2048 (order: 2, 24576 bytes)
> TCP: Hash tables configured (established 2048 bind 2048)
> Initialized stdio console driver
> Console initialized on /dev/tty0
> Initializing software serial port version 1
> Kernel panic - not syncing: VFS: Unable to mount root fs on 
> unknown-block(98,0)

Ouch.  I've never seen that myself though, works perfectly fine for me.
Could be somehow related to the scrambled compiler logs reported a few
weeks ago, maybe the tty/line buffer handling is broken ...

> $ ./OldKernels/vmlinux-2.6.11-rc3 stderr=1

[ snip ]

as expected ...

> $ ./vmlinux-2.6.11-rc4-bk-testLock-nofix console=stderr
> Checking for /proc/mm...found
> Checking for the skas3 patch in the host...found
> Checking PROT_EXEC mmap in /tmp...OK
> [ no more messages ]

stderr=1 is needed in any case.  console=stderr might be needed
additionally in case you want to sent the kernel messages to _two_
console devices, i.e. something like this (both stderr and the xterm
for tty1):

# linux con=pts con1=xterm stderr=1 console=stderr console=tty1

HTH,

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
