Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYqLi-0000lg-4U
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 23 Dec 2003 09:29:38 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AYqLg-0005YO-5u
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 23 Dec 2003 09:29:36 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] early setup
Message-ID: <20031223174609.GA19599@ccure.user-mode-linux.org>
References: <Pine.GSO.4.58.0312231524380.1139@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0312231524380.1139@waterleaf.sonytel.be>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 23 Dec 2003 12:46:09 -0500
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Dec 23, 2003 at 04:12:33PM +0100, Geert Uytterhoeven wrote:
> On the other hand, if I call gtk_init_check() really early (from a
> __uml_setup() routine), UML works fine!
> 
> Any good reason why?  I'm using SKAS mode, since TT gave me even more headaches

UML arranges its physical memory so that it's contiguous starting from the
beginning of the binary out to the end of its VM.  In the middle of that is the
heap.  The brk is rounded up to the nearest 4M or something.  Everything after 
that is usable kernel physical memory, everything before that is reserved and
unusable.

In order to prevent malloc from being used to allocate memory after the kernel
has taken over its memory, malloc et al are wrapped, and if the kernel is
running, the wrapper calls kmalloc instead.  So, if gtk is managing its own
heap, then it may be evading the wrapper, and causing the brk to impinge on
kernel memory.  The fact that everything works if gtk_init_check is called
early enough backs this up.  That will allocate memory and push out the brk
before UML decides where usable memory begins.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
