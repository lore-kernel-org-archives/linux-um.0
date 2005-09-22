Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EIY7O-0003Wx-3l	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Sep 2005 13:56:34 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EIY7E-00087r-ID
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Sep 2005 13:56:34 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 06/10] uml: run mconsole "sysrq" in process
	context
References: <200509211923.21861.blaisorblade@yahoo.it>
	<200509222120.20922.blaisorblade@yahoo.it>
	<20050922203743.GA11648@ccure.user-mode-linux.org>
In-Reply-To: <20050922203743.GA11648@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509222248.21339.blaisorblade@yahoo.it>
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
Date: Thu, 22 Sep 2005 22:48:21 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Thursday 22 September 2005 22:37, Jeff Dike wrote:
> On Thu, Sep 22, 2005 at 09:20:20PM +0200, Blaisorblade wrote:
> > sysrq t is broken (and stays),

> There's a fix on the way for that.
Already found? Nice.
> This has nothing to do with interrupt 
> context anyway.

> > but additionally there are some warnings from
> > some commands (enable sleep inside spinlock checking and spinlock
> > debugging), which go to the down_read inside handle_page_fault IIRC. So
> > try to run in process context.

> Which ones?  They should be fixed.
Ok, will drop this patch and retry again to look at the messages.
> It is fairly fundamental to sysrq that it work from interrupt context.  You
> may be diagnosing a system which can't context switch any more.

Ok, I felt a bit uncertain about this, but didn't realize this very problem.

> This patch should be dropped, and the real problems fixed.
Ok, that's nice for me. I'll look into this. Possibly, the

if (in_atomic()) don't take semaphore in handle_page_fault was the right fix 
for this. I'll have a look soon.
> 				Jeff

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
