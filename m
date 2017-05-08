Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1d7npw-0003MH-9c
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 May 2017 18:56:48 +0000
Received: from mail-oi0-f44.google.com ([209.85.218.44])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1d7nps-0007AE-K2
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 May 2017 18:56:48 +0000
Received: by mail-oi0-f44.google.com with SMTP id w10so61806903oif.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 08 May 2017 11:56:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <097f2658-86f0-b138-c29a-a60101549c20@kot-begemot.co.uk>
References: <1494187593.2984.2.camel@m3y3r.de>
	<097f2658-86f0-b138-c29a-a60101549c20@kot-begemot.co.uk>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 8 May 2017 20:56:38 +0200
Message-ID: <CAFLxGvwbqEqom53NGgq7-jHYfYKxZZYg13SeJAAzMZSqL8y_wg@mail.gmail.com>
Subject: Re: [uml-devel] warning at vma_merge
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Anton, Thomas,

On Sun, May 7, 2017 at 10:27 PM, Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
> Have a look at the list archive, this was covered a couple of weeks ago.
>
> I believe Richard is working on a fix.

Yep, this reminds me that I have to ping mm folks about this.
Please see: http://lkml.iu.edu/hypermail/linux/kernel/1703.2/02256.html

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

