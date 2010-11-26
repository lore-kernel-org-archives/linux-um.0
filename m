Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <renzo@cs.unibo.it>) id 1PM2QR-0006tf-RL
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Nov 2010 17:49:35 +0000
Received: from leb.cs.unibo.it ([130.136.1.102])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PM2QP-0000Lx-Ex
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Nov 2010 17:49:35 +0000
Date: Fri, 26 Nov 2010 18:49:26 +0100
From: Renzo Davoli <renzo@cs.unibo.it>
Message-ID: <20101126174926.GB8087@cs.unibo.it>
References: <20101125173649.GA20609@ping.uio.no>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20101125173649.GA20609@ping.uio.no>
Subject: Re: [uml-devel] [PATCH] uml_switch: configurable network delay
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Morten Hustveit <mortehu@ping.uio.no>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Nov 25, 2010 at 06:36:49PM +0100, Morten Hustveit wrote:
> Add the "-delay" option to configure network delay in milliseconds
If you use vde instead of uml_switch, vde provides wirefilter
which implements packet delay as well as several other networking testing features:

packet loss
packet dup
bandwidth limit
interface speed
channel capacity
channel noise
fifoness errors

	renzo

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

