Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1dTPEM-0005rd-PL
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 09:07:18 +0000
Received: from mail-oi0-f68.google.com ([209.85.218.68])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1dTPEM-00067I-3N
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Jul 2017 09:07:18 +0000
Received: by mail-oi0-f68.google.com with SMTP id d77so3202111oig.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 07 Jul 2017 02:07:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170705223405.10585-2-thomas@m3y3r.de>
References: <20170705223405.10585-1-thomas@m3y3r.de>
	<20170705223405.10585-2-thomas@m3y3r.de>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 7 Jul 2017 11:07:12 +0200
Message-ID: <CAFLxGvxs4vWGz4-7YNKtmdSdf=VvA+hTgYW9hv83foEUzUTFVQ@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH 3/3] um: Add kerneldoc for userspace_tramp()
 and start_userspace()
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

On Thu, Jul 6, 2017 at 12:34 AM, Thomas Meyer <thomas@m3y3r.de> wrote:
> Also use correct function name spelling (stub_segv_handler) for better grepping
>
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
>  arch/um/os-Linux/skas/process.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)

Series applied.

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

