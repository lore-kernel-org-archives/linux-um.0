Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B5e3e-0002pf-9C for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Mar 2004 21:02:34 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1B5e3d-0006pR-C0 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Mar 2004 21:02:33 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] problems with kernel-2.6.1(UML)
References: <362b01c40ee7$26b1b070$2000000a@schlepptopp>
	<Pine.LNX.4.58.0403220308250.7230@mars.cse.iitb.ac.in>
In-Reply-To: <Pine.LNX.4.58.0403220308250.7230@mars.cse.iitb.ac.in>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403222006.02034.blaisorblade_spam@yahoo.it>
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
Date: Mon, 22 Mar 2004 20:06:02 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Alle 23:18, domenica 21 marzo 2004, K Santhosh Kumar ha scritto:
> Host Kernel: 2.6.1-1.57skas3+mpls1custom
>
>
> UML configuration
> kernel    => linux-2.6.1
> uml-patch => uml-patch-2.6.1-1
Well, use kernel 2.6.4 and patch 2.6.4 and the problem 2 will go out by sure, 
problem 3 will maybe disappear and problem 1 could also.

About config: in your answer it can be useful to specify the command lines you 
use and the hardware on the host (at least CPU type and freq + RAM size)

> with root_fs   => root_fs.rh-7.2-full.pristine.20020312
> -------------------------------------
> 1) I am not able to create COW files
Say what you do *exactly* and we'll help you.

>         During the booting of virtual machine I get the
>   following  error, but it will not stuck.
stuck? 
>   Error: MM: mm:core: failed to acquire shared memory segment (Cannot
>   allocate memory): OS: No such file or directory  [FAILED]
>
>   PS: I can login to the terminals(xterms)  which are popped up and also
>       can connect to the network.

So what is the problem exactly? You get the "MM..." error only when you use 
COW? Or always? Anyhow, it seems that a service is failing to start. Identify 
which one is and tell us.

> with root_fs => root_fs.rh-9-full.pristine.20030724
> -----------------------------------
> 3) During the booting time the kernel stucks at
>
> 	----------------------
> 	802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
> 	All bugs added by David S. Miller <davem@redhat.com>
> 	 /dev/ubd/disc0: unknown partition table
> 	VFS: Mounted root (ext2 filesystem) readonly.
> 	Mounted devfs on /dev
> 	----------------------

Try loop-mounting the root_fs and renaming /lib/tls away. This is probably an 
issue with NPTL, if it happens starting from RH 9 root_fs.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
