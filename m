Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVemh-0001aB-Er for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 19:50:27 -0700
Received: from rtr.ca ([76.10.145.34] helo=mail.rtr.ca)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IVemh-0002qX-5t
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 19:50:27 -0700
Message-ID: <46E8A572.7050209@rtr.ca>
Date: Wed, 12 Sep 2007 22:50:26 -0400
From: Mark Lord <lkml@rtr.ca>
MIME-Version: 1.0
References: <46E81AC6.3000306@googlemail.com>
In-Reply-To: <46E81AC6.3000306@googlemail.com>
Subject: Re: [uml-devel] [1/4] 2.6.23-rc6: known regressions
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
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Jakub Jelinek <jakub@redhat.com>, Len Brown <len.brown@intel.com>, "Adrian Bunk \"\"" <bunk@kernel.org>, "Antonino A. Daplas" <adaplas@gmail.com>, Jeff Chua <jeff.chua.linux@gmail.com>, Stefan Becker <Stefan.Becker@nokia.com>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>, Markus <lists4me@web.de>, Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, linux-alpha@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Dave Jones <davej@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jeff Dike <jdike@linux.intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

Michal Piotrowski wrote:
> Hi all,
> 
> Here is a list of some known regressions in 2.6.23-rc6.
...

Missing from the list:

USB "autosuspend" feature (new in 2.6.23) breaks *lots* of devices.
Many have since been blacklisted in one-at-a-time discovery patches,
but that's really just the tip of the iceberg.

This "feature" breaks a TON of user-visible things,
mostly USB storage devices (USB drives/pens, digicams, etc..).

The functionality is broken for just too much stuff,
and needs to either be reverted or defaulted to "off" rather than "on".

Cheers

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
