Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbiyT-0003jN-Op for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Jun 2004 09:45:49 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BbiyT-0008IC-6J for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Jun 2004 09:45:49 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Uml PATCH for 2.6.7
References: <200406181348.58968.blaisorblade_spam@yahoo.it>
	<40D45DFA.707@morpheux.org>
In-Reply-To: <40D45DFA.707@morpheux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406191856.31714.blaisorblade_spam@yahoo.it>
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
Date: Sat, 19 Jun 2004 18:56:31 +0200
To: Faye Gibbins <wibble@morpheux.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 17:38, sabato 19 giugno 2004, Faye Gibbins ha scritto:
> Hi,
>
> jusr finished compiling with the 2.6.7 patch. Compile died with:

> gcc -Wl,-T,arch/um/uml.lds.s -static -Wl,--wrap,malloc -Wl,--wrap,free
> -Wl,--wrap,calloc \
>          -o linux arch/um/main.o vmlinux -L/usr/lib -lutil
> vmlinux(.text+0x617f): In function `mem_init':
> arch/um/kernel/mem.c:71: undefined reference to `phys_page'

> vmlinux(.init.text+0x3268): In function `kmap_init':
> include/asm/pgtable.h:394: undefined reference to `pte_offset'
> collect2: ld returned 1 exit status
> make: *** [linux] Error 1

Don't enable CONFIG_HIGHMEM, it's probably again broken (but it's should not 
be my fault - if it works with the 2.6.6 patch and same config, complain 
again with me). However I've already seen it somewhere, so I don't think to 
be at fault. I've checked that both errors come from CONFIG_HIGHMEM actually.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
