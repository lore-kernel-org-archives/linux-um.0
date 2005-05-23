Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DaDbN-0002n9-NA	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 May 2005 07:08:17 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DaDbL-0002Xs-Oz	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 23 May 2005 07:08:17 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] UML - 2.6.12-rc4-mm2 Compile error
References: <200505201436.j4KEZxjh006235@ccure.user-mode-linux.org>
	<4290E1C6.9070709@gmail.com>
In-Reply-To: <4290E1C6.9070709@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505231609.48425.blaisorblade@yahoo.it>
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
Date: Mon, 23 May 2005 16:09:47 +0200
To: user-mode-linux-devel@lists.sourceforge.net, eric.begot@gmail.com
Cc: Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org

On Sunday 22 May 2005 21:47, Eric BEGOT wrote:
> Here is a patch to correct a compile error on linux 2.6.12-rc4-mm2 for uml.
> At the compilation of init/main.c, it complains because it doens't find
> the 2 constants FIXADDR_USER_START and FIXADDR_USER_END
Why deleting FIXADDR_START? Also FIXADDR_USER_* are defined, just in a 
different way (and the patch below is IIRC uncorrect).
>
> --- linux-2.6.12-rc4-mm2/include/asm/fixmap.h.orig 2005-05-22
> 21:37:13.000000000 +0200
> +++ linux-2.6.12-rc4-mm2/include/asm/fixmap.h 2005-05-22
> 21:38:17.000000000 +0200
> @@ -60,7 +60,8 @@ extern unsigned long get_kmem_end(void);
>
> #define FIXADDR_TOP (get_kmem_end() - 0x2000)
> #define FIXADDR_SIZE (__end_of_fixed_addresses << PAGE_SHIFT)
> -#define FIXADDR_START (FIXADDR_TOP - FIXADDR_SIZE)
> +#define FIXADDR_USER_START (FIXADDR_TOP - FIXADDR_SIZE)
> +#define FIXADDR_USER_END FIXADDR_TOP
>
> #define __fix_to_virt(x) (FIXADDR_TOP - ((x) << PAGE_SHIFT))
> #define __virt_to_fix(x) ((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
> @@ -91,7 +92,7 @@ static inline unsigned long fix_to_virt(
>
> static inline unsigned long virt_to_fix(const unsigned long vaddr)
> {
> - BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_START);
> + BUG_ON(vaddr >= FIXADDR_TOP || vaddr < FIXADDR_USER_START);
> return __virt_to_fix(vaddr);
> }

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
