Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gHzYx-0002K8-HO
 for linux-um@lists.infradead.org; Wed, 31 Oct 2018 23:06:13 +0000
Received: by mail-lj1-x244.google.com with SMTP id t22-v6so16399224lji.7
 for <linux-um@lists.infradead.org>; Wed, 31 Oct 2018 16:06:00 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com.
 [209.85.208.171])
 by smtp.gmail.com with ESMTPSA id z8-v6sm650312lji.51.2018.10.31.16.05.57
 for <linux-um@lists.infradead.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Oct 2018 16:05:58 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id u6-v6so69957ljd.1
 for <linux-um@lists.infradead.org>; Wed, 31 Oct 2018 16:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <1829585.6m1bt7BjAO@blindfold>
 <CAHk-=wjw8qra+SYDDjvSnZ=APsn9aFG9WiJGSLD94A0Q_+BZWg@mail.gmail.com>
 <4324649.OiLOZ4spUA@blindfold>
In-Reply-To: <4324649.OiLOZ4spUA@blindfold>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 31 Oct 2018 16:05:41 -0700
Message-ID: <CAHk-=wgWy-GwTMQLE1t__fA6Lse8V0J5h4Pkd6mHY7DnZYqFWQ@mail.gmail.com>
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

On Wed, Oct 31, 2018 at 4:01 PM Richard Weinberger <richard@nod.at> wrote:
>
> Okay, so my rebase was in vain, I thought you don't like pull requests
> with such an old base.

Some *really* old bases can cause problems, but generally that's if
it's more than a year old (or if there's been some major upheaval that
happens to particularly strike your particular code).

Honestly, I don't think I can recall any actual "that is based on
something so old that it actually gets problematic" case ever having
happened.  But I could imagine it.

So if it's "a release or two", it's not worth rebasing for. Not unless
there is some other pressing reason (ie some screw-up that requires a
rebase).

                   Linus

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

