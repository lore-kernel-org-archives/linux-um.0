Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DTPDK-0003TL-QW	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 May 2005 12:07:18 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DTPDK-0006O5-3k	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 May 2005 12:07:18 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Using SKAS, any examples?
References: <427895BC.2050201@manchester.ac.uk>
	<20050504132701.GA3755@ccure.user-mode-linux.org>
	<4278E113.9040109@manchester.ac.uk>
In-Reply-To: <4278E113.9040109@manchester.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505042103.16374.blaisorblade@yahoo.it>
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
Date: Wed, 4 May 2005 21:03:16 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Ian Rogers <ian.rogers@manchester.ac.uk>

On Wednesday 04 May 2005 16:49, Ian Rogers wrote:
> Jeff Dike wrote:
> >On Wed, May 04, 2005 at 10:28:28AM +0100, Ian Rogers wrote:
> >>What I'm hoping to do is to use SKAS to create a second address
> >>space I can, map, unmap, peek and poke from the first. The reason for
> >>this is to allow an emulator to live in the first address space and the
> >>emulated data... to live in the second.
> >
> >UML obviously does this.  Look at arch/um/kernel/skas/mem_user.c for the
> >basic primitives.  The creation and destruction of address spaces is done
> >in arch/um/kernel/skas/mmu.c.
>
> I've had a play with a simple test, but I need to work further on it.
> mem_user.c seems clear enough but I am slightly baffled by what is
> happening with the file descriptors in mmu.c.
>
> >>I hope to be able to access the
> >>second by altering the i386 selector value.
> >
> >What's the i386 selector value?
>
> I hope, for example, to set LDT 0 to point to the second address space.
> I can then swap the value of 7 (index 0, LDT, ring 3) into fs or gs
> whenever I hope to address the second address space. I can do similar
> code with modify_ldt but I'm restricted to using mmap to allocate memory
> and therefore I don't get a fully addressable 4gb address space.
You'll never get that, sadly, because the upper 1G is used by the kernel 
itself... This can be achieved on x86_64, even with 32bit binaries (if they 
are run with the right emulation).
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
