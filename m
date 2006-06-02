Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fm3ms-0006c7-E3 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Jun 2006 00:09:38 -0700
Received: from www.osadl.org ([213.239.205.134] helo=mail.tglx.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fm3XH-0006T0-2l
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Jun 2006 23:53:31 -0700
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
In-Reply-To: <20060602030825.GA8006@ccure.user-mode-linux.org>
References: <20060602030825.GA8006@ccure.user-mode-linux.org>
Content-Type: text/plain
Message-Id: <1149231262.20582.119.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: non-scalar ktime addition and subtraction broken
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
Date: Fri, 02 Jun 2006 08:54:22 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, "Christopher S. Aker" <caker@theshore.net>, user-mode-linux-devel@lists.sourceforge.net

On Thu, 2006-06-01 at 23:08 -0400, Jeff Dike wrote:
> The use of 64-bit additions and subtractions on something which is
> nominally a struct containing 32-bit second and nanosecond field is
> broken when a negative time is involved.  When the structure is
> treated as a 64-bit integer, the increment of the upper 32 bits that's
> part of two's-complement subtraction is lost.  This leaves the end
> result off by one second.
> 
> This manifested itself with sleeps inside UML lasting about 1 second
> shorter than expected.
> 
> The patch below is more a problem statement than a real fix.  People
> thought about performance, and I don't know what this does to that
> work.
> 
> I'm not sure why the hrtimer.c part is needed - I had done that before
> tracking down the ktime_add problem.  I see short sleeps without it,
> so it is needed somehow.
> 
> The ktime_sub piece was done for completeness - UML compiles and boots
> with no apparent ill effects, but it's otherwise untested.
> 
> As an aside, I fail to see how it can be correct for ktime_sub to add
> NSEC_PER_SEC to something without compensating somewhere else for it.
> 
> Andrew - please don't drop this into -mm without an OK from Thomas or
> someone else who's familiar with this code :-)

NAK. ktime_t is defined that ist must be normalized the same way as
timespecs. The nsec part must be >= 0 and < NSEC_PER_SEC. Fix the part
which is feeding non normalized values.

	tglx






-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
