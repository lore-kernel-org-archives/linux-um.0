Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBLnz-0007g8-3R for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Apr 2004 15:45:59 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BBLny-000119-E6 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Apr 2004 15:45:58 -0700
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] Quick and dirty patch for 2.6.5 + 2.6.4-um1 patch
In-Reply-To: <200404072351.51418.sikkh@wp.pl>
Message-ID: <Pine.LNX.4.44.0404080044580.31008-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 8 Apr 2004 00:45:51 +0200 (CEST)
To: Piotr Neuman <sikkh@wp.pl>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, 7 Apr 2004, Piotr Neuman wrote:

> Here it goes:
> diff -ruN linux/include/asm-i386/system.h uml/linux/include/asm-i386/system.h
> --- linux/include/asm-i386/system.h	2004-04-07 23:29:03.000000000 +0200
> +++ uml/linux/include/asm-i386/system.h	2004-04-07 23:24:39.000000000 +0200
> @@ -243,6 +243,7 @@
>  #define __HAVE_ARCH_CMPXCHG 1
>  #endif
>  
> +#ifndef __UM_SYSTEM_I386_H 
>  static inline unsigned long __cmpxchg(volatile void *ptr, unsigned long old,
>  				      unsigned long new, int size)
>  {
> @@ -270,6 +271,8 @@
>  	return old;
>  }
>  
> +#endif
> +
>  #define cmpxchg(ptr,o,n)\
>  	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
>  					(unsigned long)(n),sizeof(*(ptr))))


For others impatient requiring 2.4: Same thing is needed for compiling
2.4.26-rc2...

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
