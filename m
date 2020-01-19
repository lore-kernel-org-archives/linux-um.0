Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1itI6h-0007Bp-MC
 for linux-um@lists.infradead.org; Sun, 19 Jan 2020 21:27:45 +0000
Received: by mail-wr1-x444.google.com with SMTP id d16so27581117wre.10
 for <linux-um@lists.infradead.org>; Sun, 19 Jan 2020 13:27:43 -0800 (PST)
MIME-Version: 1.0
References: <20190524220843.27623-1-johannes@sipsolutions.net>
In-Reply-To: <20190524220843.27623-1-johannes@sipsolutions.net>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 19 Jan 2020 22:27:31 +0100
Message-ID: <CAFLxGvxFfa8QNh3_6-EcVFCvkV4Huqf2=bRMiCQdtU+F7Ocq1A@mail.gmail.com>
Subject: Re: [PATCH v2] arch: um: add an option to make serial driver non-raw
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Johannes Berg <johannes.berg@intel.com>, j@w1.fi, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Sat, May 25, 2019 at 12:08 AM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> In some cases, for example when the program(s) running inside UML
> isn't/aren't interactive (like the hwsim tests for wpa_supplicant)
> there's really no value in having the serial lines configured to
> be raw as they are now by default. Setting them to non-raw lets
> one abort the whole UML with Ctrl-C, which is really the right
> thing to do in these cases, basically the whole UML instance is
> more like a single (testing) program.
>
> Add a "ssl-non-raw" option to UML to support such a mode.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  arch/um/drivers/chan_user.h | 2 +-
>  arch/um/drivers/ssl.c       | 8 ++++++++

Applied. Thanks,
//richard

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

