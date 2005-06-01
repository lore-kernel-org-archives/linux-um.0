Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ddajs-00064c-30	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Jun 2005 14:27:00 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Ddajp-0006Tv-OP	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 01 Jun 2005 14:26:59 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Problem with /dev/random and rngd daemon
Message-ID: <20050601202936.GA14652@ccure.user-mode-linux.org>
References: <s29d94d2.052@ORANGE.OUS.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s29d94d2.052@ORANGE.OUS.EDU>
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
Date: Wed, 1 Jun 2005 16:29:36 -0400
To: Anthony Brock <Anthony_Brock@ous.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Jun 01, 2005 at 10:57:59AM -0700, Anthony Brock wrote:
> I'm wondering if the first host to launch is exhausting the entropy
> pool and the second host is attempting to read from an empty pool. 

The strace would seem to bear this out:

> open("/dev/hwrng", O_RDONLY)            = 3
> rt_sigaction(SIGALRM, {0x400267a0, [], 0}, NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [ALRM], NULL, 8) = 0
> alarm(10)                               = 0
> read(3, 0xbfb50380, 4)                  = ? ERESTARTSYS (To be restarted)
> --- SIGALRM (Alarm clock) @ 0 (0) ---
> sigreturn()                             = ? (mask now [RTMIN])
> exit_group(1)                           = ?

This looks to me like "read from hwrng, but give up after 10 seconds
if nothing happens".

> If this is the case, then I have no idea how you could resolve this
> with multiple UML instances per host. 

Can you read /dev/random on the host directly during this time?  If
not, and you are out of entropy, I would say you need to find a source
of more of it.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
