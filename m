Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5TaP-0003tW-Hb for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 11:23:57 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1C5TaN-00039o-SG for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Sep 2004 11:23:57 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Compiling UML 2.6.8.1 with Static Linking results in
	segfault
References: <E1C5GuB-0000wT-QX@sc8-sf-mx2.sourceforge.net>
In-Reply-To: <E1C5GuB-0000wT-QX@sc8-sf-mx2.sourceforge.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409092020.27856.blaisorblade_spam@yahoo.it>
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
Date: Thu, 9 Sep 2004 20:20:27 +0200
To: user-mode-linux-devel@lists.sourceforge.net, ralston@stral.net
Cc: 'Jeff Dike' <jdike@addtoit.com>

On Thursday 09 September 2004 06:51, Michael Ralston wrote:
> (gdb) run
> Starting program: /uml/linux-2.4.26-static
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x0815c520 in __libc_setup_tls ()
> (gdb) bt
> #0  0x0815c520 in __libc_setup_tls ()
> #1  0x0815c82b in __pthread_initialize_minimal ()
> #2  0x00000004 in ?? ()
> #3  0xbffffd88 in ?? ()
> #4  0x0815c2e8 in __libc_start_main ()
> Previous frame inner to this frame (corrupt stack?)
> (gdb)
>
>
> I compiled the uml binary with debugging symbols enabled... Let me know if
> there is anything else I can do... Would my complete .config be useful?
Please, try using the 2.6.7-1 patch. There are some changes which could be at 
fault. I'm referring to "load-low" and "link" from 
http://user-mode-linux.sourceforge.net/changelog-uml-patch-2.6.7-2.bz2.html.

At least, just for the reason they touch the linking script (after all, who 
says that the used start address should be the one we use, with TLS)?

Also, please run:
strings /usr/bin/ld | bzip2 >linkScript.bz2

and mail the obtained file (which contains the default linker scripts). I 
think I can build the patch for you easily, with that file; making it work on 
everyone's glibc could be harder.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
