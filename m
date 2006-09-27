Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GSfAP-0001HI-NW for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Sep 2006 12:34:01 -0700
Received: from smtp.reflexsecurity.com ([72.54.64.74]
	helo=crown.reflexsecurity.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GSfAN-0003Hl-OE
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 27 Sep 2006 12:34:01 -0700
Date: Wed, 27 Sep 2006 15:33:43 -0400
From: Jason Lunz <lunz@falooley.org>
Message-ID: <20060927193135.GA13322@knob.reflex>
References: <200609271757.k8RHvmgj005727@ccure.user-mode-linux.org>
In-Reply-To: <200609271757.k8RHvmgj005727@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: Re: [uml-devel] [PATCH 1/5] UML - Assign random MACs to interfaces
	if necessary
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, Sep 27, 2006 at 01:57:47PM -0400, Jeff Dike wrote:
> Now, if there is no MAC from the command line, one is generated.  We
> use the microseconds from gettimeofday (20 bits), plus the low 12
> bits of the pid to seed the random number generator.  random() is
> called twice, with 16 bits of each result used.  I didn't want to
> have to try to fill in 32 bits optimally given an arbitrary
> RAND_MAX, so I just assume that it is greater than 65536 and use 16
> bits of each random() return.

Why not use random_ether_addr() like dummy, tun, ifb and others?

Jason

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
