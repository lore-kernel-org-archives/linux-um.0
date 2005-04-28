Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DRI4k-0001x8-TY	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 16:05:42 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DRI4j-000346-Dj	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Apr 2005 16:05:42 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Kernel panic with 2.6.11.6
Message-ID: <20050428212950.GA26596@ccure.user-mode-linux.org>
References: <20050427133324.7alyoigzdn74osg8@www.scgiservices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427133324.7alyoigzdn74osg8@www.scgiservices.com>
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
Date: Thu, 28 Apr 2005 17:29:50 -0400
To: Anthony Brock <brocka@sterlingcgi.com>
Cc: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Apr 27, 2005 at 01:33:24PM -0700, Anthony Brock wrote:
> Kernel panic - not syncing: Kernel mode fault at addr 0x19, ip 0x402eb2d2
> 
> This only happens when I reconnect to the guest console by attaching to the
> associated "screen" session. Also, it is erradic at best and happens about once
> out of every 15-20 times I reconnect to the screen. Fortunately, the apparent
> trigger (connecting to the console) ensures that I'm aware of the crash and
> able to immediately restart the instance.
> 
> Any ideas on how to troubleshoot this? Is it a known issue that I've somehow
> missed on the list? Thanks!

My usual request - can you get a stack trace from it?

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
