Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DuY1z-0004z8-OC	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Jul 2005 08:59:47 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.44)
	id 1DuY1w-00051A-CG	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Jul 2005 08:59:48 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] prot |= _PAGE_PCD | _PAGE_PWT;
References: <29D15BBCA340DA4D8146D38B4924FC7A105113@zcarhxm0.corp.nortel.com>
In-Reply-To: <29D15BBCA340DA4D8146D38B4924FC7A105113@zcarhxm0.corp.nortel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200507181807.33907.blaisorblade@yahoo.it>
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
Date: Mon, 18 Jul 2005 18:07:33 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Majid Salame <msalame@nortel.com>, Jeff Dike <jdike@addtoit.com>

On Friday 15 July 2005 21:26, Majid Salame wrote:
>  in asm-um/pgtable.h we do not have definitions and may be for good
> reason for PAGE_PCD and _PAGE_PWT.

From what I see, they're about uncacheability of memory, which isn't proba=
bly=20
supportable at all in UML (we might go to using madvise but I don't think=20
it's worth).

And as done in drivers/char/mem.c, there an access macro to use it, i.e.=20
pgprot_noncached, to use only if defined (I guess on arch missing it it=20
should be defined as a no-op).

> #define _PAGE_PWT	0x008
> #define _PAGE_PCD	0x010

> Can I in UML recode this statement in much same way drivers/char/mem.c
>      prot |=3D _PAGE_PCD | _PAGE_PWT;

So, what's the question? The answer is obviously yes. Note that I'm referri=
ng=20
to this version of the sources (taken from latest git snapshot):

static int mmap_mem(struct file * file, struct vm_area_struct * vma)
{
#if defined(__HAVE_PHYS_MEM_ACCESS_PROT)
        unsigned long offset =3D vma->vm_pgoff << PAGE_SHIFT;

        vma->vm_page_prot =3D phys_mem_access_prot(file, offset,
                                                 vma->vm_end - vma->vm_star=
t,
                                                 vma->vm_page_prot);
#elif defined(pgprot_noncached)
        unsigned long offset =3D vma->vm_pgoff << PAGE_SHIFT;
        int uncached;

        uncached =3D uncached_access(file, offset);
        if (uncached)
                vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
#endif

--=20
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

=09

=09
	=09
___________________________________=20
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB=20
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id=16492&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
