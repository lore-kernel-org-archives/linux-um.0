Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Auvgd-00055d-Sy for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Feb 2004 07:38:31 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AuvP2-0008Ht-9A for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 22 Feb 2004 07:20:20 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: 2.4.24-1um - exec-shield - [PATCH][RFC] memory
	shortness fix
References: <200402162004.i1GK4isq024309@ccure.user-mode-linux.org>
	<200402211651.27584.blaisorblade_spam@yahoo.it>
	<Pine.LNX.4.58.0402212049160.25949@vega.dur.ac.uk>
In-Reply-To: <Pine.LNX.4.58.0402212049160.25949@vega.dur.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402221634.06668.blaisorblade_spam@yahoo.it>
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
Date: Sun, 22 Feb 2004 16:34:06 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: M A Young <m.a.young@durham.ac.uk>

Alle 21:54, sabato 21 febbraio 2004, M A Young ha scritto:
> On Sat, 21 Feb 2004, BlaisorBlade wrote:
> > Yes, you are perfectly right and what I wrote is at all foolish and
> > stupid - I should have written len += UML_ROUND_UP(brk_start) -
> > UML_ROUND_UP(&_end); (or something similar).
>
> That doesn't help you either, because increasing len within setup_physmem
> writes to memory that is going to be used for other purposes.
Why cannot we fix the other mmaps from the file?
> The only way
> around this amounts to increasing physmem_size anyway.

I must repeat myself: it seems that increasing physmem_size by, i.e., 4megas, 
when the user asked, i.e., for 32 mega, means that the kernel will have 
correctly 32mega of memory, but that it can try to access 36 mega of memory, 
right? I've actually checked that the statistics about how much memory it can 
use come from physmem_size, through init_maps() and mem_init():

        /* this will put all low memory onto the freelists */
        totalram_pages = free_all_bootmem();

Please, read this email and correct me on this point if I am wrong or confirm 
this behaviour.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
