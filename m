Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTsKo-0008RK-EE
 for linux-um@lists.infradead.org; Wed, 29 Apr 2020 19:25:31 +0000
Received: by mail-qk1-x744.google.com with SMTP id t3so3285744qkg.1
 for <linux-um@lists.infradead.org>; Wed, 29 Apr 2020 12:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200425081842.4365-1-ignat@cloudflare.com>
In-Reply-To: <20200425081842.4365-1-ignat@cloudflare.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 29 Apr 2020 21:25:18 +0200
Message-ID: <CAFLxGvyZJxoTtHSmAmZVR36GT6fRx_XhOrY=mmpsjZvpRR9s9A@mail.gmail.com>
Subject: Re: [PATCH] um: Fix typo in vector driver transport option definition
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: Trivial patch monkey <trivial@kernel.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Sat, Apr 25, 2020 at 10:19 AM Ignat Korchagin <ignat@cloudflare.com> wrote:
>
> No big problem as "raw" and "gre" have the same length, but could go wrong if
> they don't in the future.
>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
> ---
>  arch/um/drivers/vector_user.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/um/drivers/vector_user.h b/arch/um/drivers/vector_user.h
> index 91f35b266aba..d29d5fdd98fa 100644
> --- a/arch/um/drivers/vector_user.h
> +++ b/arch/um/drivers/vector_user.h
> @@ -17,7 +17,7 @@
>  #define TRANS_TAP_LEN strlen(TRANS_TAP)
>
>  #define TRANS_GRE "gre"
> -#define TRANS_GRE_LEN strlen(TRANS_RAW)
> +#define TRANS_GRE_LEN strlen(TRANS_GRE)
>
>  #define TRANS_L2TPV3 "l2tpv3"
>  #define TRANS_L2TPV3_LEN strlen(TRANS_L2TPV3)
> --

Applied, thanks!

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

