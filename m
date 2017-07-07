Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1dTPWf-0000Cu-Uc
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 09:26:13 +0000
Received: from mail-oi0-f52.google.com ([209.85.218.52])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1dTPWf-0000fC-5d
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 09:26:13 +0000
Received: by mail-oi0-f52.google.com with SMTP id l130so23122596oib.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 07 Jul 2017 02:26:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170706210404.18253-1-thomas@m3y3r.de>
References: <20170706210404.18253-1-thomas@m3y3r.de>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 7 Jul 2017 11:26:07 +0200
Message-ID: <CAFLxGvy9LdJaC563QntMfErGkzoJVojp70iDKqk-zwj3SCf8kw@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH] um: Fix FP register size for XSTATE/XSAVE
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

On Thu, Jul 6, 2017 at 11:04 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> Hard code max size. Taken from
> https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gdb/common/x86-xstate.h
>
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
>  arch/x86/um/os-Linux/registers.c | 9 ++++-----
>  arch/x86/um/user-offsets.c       | 2 +-
>  2 files changed, 5 insertions(+), 6 deletions(-)

Applied. Thanks a lot for taking care of this nasty issue!

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

