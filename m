Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1dTPKL-00066P-0L
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 09:13:29 +0000
Received: from mail-oi0-f51.google.com ([209.85.218.51])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1dTPKK-0007om-7x
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 09:13:28 +0000
Received: by mail-oi0-f51.google.com with SMTP id 191so22866497oii.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 07 Jul 2017 02:13:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170706204737.16383-1-thomas@m3y3r.de>
References: <20170706204737.16383-1-thomas@m3y3r.de>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 7 Jul 2017 11:13:22 +0200
Message-ID: <CAFLxGvwMUnRJgYnVq15Ad5W=5hVNO9ygBV0r8eRPG4U-wKU3zg@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] um: Fix gcc 7 sys/sysmacros.h warning
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
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
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Jul 6, 2017 at 10:47 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>

When fixing such a problem, always include die compiler warning.
This has to wait for -rc2.

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

