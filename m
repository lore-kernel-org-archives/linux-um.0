Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GTVsE-0008OF-Ld for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Sep 2006 20:50:46 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GTVsC-0004XU-8u
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Sep 2006 20:50:46 -0700
Date: Fri, 29 Sep 2006 23:49:20 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060930034920.GA10307@ccure.user-mode-linux.org>
References: <200609281814.k8SIEsG8005226@ccure.user-mode-linux.org>
	<65dd6fd50609291518s129786fbt1739c80533d1a36@mail.google.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <65dd6fd50609291518s129786fbt1739c80533d1a36@mail.google.com>
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
To: Ollie Wild <aaw@google.com>
Cc: akpm@osdl.org, dhollis@davehollis.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Jason Lunz <lunz@falooley.org>

On Fri, Sep 29, 2006 at 03:18:52PM -0700, Ollie Wild wrote:
> This patch as provided breaks my build due to a missing semicolon.
> 
> Patch attached.

Thanks - I fixed that, but forgot to refresh the patch.

				Jeff

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
