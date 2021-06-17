Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltxaQ-00BVFZ-90
 for linux-um@lists.infradead.org; Thu, 17 Jun 2021 19:21:59 +0000
Received: by mail-qt1-x829.google.com with SMTP id o20so5641654qtr.8
 for <linux-um@lists.infradead.org>; Thu, 17 Jun 2021 12:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210305122010.442577-1-johannes@sipsolutions.net>
 <20210305131934.b1cae3585b98.I2a08cbe698fc23f1731e33e4f2582475290b90dc@changeid>
In-Reply-To: <20210305131934.b1cae3585b98.I2a08cbe698fc23f1731e33e4f2582475290b90dc@changeid>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Thu, 17 Jun 2021 21:21:45 +0200
Message-ID: <CAFLxGvy8aZq9OO+--bz7vxFa3s+NgaPqTFQO+DLBFivS+Fai-Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] um: export signals_enabled directly
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
Cc: linux-um <linux-um@lists.infradead.org>, Johannes Berg <johannes.berg@intel.com>

On Fri, Mar 5, 2021 at 1:20 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> +#define UML_SETJMP(buf) ({                             \
> +       int n, enable;                                  \
> +       enable = *(volatile int *)&signals_enabled;     \

Isn't this a case for READ_ONCE()?

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

