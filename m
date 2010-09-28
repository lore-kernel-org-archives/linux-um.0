Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <viro@ftp.linux.org.uk>) id 1P0i54-0003EE-4U
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Sep 2010 21:51:22 +0000
Received: from zeniv.linux.org.uk ([195.92.253.2])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P0i52-0002eS-OL
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Sep 2010 21:51:22 +0000
Date: Tue, 28 Sep 2010 22:51:08 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20100928215108.GH19804@ZenIV.linux.org.uk>
References: <AANLkTim85sH_2o=xCiDuoQrHq_7ZL96Y91xQMGxUP5Fy@mail.gmail.com>
	<20100928211106.GE19804@ZenIV.linux.org.uk>
	<20100928212417.GF19804@ZenIV.linux.org.uk>
	<20100928.144215.246551852.davem@davemloft.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100928.144215.246551852.davem@davemloft.net>
Subject: Re: [uml-devel] {painfully BISECTED} Please revert f25c80a4b2:
 arch/um/drivers: remove duplicate structure field initialization
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
To: David Miller <davem@davemloft.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, julia@diku.dk, akpm@linux-foundation.org, torvalds@linux-foundation.org, shemminger@vyatta.com

On Tue, Sep 28, 2010 at 02:42:15PM -0700, David Miller wrote:
> From: Al Viro <viro@ZenIV.linux.org.uk>
> Date: Tue, 28 Sep 2010 22:24:17 +0100
> 
> > Who maintains these drivers?
> 
> Your guess is as good as mine, which probably means there is no
> active maintainer right now.

Oh, joy...  I'm regulary using uml, with some of these drivers used
from time to time, but I've no fscking clue on e.g. VDE - even on
the "what the hell it is" level ;-/

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

