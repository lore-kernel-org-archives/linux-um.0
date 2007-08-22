Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Wed, 22 Aug 2007 12:25:08 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070822162508.GA11022@c2.user-mode-linux.org>
References: <1187561903.4200.138.camel@localhost>
	<200708211909.23027.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200708211909.23027.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 1/5] um/... convert #include "linux/..." to
	#include	<linux/...>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Miklos Szeredi <mszeredi@suse.cz>, Maxim Krasnyansky <maxk@qualcomm.com>, Jeff Dike <jdike@karaya.com>, kernel-janitors@vger.kernel.org, Jason Lunz <lunz@falooley.org>, Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>, vtun@office.satix.net, Jens Axboe <jens.axboe@oracle.com>, Stephen Hemminger <shemminger@linux-foundation.org>, Nick Piggin <npiggin@suse.de>, Davide Brini <davide.brini@unibo.it>, Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, Alexey Dobriyan <adobriyan@gmail.com>, Zachary Amsden <zach@vmware.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Rusty Russell <rusty@rustcorp.com.au>, Eduard-Gabriel Munteanu <maxdamage@aladin.ro>, Chris Wright <chrisw@sous-sol.org>, user-mode-linux-user@lists.sourceforge.net, Jeff Dike <jdike@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@mcmartin.ca>, Ollie Wild <aaw@google.com>, Joe Perches <joe@perches.com>, "David S. Miller" <davem@davemloft.net>

On Tue, Aug 21, 2007 at 07:09:17PM +0200, Blaisorblade wrote:
> Wait, this patch may or may not be sane (Jeff will tell more I guess).

It's sane.

> Since 
> we use two different sets of headers (the host ones from userspace and the 
> guest ones from Linux), this peculiar style has been used till now to make 
> clear the difference (#include <file> is used for host headers) - at least 
> that's what I think (I've never asked to Jeff, but I silently deduced this 
> and followed this practice).

Yeah, and it makes some sense to extend the practice to the kernel
side, where <> is used for generic headers and "" for UML-specific
ones.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
