Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from
	<BATV+5a26c1d377b2d96a6988+2898+infradead.org+dwmw2@casper.srs.infradead.org>)
	id 1QnfMs-0000av-Qf for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jul 2011 23:24:22 +0000
Received: from casper.infradead.org ([85.118.1.10])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QnfMs-0005uT-2G
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 Jul 2011 23:24:22 +0000
From: David Woodhouse <dwmw2@infradead.org>
Date: Mon, 01 Aug 2011 00:24:10 +0100
In-Reply-To: <CAFLxGvyewG70ZgU41Kmu_eOYpjZ0TVXYwYq1AfS1sXONAM6G_w@mail.gmail.com>
References: <1312066693.22074.50.camel@i7.infradead.org>
	<1312066923.22074.53.camel@i7.infradead.org>
	<CAFLxGvy0QqoySDFwZpygHeXvQ7hG-B7z5iZq8qx3GUkFX8w2RQ@mail.gmail.com>
	<1312151063.18010.25.camel@i7.infradead.org>
	<20110731224834.GC2203@ZenIV.linux.org.uk>
	<20110731225801.GD2203@ZenIV.linux.org.uk>
	<1312153988.18010.39.camel@i7.infradead.org>
	<CAFLxGvyewG70ZgU41Kmu_eOYpjZ0TVXYwYq1AfS1sXONAM6G_w@mail.gmail.com>
Message-ID: <1312154652.18010.41.camel@i7.infradead.org>
Mime-Version: 1.0
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
Subject: Re: [uml-devel] [PATCH 1/5] um: Use __i386__ in ifdef for vsyscall
 exports, not SUBARCH_i386
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Arnaud Lacombe <lacombar@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>

On Mon, 2011-08-01 at 01:17 +0200, richard -rw- weinberger wrote:
> Isn't UML on ppc broken since ages?

Since before the ppc{,64} -> powerpc merge, by the looks of it.

> As I don't have a ppc box I could never test it... 

Give SSH public key and preferred username...

-- 
dwmw2


------------------------------------------------------------------------------
Got Input?   Slashdot Needs You.
Take our quick survey online.  Come on, we don't ask for help often.
Plus, you'll get a chance to win $100 to spend on ThinkGeek.
http://p.sf.net/sfu/slashdot-survey
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

