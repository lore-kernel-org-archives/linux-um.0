Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CH7h7-0006PE-Ob for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 14:27:01 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CH7gy-0007MG-L9 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Oct 2004 14:27:01 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: Missing exported symbols?
References: <200410091057.52832.u3205097@anu.edu.au>
	<lars-DC2FA7.15580109102004@sea.gmane.org>
In-Reply-To: <lars-DC2FA7.15580109102004@sea.gmane.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410112327.08166.blaisorblade_spam@yahoo.it>
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
Date: Mon, 11 Oct 2004 23:27:08 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Lars Kellogg-Stedman <lars@oddbit.com>

On Saturday 09 October 2004 21:58, Lars Kellogg-Stedman wrote:
> > I'm still using the 2.6.8 uml patch release, and I'm getting heaps of
> > errors complaining about unknown symbols.  In particular:
> > WARNING: ../mnt/ lib/modules/2.6.8-1um/kernel/fs/cifs/cifs.ko needs
> > unknown symbol memmove
>
> Adding:
>
> #undef __HAVE_ARCH_MEMMOVE
>
> to include/asm-um/string.h (after the two #include statements) will
> force UML to use the memmove() defined in lib/string.c.  I don't know if
> this is the right solution or not, but it appears to resolve the missing
> symbol problem.
It does not change anything. memmove *is* defined by glibc. However, 
lib/string.c adds the "EXPORT_SYMBOL(memmove);" line, which is the correct 
line to add to arch/um/os-Linux/user_syms.c, after putting in the correct 
prototype.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
