Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GTWA3-0001Uq-MP for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Sep 2006 21:09:11 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GTWA2-0008Ix-Af
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Sep 2006 21:09:11 -0700
Date: Fri, 29 Sep 2006 21:08:57 -0700
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20060929210857.fffc1e5d.akpm@osdl.org>
In-Reply-To: <20060930035234.GB10307@ccure.user-mode-linux.org>
References: <200609281814.k8SIEsG8005226@ccure.user-mode-linux.org>
	<65dd6fd50609291518s129786fbt1739c80533d1a36@mail.google.com>
	<20060929153853.9bab3ca7.akpm@osdl.org>
	<20060930035234.GB10307@ccure.user-mode-linux.org>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH 2/2] UML - Don't roll my own random MAC
	generator
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
Cc: dhollis@davehollis.com, Jason@sc8-sf-spam2-b.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, Lunz <lunz@falooley.org>, linux-kernel@vger.kernel.org, Ollie Wild <aaw@google.com>

On Fri, 29 Sep 2006 23:52:34 -0400
Jeff Dike <jdike@addtoit.com> wrote:

> > Jeff, could we pleeeeeze arrange for UML's `make allmodconfig' to work, and
> > to continue to work?
> 
> It works for me - I haven't built -mm2 on x86_64 yet, but I'll check that.

that was mainline.  Perhaps a toolchain thing?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
