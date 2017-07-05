Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1dSron-0008St-HW
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Jul 2017 21:26:41 +0000
Received: from mail-oi0-f68.google.com ([209.85.218.68])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1dSrom-0004O1-Oi
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Jul 2017 21:26:41 +0000
Received: by mail-oi0-f68.google.com with SMTP id d77so198443oig.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 05 Jul 2017 14:26:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1494774193.13299.4.camel@m3y3r.de>
References: <1494774193.13299.4.camel@m3y3r.de>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 5 Jul 2017 23:26:34 +0200
Message-ID: <CAFLxGvxhOB_F1p0vjvMsBDc6RODq3z9yp7_hs+=NjHq+J7WBvQ@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH 1/3] um: stub-data.h: remove superfluous
 include
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

Thomas,

On Sun, May 14, 2017 at 5:03 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
>  arch/um/include/shared/skas/stub-data.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/um/include/shared/skas/stub-data.h
> b/arch/um/include/shared/skas/stub-data.h
> index a9deece..13f404e 100644
> --- a/arch/um/include/shared/skas/stub-data.h
> +++ b/arch/um/include/shared/skas/stub-data.h
> @@ -8,8 +8,6 @@
>  #ifndef __STUB_DATA_H
>  #define __STUB_DATA_H
>
> -#include <time.h>
> -
>  struct stub_data {
>   unsigned long offset;
>   int fd;
>

All three patches are malformed and don't apply. :-(

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

