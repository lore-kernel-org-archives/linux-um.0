Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1TwV-0006ei-KJ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Feb 2005 10:30:31 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D1TwT-0000jZ-Si for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Feb 2005 10:30:31 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] problems making UML binary
References: <20050215155130Z2659002-7959+680@kps3.test.onet.pl>
In-Reply-To: <20050215155130Z2659002-7959+680@kps3.test.onet.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502161929.14267.blaisorblade@yahoo.it>
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
Date: Wed, 16 Feb 2005 19:29:13 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: adamdabr@poczta.onet.pl

On Tuesday 15 February 2005 16:49, adamdabr@poczta.onet.pl wrote:
> Hello,
>
> Could you please help me with the following problem?
>
> Here's a problem I've encountered when trying to compile an UML (User Mode
> Linux) linux binary:

> 5) Then I've tried make linux ARCH=um but got problems:
>  a) with gcc 3.4.1 that I started with (standard Mandrake 10.1 instalation)
> I've got a lot of errors like:
>
> "sched.c:839: error: conflicting types for 'sleep_on_timeout'
>
> /home/adam/work/UML/linux-2.4.27/include/linux/sched.h:598: error: previous
> declaration of 'sleep_on_timeout'
>
> was here"
No idea about this (yet)... maybe GCC became stricter about declaration 
consistency... Since the problem happens probably with i386, too, you might 
try the latest 2.4 with the same patch applied.

> So I guessed it was a gcc/Mandrake problem..
>  b) with gcc 3.3.1-2mdk or gcc 2.96-063mdk I got another problem - make
> linux ARCH=um runs smooth

> until it gets to linking: here is what I've got:
> "ld -r -o unmap_fin.o unmap.o -lc -L/usr/lib
> ld: cannot find -lc
> make[3]: *** [unmap_fin.o] Error 1
> make[3] Leaving directory
> `/home/adam/work/UML/linux-2.4.27/arch/um/kernel/tt' ..."

This is a message caused by missing /usr/lib/libc.a - install 
glibc-static-devel and this one *should* work fine. Actually, in my 
experience, gcc 3.3.2 from Mandrake 10 Official miscompiles UML / 2.4 (not 
reproducible with UML / 2.6). gcc 3.2.2 from Mandrake 9.1 installs and works 
well (use make ARCH=um CC='gcc-3.2.2' after installing it)... I've no 
experience with the 3.3.1 one.
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
