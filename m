Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19t78F-000623-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 30 Aug 2003 07:55:15 -0700
Received: from tailtiu.davidcoulson.net ([207.166.203.132] helo=mail.mx.davidcoulson.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 19t78E-0006cb-L9
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 30 Aug 2003 07:55:14 -0700
Message-ID: <3F50BACE.2070004@davidcoulson.net>
From: David Coulson <david@davidcoulson.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Highmem compilation with 2.4.20-8um against 2.4.22.
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
Date: Sat, 30 Aug 2003 10:55:10 -0400
To: 

I tried to compile in highmem support with 2.4.22 patched with 
2.4.20-8um and it totally throws a shitfit. Anyone have any ideas? I can 
build 2.4.20-6um against 2.4.22-pre7, but I can't find anything obvious 
that changed to highmem between 2.4.22-pre7 and 2.4.22-release.

vmlinux.o(.text+0xce7fe): In function `mem_init':
: undefined reference to `phys_page'
vmlinux.o(.text+0xce998): In function `paging_init':
: undefined reference to `init_highmem'
vmlinux.o(.text+0xce9a4): In function `paging_init':
: undefined reference to `setup_highmem'
vmlinux.o(.text+0x129585): In function `skb_copy_bits':
: undefined reference to `kmap_prot'
vmlinux.o(.text+0x12958d): In function `skb_copy_bits':
: undefined reference to `kmap_pte'
vmlinux.o(.text+0x129848): In function `skb_checksum':
: undefined reference to `kmap_pte'
vmlinux.o(.text+0x12985b): In function `skb_checksum':
: undefined reference to `kmap_prot'
vmlinux.o(.text+0x129b8f): In function `skb_copy_and_csum_bits':
: undefined reference to `kmap_pte'
vmlinux.o(.text+0x129b9d): In function `skb_copy_and_csum_bits':
: undefined reference to `kmap_prot'
vmlinux.o(__ksymtab+0x2c0): undefined reference to `kmap_prot'
vmlinux.o(__ksymtab+0x2c8): undefined reference to `kmap_pte'
collect2: ld returned 1 exit status
make: *** [linux] Error 1

David

-- 
David Coulson                                    email: d@vidcoulson.com
Linux Developer /                          web: http://davidcoulson.net/
Network Engineer                                   phone: (216) 533-6967



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
