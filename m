Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DCyQR-0007Ty-WC for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 03:16:55 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DCyQR-0008GN-8S for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Mar 2005 03:16:55 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] remap_page_range
References: <EAC7622167479948B614F8B9AD41C505ECA8F5@MAANDMBX2.ets.enterasys.com>
In-Reply-To: <EAC7622167479948B614F8B9AD41C505ECA8F5@MAANDMBX2.ets.enterasys.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503201216.35045.blaisorblade@yahoo.it>
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
Date: Sun, 20 Mar 2005 12:16:34 +0100
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: "Tsillas, Demetrios J" <jtsillas@enterasys.com>

On Thursday 17 March 2005 16:40, Tsillas, Demetrios J wrote:
> I'm trying to simulate some hardware with a driver
> which maps a region of kernel memory (allocated with
> kmalloc) to user space.
>
> The user is called mmap which gives him direct access
> to some register space.
Are you using 2.4? On 2.6.11 remap_page_range does not exists, so I guess yes 
(on earlier 2.6 it existed though).

> This works well on a real Linux box but when I try
> to simulate the register region with kernel memory,
> the writes from user space do not go into the kmalloc'ed
> region.
Have you tried on a real Linux box with kmalloc'ed memory, just for the sake 
of it?

Also, have you compared the code with 
http://www.xml.com/ldd/chapter/book/ch13.html#t1 (from Linux Device Drivers) 
and with drivers/char/mem.c: mmap_mem? I'm particularly suspicious about the 
use of VM_RESERVED

> Here are the pointers:
>
> 0x27 1f0 000 is returned from kmalloc
> 0x1f 1f0 000 is the above after a virt_to_phys
I.e. after subtracting 0x08 000 000, i.e. 128 M, which should be the value of 
uml_physmem... a bit strange. Actually, it's normal in SKAS mode and 
impossible in TT one, so you're running in SKAS mode.

In TT mode the value (set by arch/um/kernel/um_arch.c, in linux_main) should 
be 3G - 0.5G * (CONFIG_KERNEL_HALF_GIGS + CONFIG_NEST_LEVEL).

In SKAS mode, instead, it should be anyway bigger:

        return(((unsigned long) set_task_sizes_skas) & ~0xffffff);

That is a rounded pointer into the text section, and executables are mapped 
starting from 0x08048000, which is just above 128M... Ok, right, that value 
is correct, and you are running in SKAS mode.

> 0x404e9000 is the user's virtual address
>
> I use remap_page_range with:
>
> 0x404e9000, 0x1f1f0000, 65536, 0x39
Ok, just verified it's correct...
> The user writes to some offset in this region
> (using his virtual address). Reads back the value,
> all is good.
>
> The kernel tries to read the value using the
> virtual address (offset from 0x271f0000) and gets
> back zeros. I've also tried look at the phys addr
> (offset from 0x1f1f0000) and that too is zeros.
>
> Any help appreciated.
I've not looked very well to the above, and after I looked well it seems even 
less related, however the difference between i386 and Uml I can think of is:

The first thing that comes to my mind is that while on i386, if you read datas 
from userspace without copy_from_user, it mostly works, until the page is 
swapped or unavailable;

while on Uml SKAS mode (like i386 4G/4G mode) without copy_from_user you get 
meaningless datas (when it must be used); also one copy_from_user in excess 
is also dangerous in SKAS mode.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
