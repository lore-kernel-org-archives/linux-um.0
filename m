Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EXOZF-0005Ot-To for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Nov 2005 11:46:41 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EXOZB-00043H-Gu
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Nov 2005 11:46:42 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 8/10] UML - Maintain own LDT entries
References: <200510310439.j9V4dfbw000872@ccure.user-mode-linux.org>
In-Reply-To: <200510310439.j9V4dfbw000872@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511022051.24335.blaisorblade@yahoo.it>
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
Date: Wed, 2 Nov 2005 20:51:22 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, bstroesser@fujitsu-siemens.com, Allan Graves <allan.graves@oracle.com>

On Monday 31 October 2005 05:39, Jeff Dike wrote:
> From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
>
> Patch imlements full LDT handling in SKAS:
>  * UML holds it's own LDT table, used to deliver data on
>    modify_ldt(READ)
>  * UML disables the default_ldt, inherited from the host (SKAS3)
>    or resets LDT entries, set by host's clib and inherited in
>    SKAS0
>  * A new global variable skas_needs_stub is inserted, that
>    can be used to decide, whether stub-pages must be supported
>    or not.
>  * Uses the syscall-stub to replace missing PTRACE_LDT (therefore,
>    write_ldt_entry needs to be modified)
Two complaints against this patch (to be fixed afterwards, so I'm not CC'ing 
akpm):

*) It reverts my cleanup and consolidation of ldt.c wrt. SKAS vs TT.

Or at least so I think (I must still give a proper look afterwards, and I'll 
post patches). Actually it seems that this is done on purpose, but I don't 
agree too much on this. I will see.

*) Doesn't compile on old GCC's - it uses anonymous unions:
(it's asm-um/ldt-i386.h).
> +
> +struct ldt_entry {
> +	__u32 a;
> +	__u32 b;
> +};

> +typedef struct uml_ldt {
> +	int entry_count;
> +	struct semaphore semaphore;
> +	union {
> +		struct ldt_entry * pages[LDT_PAGES_MAX];
> +		struct ldt_entry entries[LDT_DIRECT_ENTRIES];
> +	};
> +} uml_ldt_t;

Suggestions for almost free replacement of anonymous union: 
> Index: 2.6.14-akpm/include/asm-um/ldt.h
> ===================================================================
> --- 2.6.14-akpm.orig/include/asm-um/ldt.h	2005-08-28 19:41:01.000000000
> -0400 +++ 2.6.14-akpm/include/asm-um/ldt.h	2005-10-28 17:31:07.000000000
AAAAAAAAAAAARGH!!!!!!!!!!!!!! This is supposed to be a  _SYMLINK_!

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
