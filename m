Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eygli-0002Ok-6O for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 18:40:22 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Eyglh-0001Dz-QF
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 18:40:22 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH 9/11] UML - Implement soft interrupts
Message-ID: <20060117033227.GB17171@ccure.user-mode-linux.org>
References: <200601152139.k0FLdp1G027747@ccure.user-mode-linux.org>
	<200601170124.32076.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601170124.32076.blaisorblade@yahoo.it>
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
Date: Mon, 16 Jan 2006 22:32:27 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org, linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 01:24:31AM +0100, Blaisorblade wrote:
> ~25 %? Good! Which is delay vs. host?

Delay vs a UML without the patch.

> A curiosity - did you look at the similar code in Ingo Molnar's VCPU patch? 
> I never found the time to split it out and compare differencies. I just 
> remember it using assembler inserts for (maybe atomic) bitmask manipulations.

It was separate from VCPU, but I never really looked at it since I already
had this.  Some day I will to see if there are any trick in it that I should
use.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
