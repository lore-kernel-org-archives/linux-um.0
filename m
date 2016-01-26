Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 26 Jan 2016 22:49:11 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 05/22] hw_random: Fix dependencies for !HAS_IOMEM archs
Message-ID: <20160126144911.GC23264@gondor.apana.org.au>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
 <1453760661-1444-6-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453760661-1444-6-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Matt Mackall <mpm@selenic.com>, Lee Jones <lee.jones@linaro.org>, Kieran Bingham <kieranbingham@gmail.com>, Pankaj Dev <pankaj.dev@st.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Daniel Thompson <daniel.thompson@linaro.org>, linux-crypto@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Jan 25, 2016 at 11:24:04PM +0100, Richard Weinberger wrote:
> Not every arch has io memory.
> So, unbreak the build by fixing the dependencies.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

