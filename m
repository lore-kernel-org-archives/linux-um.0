Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbhvZ-0006Xh-Mv for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Jun 2004 08:38:45 -0700
Received: from morpheus-adsl.ednet.co.uk ([212.20.233.177]
	helo=mail.morpheux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1BbhvY-0000hh-VU
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Jun 2004 08:38:45 -0700
Message-ID: <40D45DFA.707@morpheux.org>
From: Faye Gibbins <wibble@morpheux.org>
MIME-Version: 1.0
Subject: Re: [uml-devel] Uml PATCH for 2.6.7
References: <200406181348.58968.blaisorblade_spam@yahoo.it>
In-Reply-To: <200406181348.58968.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Sat, 19 Jun 2004 16:38:34 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net


Hi,

jusr finished compiling with the 2.6.7 patch. Compile died with:


snip---

gcc -Wl,-T,arch/um/uml.lds.s -static -Wl,--wrap,malloc -Wl,--wrap,free 
-Wl,--wrap,calloc \
         -o linux arch/um/main.o vmlinux -L/usr/lib -lutil
vmlinux(.text+0x617f): In function `mem_init':
arch/um/kernel/mem.c:71: undefined reference to `phys_page'
vmlinux(.init.text+0x3268): In function `kmap_init':
include/asm/pgtable.h:394: undefined reference to `pte_offset'
collect2: ld returned 1 exit status
make: *** [linux] Error 1


snip---

Yours
Faye

This time she's the lesser of two evils.

http://www.morpheux.org





BlaisorBlade wrote:
> I'm going to upload it ASAP onto my page:
> 
> http://www.user-mode-linux.org/~blaisorblade.
> 
> I just took 2.6.6-1um (from Jeff Dike, not my older forward ports) and fixed 
> some rejects (plus I checked the API changes done to arch/um and 
> include/asm-um and extended them: the only one was this: 
> 
> -                       atomic_set(&page->count, 1);
> +                       set_page_count(page, 1);
> 
> which I applied to other users in the UML patch).
> 
> It's ready (I've compiled and tested it). There where just 2 easy rejects. It 
> has some innocous offsets (if it hasn't it will mean I later fixed them). No 
> functional change in it.
> 
> Jeff, would you accept a such patch for the main UML site, if nobody complains 
> in 2-3 days and we get some success reports?


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
