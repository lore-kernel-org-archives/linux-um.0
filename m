Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AgLol-0001mm-BR for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jan 2004 02:30:39 -0800
Received: from main.gmane.org ([80.91.224.249])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AgLok-0003Rt-VZ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jan 2004 02:30:39 -0800
Received: from root by main.gmane.org with local (Exim 3.35 #1 (Debian))
	id 1AgLoi-0003Lx-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 13 Jan 2004 11:30:36 +0100
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Message-ID: <bu0gnf$ief$1@sea.gmane.org>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: uml-patch-2.6.0
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
Date: Tue, 13 Jan 2004 11:19:27 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

> The 2.6.0 UML patch is available at
> 	http://www.user-mode-linux.org/mirror/uml-patch-2.6.0-1.bz2

i get this error:

gcc -Wl,-T,arch/um/uml.lds.s -static -Wl,--wrap,malloc -Wl,--wrap,free 
-Wl,--wra
p,calloc \
	-o linux arch/um/main.o vmlinux -L/usr/lib -lutil
vmlinux(.text+0x5288): In function `mem_init':
: undefined reference to `phys_page'
vmlinux(.init.text+0x21f3): In function `kmap_init':
: undefined reference to `pte_offset'
collect2: ld returned 1 exit status

i applied this patch to clean 2.6.0 sources from kernel.org.
if you need more information just ask. i'm running gentoo 1.4 with a 
2.6.1 host kernel. linux 2.4.19 headers are installed in /usr/include, 
just in case it matters.




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
