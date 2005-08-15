Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E4c18-0005Em-Dh	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Aug 2005 03:16:30 -0700
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1E4c0d-0005hg-TC
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Aug 2005 03:16:30 -0700
From: Russell King <rmk+lkml@arm.linux.org.uk>
Message-ID: <20050815111548.F19811@flint.arm.linux.org.uk>
References: <20050812182145.DF52E24E7F3@zion.home.lan>
	<20050815104022.D19811@flint.arm.linux.org.uk> <43006AA6.1040405@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43006AA6.1040405@yahoo.com.au>;
	from nickpiggin@yahoo.com.au on Mon, Aug 15, 2005 at 08:12:54PM +1000
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
Date: Mon, 15 Aug 2005 11:15:48 +0100
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: blaisorblade@yahoo.it, akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, mingo@elte.hu

On Mon, Aug 15, 2005 at 08:12:54PM +1000, Nick Piggin wrote:
> Well there is now, and that is we are now using a bit in the 2nd
> byte as flags. So I had to do away with -ve numbers there entirely.
> 
> You could achieve a similar thing by using another bit in that byte
> #define VM_FAULT_FAILED 0x20
> and make that bit present in VM_FAULT_OOM and VM_FAULT_SIGBUS, then
> do an unlikely test for that bit in your handler and branch away to
> the slow path.

That'll do as well, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
