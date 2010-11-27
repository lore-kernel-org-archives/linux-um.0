Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mortehu@ping.uio.no>) id 1PMJWY-000167-Sz
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Nov 2010 12:05:02 +0000
Received: from ping.uio.no ([193.157.115.196])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PMJWX-0002Id-I4
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Nov 2010 12:05:02 +0000
Date: Sat, 27 Nov 2010 13:04:50 +0100
From: Morten Hustveit <mortehu@ping.uio.no>
Message-ID: <20101127120450.GA4789@ping.uio.no>
References: <20101125173649.GA20609@ping.uio.no>
	<20101126174926.GB8087@cs.unibo.it>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20101126174926.GB8087@cs.unibo.it>
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
To: user-mode-linux-devel@lists.sourceforge.net

On Thu, Nov 25, 2010 at 06:36:49PM +0100, Morten Hustveit wrote:
> > Add the "-delay" option to configure network delay in milliseconds

On Fri, Nov 26, 2010 at 06:49:26PM +0100, Renzo Davoli wrote:
> If you use vde instead of uml_switch, vde provides wirefilter
> which implements packet delay as well as several other networking testing features:

That looks nice, but I couldn't understand how to use it.  It seemed to
me that to do something like

  uml_switch -delay 100

with vde, you would need to write several long command lines and perhaps
a configuration file.  I understand this is not a problem for most
people, but I would like to have a simple way of doing things as well.
I'm hoping to contribute other similarly simple testing features to
uml_switch, but first I need to know whether such changes are welcome.

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

