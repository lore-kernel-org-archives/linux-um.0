Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <richard.weinberger@gmail.com>) id 1fPOSV-0003AY-H3
 for user-mode-linux-devel@lists.sourceforge.net;
 Sun, 03 Jun 2018 08:33:51 +0000
Received: from mail-wr0-f193.google.com ([209.85.128.193])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fPOST-00Aq2H-E2 for user-mode-linux-devel@lists.sourceforge.net;
 Sun, 03 Jun 2018 08:33:51 +0000
Received: by mail-wr0-f193.google.com with SMTP id o12-v6so9003967wrm.12
 for <user-mode-linux-devel@lists.sourceforge.net>;
 Sun, 03 Jun 2018 01:33:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAK7LNASfiRcPVb0Bs_KWuAL3mtzdQfWwATVLkit8MkXeWtgrRQ@mail.gmail.com>
References: <1526351878-24961-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNASfiRcPVb0Bs_KWuAL3mtzdQfWwATVLkit8MkXeWtgrRQ@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 3 Jun 2018 10:33:42 +0200
Message-ID: <CAFLxGvwmm_tXv0mMoKVSRRC1_hvT7rbm7hVBFwD6fBAQAADrUQ@mail.gmail.com>
Subject: Re: [uml-devel] [PATCH RESEND] um: vdso: remove unused vdso-syms.lds
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
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Sun, Jun 3, 2018 at 4:37 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi UML maintainers,
>
> 2018-05-15 11:37 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
>> This file contains symbol values, and was originally linked into
>> vmlinux, but I have no idea what it was actually used for.
>>
>> Since commit 827880ec260b ("x86/um: thin archives build fix"), it is
>> not even linked.  Now it is completely orphan, and no problem has
>> been reported.  It is a proof that this file was not needed in the
>> first place.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Acked-by: Ingo Molnar <mingo@kernel.org>
>> ---
>
>
> Could you take a look at this patch, please?

Acked-by: Richard Weinberger <richard@nod.at>

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

