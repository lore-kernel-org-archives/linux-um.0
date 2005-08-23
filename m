Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8g8Z-0003qE-OI	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 08:28:59 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1E8g8W-0006vZ-7x
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 08:28:59 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20050812182145.DF52E24E7F3@zion.home.lan>
	<43006AA6.1040405@yahoo.com.au> <20050815111548.F19811@flint.arm.linux.org.uk>
In-Reply-To: <20050815111548.F19811@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508231045.50500.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [patch 18/39] remap_file_pages protection support:
	add VM_FAULT_SIGSEGV
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
Date: Tue, 23 Aug 2005 10:45:46 +0200
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, mingo@elte.hu

On Monday 15 August 2005 12:15, Russell King wrote:
> On Mon, Aug 15, 2005 at 08:12:54PM +1000, Nick Piggin wrote:
> > Well there is now, and that is we are now using a bit in the 2nd
> > byte as flags. So I had to do away with -ve numbers there entirely.

> > You could achieve a similar thing by using another bit in that byte
> > #define VM_FAULT_FAILED 0x20
> > and make that bit present in VM_FAULT_OOM and VM_FAULT_SIGBUS, then
> > do an unlikely test for that bit in your handler and branch away to
> > the slow path.
 
> That'll do as well, thanks.
Note that what Nick said is about mainline kernels, not only my brave patch.

Currently Linus fixed up ARM26 by disabling the optimization: see git commit 
6e346228c76506e07e297744a28464022c6806ad.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
