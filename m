Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gHzHz-0004JW-Hk
 for linux-um@lists.infradead.org; Wed, 31 Oct 2018 22:48:41 +0000
Received: by mail-lj1-x243.google.com with SMTP id c4-v6so16376873lja.4
 for <linux-um@lists.infradead.org>; Wed, 31 Oct 2018 15:48:27 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com.
 [209.85.208.171])
 by smtp.gmail.com with ESMTPSA id c22sm4278704lfd.88.2018.10.31.15.48.24
 for <linux-um@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Oct 2018 15:48:24 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id f3-v6so16371741ljk.9
 for <linux-um@lists.infradead.org>; Wed, 31 Oct 2018 15:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <1829585.6m1bt7BjAO@blindfold>
In-Reply-To: <1829585.6m1bt7BjAO@blindfold>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 31 Oct 2018 15:48:07 -0700
Message-ID: <CAHk-=wjw8qra+SYDDjvSnZ=APsn9aFG9WiJGSLD94A0Q_+BZWg@mail.gmail.com>
Subject: Re: [GIT PULL] UML changes for 4.20-rc1
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
To: richard@nod.at
Cc: linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Oct 31, 2018 at 2:22 PM Richard Weinberger <richard@nod.at> wrote:
>
> - Removal of old and dead code
> - A bug fix for our tty driver
> - Other minor cleanups across the code base

Pulled. I may not like recent rebases, but I do like this:

>  11 files changed, 19 insertions(+), 456 deletions(-)
>  delete mode 100644 arch/um/include/shared/aio.h
>  delete mode 100644 arch/um/os-Linux/aio.c

Thanks,

                Linus

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

