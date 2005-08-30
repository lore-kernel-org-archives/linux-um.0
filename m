Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAEUY-0007f4-Rq	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Aug 2005 15:22:06 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EAEUW-0001fp-DR
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Aug 2005 15:22:06 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20050830212834.GA10579@ccure.user-mode-linux.org>
References: <200508292007.j7TK72Or029927@ccure.user-mode-linux.org>
	<p73vf1nqhqw.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73vf1nqhqw.fsf@verdi.suse.de>
Subject: [uml-devel] Re: [PATCH 4/9] UML - Mark SMP on UML/x86_64 as broken
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
Date: Tue, 30 Aug 2005 17:28:34 -0400
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

On Tue, Aug 30, 2005 at 10:42:15PM +0200, Andi Kleen wrote:
> The generic one should work too, it's just less efficient.
> So you can probably easily replace them.

Yup, just something that hasn't been done yet.

				Jeff


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
