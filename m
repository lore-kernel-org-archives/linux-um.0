Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1covBJ-0003aI-Dm
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 16:56:49 +0000
Received: from mail-ot0-f170.google.com ([74.125.82.170])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1covBH-0007zN-Is
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Mar 2017 16:56:49 +0000
Received: by mail-ot0-f170.google.com with SMTP id i1so97977248ota.3
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 17 Mar 2017 09:56:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0fbc8e03-783e-eed6-8e2e-100f8da6d36e@kot-begemot.co.uk>
References: <0fbc8e03-783e-eed6-8e2e-100f8da6d36e@kot-begemot.co.uk>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 17 Mar 2017 17:56:41 +0100
Message-ID: <CAFLxGvx0zpqgbp49DxQ_V8bxLGRKw6ziYstqK7hzcqUUvXuajQ@mail.gmail.com>
Subject: Re: [uml-devel] UML regression with latest RC 4.11-rc2
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

Anton,

On Fri, Mar 17, 2017 at 8:51 AM, Anton Ivanov
<anton.ivanov@kot-begemot.co.uk> wrote:
> Hi list, hi Richard
>
> There is an extra check in mm/mmap.c which now throws a WARN on every
> page in making UML unusable with the latest 4.11-rc2

Which WARN? Can you find the offending commit?

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

