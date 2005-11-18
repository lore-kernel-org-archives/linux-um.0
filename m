Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ed26O-0005ey-6L for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Nov 2005 01:00:12 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ed26M-00033I-Vn
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Nov 2005 01:00:12 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Getting the x86-64 rollup patch to work on my x86
	laptop.
References: <200511161100.31053.rob@landley.net>
	<200511180133.52547.rob@landley.net>
	<200511180858.43760.blaisorblade@yahoo.it>
In-Reply-To: <200511180858.43760.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511180259.59589.rob@landley.net>
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
Date: Fri, 18 Nov 2005 02:59:59 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Friday 18 November 2005 01:58, Blaisorblade wrote:

> > arch/um/sys-i386/built-in.o(.text+0x3b60): In function `load_TLS':
> > : undefined reference to `indirect_set_thread_area'
> >
> > collect2: ld returned 1 exit status
> >   KSYM    .tmp_kallsyms1.S
> > nm: '.tmp_vmlinux1': No such file
> > No valid symbol.
> > make[2]: *** [.tmp_kallsyms1.S] Error 1
> > make[1]: *** [_all] Error 2
> > make: *** [all] Error 2
> >
> > This is progress!
>
> Disable TT mode or play with such things IIRC

Nope, tt mode already is disabled.

> - actually there's a proper 
> fix along lines of "move #ifdef's inside sys-i386/tls.c to properly cater
> to dependencies" if you want.
>
> This comes from the TLS patches btw...

I'll be banging on this more in a bit...

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
