Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FmBQN-0000Rk-7L for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jun 2006 08:18:55 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FmBQN-0005nm-11 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jun 2006 08:18:55 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FmBQM-0002ev-J9
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jun 2006 08:18:55 -0700
Date: Fri, 2 Jun 2006 11:19:16 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060602151916.GC4708@ccure.user-mode-linux.org>
References: <20060602030825.GA8006@ccure.user-mode-linux.org>
	<1149231262.20582.119.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1149231262.20582.119.camel@localhost.localdomain>
Subject: Re: [uml-devel] non-scalar ktime addition and subtraction broken
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, "Christopher S. Aker" <caker@theshore.net>

On Fri, Jun 02, 2006 at 08:54:22AM +0200, Thomas Gleixner wrote:
> NAK. ktime_t is defined that ist must be normalized the same way as
> timespecs. The nsec part must be >= 0 and < NSEC_PER_SEC. Fix the part
> which is feeding non normalized values.

Aha, that would be me, initializing wall_to_monotonic incorrectly.  Thanks
for the clue.

				Jeff


_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
