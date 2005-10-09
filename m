Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOgeo-0002Ld-1j	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 12:16:26 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EOgek-00016r-Qy
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 12:16:28 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: UML/2.6.14-rc3 doesn't work fixes
References: <200510021213.40191.blaisorblade@yahoo.it>
	<20051004171845.GK7992@ftp.linux.org.uk>
	<20051004172446.GL7992@ftp.linux.org.uk>
In-Reply-To: <20051004172446.GL7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200510092116.41711.blaisorblade@yahoo.it>
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
Date: Sun, 9 Oct 2005 21:16:41 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Alexander Viro <viro@zeniv.linux.org.uk>

On Tuesday 04 October 2005 19:24, Al Viro wrote:
> 	Taking clone.c to sys-*, making it a normal kernel object, trimming
> stub.h
This deserves a bit more attention.

In fact, it is a possible fix to a misassembling problem - the current code 
loads registers in one asm() statement and expects them to be left unaltered 
in subsequent ones, which sometimes breaks.

But currently it breaks things, as this clone.c must be totally self-contained 
(it doesn't run in the kernel address space - think of vsyscall.S).
Btw, do you ever try booting UML? Seems not always, at least...

And "static int errno" isn't enough - it must be placed in the data section of 
the stub, but I don't want to address this for 2.6.14 (even because we are 
creating a new address space and I don't want to deal with stack lifecycles 
right now).

In fact, I've put together another patch for this, partly copying unistd.h 
macros. For your patch, we must resolve the errno problem first.

Also, making clone.c a kernel object is not conceptually right, because it is 
actually host-kernel specific (yes, we haven't ports to other host kernels, 
for now).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
