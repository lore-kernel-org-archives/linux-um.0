Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xf1F-0001KD-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 11 Sep 2003 20:54:49 -0700
Received: from [202.181.236.208] (helo=ms.instant-host.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19xf1E-0001nm-Py
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 11 Sep 2003 20:54:48 -0700
Message-ID: <41727.202.181.236.220.1063339431.squirrel@secure.yoric.net>
From: "Vincent" <vincent@yoric.net>
Reply-To: vincent@yoric.net
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Subject: [uml-devel] Can not compile uml 2.4.22-3 with highmem support
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
Date: Fri, 12 Sep 2003 12:03:51 +0800 (HKT)
To: user-mode-linux-devel@lists.sourceforge.net

gcc -Wl,-T,arch/um/link.ld -static -Wl,--wrap,malloc -Wl,--wrap,free
-Wl,--wrap,calloc \
        -o linux arch/um/main.o vmlinux.o -L/usr/lib -lutil
vmlinux.o: In function `do_wp_page':
vmlinux.o(.text+0x25446): undefined reference to `kmap_prot'
vmlinux.o(.text+0x2544e): undefined reference to `kmap_pte'
vmlinux.o(.text+0x254b2): undefined reference to `kmap_prot'
vmlinux.o(.text+0x254ba): undefined reference to `kmap_pte'
vmlinux.o(.text+0x25515): undefined reference to `kmap_prot'
vmlinux.o(.text+0x2551d): undefined reference to `kmap_pte'
vmlinux.o: In function `do_anonymous_page':
vmlinux.o(.text+0x259ca): undefined reference to `kmap_prot'
vmlinux.o(.text+0x259d2): undefined reference to `kmap_pte'
vmlinux.o: In function `do_no_page':
vmlinux.o(.text+0x25b62): undefined reference to `kmap_prot'
vmlinux.o(.text+0x25b6a): undefined reference to `kmap_pte'
vmlinux.o(.text+0x25bc4): undefined reference to `kmap_prot'
vmlinux.o(.text+0x25bcc): undefined reference to `kmap_pte'
vmlinux.o: In function `shmem_getpage':
vmlinux.o(.text+0x34412): undefined reference to `kmap_prot'
vmlinux.o(.text+0x3441a): undefined reference to `kmap_pte'
vmlinux.o(.text+0x34476): undefined reference to `kmap_prot'
vmlinux.o(.text+0x34481): undefined reference to `kmap_pte'
vmlinux.o: In function `kmap_high':
vmlinux.o(.text+0x34eb1): undefined reference to `kmap_prot'
vmlinux.o: In function `bounce_end_io_read':
vmlinux.o(.text+0x350f6): undefined reference to `kmap_prot'
vmlinux.o(.text+0x350fe): undefined reference to `kmap_pte'
vmlinux.o: In function `create_bounce':
i can not compile 2.4.22-3 with highmem support. everything works fine
without highmem support. error as follow.

vmlinux.o(.text+0x353fd): undefined reference to `kmap_prot'
vmlinux.o(.text+0x35405): undefined reference to `kmap_pte'
vmlinux.o: In function `mem_init':
vmlinux.o(.text+0xc245f): undefined reference to `phys_page'
vmlinux.o: In function `paging_init':
vmlinux.o(.text+0xc25f4): undefined reference to `init_highmem'
vmlinux.o(.text+0xc2600): undefined reference to `setup_highmem'
vmlinux.o: In function `skb_copy_bits':
vmlinux.o(.text+0x10e1c9): undefined reference to `kmap_prot'
vmlinux.o(.text+0x10e1d1): undefined reference to `kmap_pte'
vmlinux.o: In function `skb_checksum':
vmlinux.o(.text+0x10e44d): undefined reference to `kmap_prot'
vmlinux.o(.text+0x10e455): undefined reference to `kmap_pte'
vmlinux.o: In function `skb_copy_and_csum_bits':
vmlinux.o(.text+0x10e795): undefined reference to `kmap_prot'
vmlinux.o(.text+0x10e79d): undefined reference to `kmap_pte'
vmlinux.o(__ksymtab+0x2c0): undefined reference to `kmap_prot'
vmlinux.o(__ksymtab+0x2c8): undefined reference to `kmap_pte'
collect2: ld returned 1 exit status
make: *** [linux] Error 1

- Vincent


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
