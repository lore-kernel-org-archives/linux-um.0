Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAWxk-0006Pk-Oe	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Aug 2005 11:05:28 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EAWxi-0004Hy-1Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 31 Aug 2005 11:05:28 -0700
Subject: Re: [uml-devel] Re: [uml-user] Hardware Requirements -Some
	Questions about UML by a Newbie
From: Antoine Martin <antoine@nagafix.co.uk>
In-Reply-To: <20050831154111.GA6600@ccure.user-mode-linux.org>
References: <396648218@web.de>
	 <20050811232256.GF11873@ccure.user-mode-linux.org>
	 <200508121814.43201.blaisorblade@yahoo.it>
	 <1124960678.28722.29.camel@localhost.localdomain>
	 <20050828140355.GF3192@ccure.user-mode-linux.org>
	 <1125448055.3801.6.camel@localhost.localdomain>
	 <1125494490.21641.15.camel@localhost.localdomain>
	 <20050831154111.GA6600@ccure.user-mode-linux.org>
Content-Type: text/plain
Message-Id: <1125511515.3803.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Wed, 31 Aug 2005 19:05:14 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, 2005-08-31 at 11:41 -0400, Jeff Dike wrote:
> On Wed, Aug 31, 2005 at 02:21:29PM +0100, Antoine Martin wrote:
> > And I've had the case (now 4 times and I ended up loosing some work -
> > but that's my own fault!) where other processes on the same box get
> > affected (they segfault). The guest is doing nothing (idle - no cron)
> > I stopped the guest and now the problems have gone away...
> > Something is corrupting my processes.
> 
> What's the host, exactly?
It's an Acer 1500 laptop with amd64-3000 and 1.2GB ram.
It's been running fine since I stopped the guest, but then again that
does not mean that was the problem - it could just be putting more
pressure on I/O or ram consumption and triggering something else. But my
gut feeling is that it is doing something..
I'm getting back my amd64 test rig (not a laptop) in the next few days
so I'll be able to run some proper tests then.

Antoine



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
