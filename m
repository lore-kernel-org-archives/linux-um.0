Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1dCYOa-0004Gp-3R
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 May 2017 21:28:12 +0000
Received: from mail-oi0-f52.google.com ([209.85.218.52])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1dCYOY-0003FE-Vq
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 21 May 2017 21:28:12 +0000
Received: by mail-oi0-f52.google.com with SMTP id w10so141496997oif.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 21 May 2017 14:28:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1495059066.27187.2.camel@m3y3r.de>
References: <1495059066.27187.2.camel@m3y3r.de>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 21 May 2017 23:28:05 +0200
Message-ID: <CAFLxGvxC2eRKjottu5rW4vSb-keSOwESw2-MLUUz6HhFVMoXvw@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] um: Add mark_rodata_ro support.
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
To: Thomas Meyer <thomas@m3y3r.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Thomas,

On Thu, May 18, 2017 at 12:11 AM, Thomas Meyer <thomas@m3y3r.de> wrote:
> This is actually a no-op as all read-only should be read-only in the ELF.

What problem does this patch fix? Or what is the purpose?

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

