Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DaGot-0005TS-7G	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 May 2005 10:34:27 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DaGor-0004fj-FT	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 May 2005 10:34:27 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] UML - 2.6.12-rc4-mm2 Compile error
References: <200505201436.j4KEZxjh006235@ccure.user-mode-linux.org>
	<200505231609.48425.blaisorblade@yahoo.it>
	<E1DaDj3-0002Xf-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1DaDj3-0002Xf-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505231936.01102.blaisorblade@yahoo.it>
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
Date: Mon, 23 May 2005 19:36:00 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Miklos Szeredi <miklos@szeredi.hu>, eric.begot@gmail.com, jdike@addtoit.com, akpm@osdl.org, linux-kernel@vger.kernel.org

On Monday 23 May 2005 16:16, Miklos Szeredi wrote:
> > > Here is a patch to correct a compile error on linux 2.6.12-rc4-mm2 for
> > > uml. At the compilation of init/main.c, it complains because it doens't
> > > find the 2 constants FIXADDR_USER_START and FIXADDR_USER_END
> >
> > Why deleting FIXADDR_START? Also FIXADDR_USER_* are defined, just in a
> > different way (and the patch below is IIRC uncorrect).
>
> I've seen this error too after 'make menuconfig ARCH=um' on a clean
> tree.
>
> The following fixes it:
>
>   cp .config /tmp
>   make mrproper ARCH=um
>   cp /tmp/.config .
>   make ARCH=um
>
> So there's definitely something wrong with the build on UML.
Yes, an empty include/asm-um/elf.h which is not by default replaced by a 
symlink. Sadly a patch which should have been deleted it simply emptied it 
(courtesy of quilt). So

include/asm-um/elf.h:
	$(call create_the_symlink)
(which is pseudo-code) won't create it.

As a last resort I'll force that symlink to be unconditional (I hope not 
needing this).
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
