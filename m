Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZW2I-0005V3-G0 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 08:09:26 -0800
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EZW2H-0002nI-Rk
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 08:09:26 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Making UML Single Threader
References: <200511061723.32848.rob@landley.net>
	<91A93A3A-FE83-4002-A004-E8FD4AFBAA3C@stanford.edu>
	<20051108154310.GA4131@ccure.user-mode-linux.org>
In-Reply-To: <20051108154310.GA4131@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511081710.28618.blaisorblade@yahoo.it>
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
Date: Tue, 8 Nov 2005 17:10:28 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Can Sar <csar@stanford.edu>

On Tuesday 08 November 2005 16:43, Jeff Dike wrote:
> On Mon, Nov 07, 2005 at 09:13:19PM -0800, Can Sar wrote:
> > Do the other threads (particularly the user thread) ever
> > do something else that would be important?
>
> The user thread doesn't.  The IO thread does, if you wish to do IO.

Since he needs to be _really_ single-threaded (and he may very possibly be 
trying to run something like Valgrind on UML) he may even run UBD without the 
I/O thread.

The code still exists, even if some bugs may have crept in since 2.6.9 (guess 
not, there has been no major rework). Basically, if io_thread_pid == -1, the 
code instead to to asynchronous I/O via this separate thread, does directly 
I/O by itself.

For normal usage, it's a bad idea - UML won't be able to schedule another 
thread until completion of that I/O request (much like green-threads do when 
implemented the simple way). Btw, usage of sigjmp()/longjmp() (between kernel 
threads) is actually green-threads said another way (like Jeff said below).

Btw, even userspace programs have a "stub" in the kernelspace thread.

In that case, through, it's just userspace(): an infinite loop running ptrace 
to intercept and nullify syscalls and segfaults, basically.

> And you can easily dispense with the sigio emulation thread.

> > Furthermore is the actual kernel process multi threaded?
>
> It does what amounts to user-level threads - i.e. there are multiple
> execution contexts in it, implemented with setjmp/longjmp, but that's
> not visible from the outside.

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
