Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdIQm-0008Tf-It for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Nov 2005 18:26:20 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EdIQm-0007rv-1e
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Nov 2005 18:26:20 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Getting the x86-64 rollup patch to work on my x86
	laptop.
References: <200511161100.31053.rob@landley.net>
	<200511180858.43760.blaisorblade@yahoo.it>
	<200511180259.59589.rob@landley.net>
In-Reply-To: <200511180259.59589.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511190335.06204.blaisorblade@yahoo.it>
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
Date: Sat, 19 Nov 2005 03:35:05 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, Jeff Dike <jdike@addtoit.com>

On Friday 18 November 2005 09:59, Rob Landley wrote:
> On Friday 18 November 2005 01:58, Blaisorblade wrote:
> > > arch/um/sys-i386/built-in.o(.text+0x3b60): In function `load_TLS':
> > > : undefined reference to `indirect_set_thread_area'
> > >
> > > collect2: ld returned 1 exit status
> > >   KSYM    .tmp_kallsyms1.S
> > > nm: '.tmp_vmlinux1': No such file
> > > No valid symbol.
> > > make[2]: *** [.tmp_kallsyms1.S] Error 1
> > > make[1]: *** [_all] Error 2
> > > make: *** [all] Error 2
> > >
> > > This is progress!
> >
> > Disable TT mode or play with such things IIRC
>
> Nope, tt mode already is disabled.

Be creative - enable it then... yep, indirect_... is defined only when TT is 
active, but is also used otherwise.

> > - actually there's a proper
> > fix along lines of "move #ifdef's inside sys-i386/tls.c to properly cater
> > to dependencies" if you want.
> >
> > This comes from the TLS patches btw...

> I'll be banging on this more in a bit...

> Rob

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
