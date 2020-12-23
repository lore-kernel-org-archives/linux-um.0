Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ks1F2-0005Io-FI
 for linux-um@lists.infradead.org; Wed, 23 Dec 2020 10:19:37 +0000
Received: by mail-qk1-x72b.google.com with SMTP id b64so14445707qkc.12
 for <linux-um@lists.infradead.org>; Wed, 23 Dec 2020 02:19:36 -0800 (PST)
MIME-Version: 1.0
References: <20201221022434.21725-1-thehajime@gmail.com>
 <5f11-5fe1dd00-6d-1cae2c20@60061556>
In-Reply-To: <5f11-5fe1dd00-6d-1cae2c20@60061556>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 23 Dec 2020 11:19:23 +0100
Message-ID: <CAFLxGvynAbtSLJweY6-oJ1egu1aSOAMPewsaz0VCrUMWazBZ4A@mail.gmail.com>
Subject: Re: [PATCH] um: ubd: fix command line handling of ubd
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
To: Christopher Obbard <chris.obbard@collabora.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Hajime Tazaki <thehajime@gmail.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Tue, Dec 22, 2020 at 12:49 PM Christopher Obbard
<chris.obbard@collabora.com> wrote:
>
> Hi Hajime,
>
> Doh! Thanks for sorting out this regression!
>
> On Monday, 21 December, 2020 02:24 GMT, Hajime Tazaki <thehajime@gmail.com> wrote:
> > This commit fixes a regression to handle command line parameters of ubd.
> > With a simple line "./linux ubd0="./disk-ext4.img", it fails at
> > ubd_setup_common().  The commit adds additional checks to the variables
> > in order to properly parse the paremeters which previously worked.
> >
> > Fixes: ef3ba87cb7c9 ("um: ubd: Set device serial attribute from
> > cmdline")
> > Cc: Christopher Obbard <chris.obbard@collabora.com>
> > Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
>
> Acked-by: Christopher Obbard <chris.obbard@collabora.com>

Applied, thx!

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

