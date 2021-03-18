Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <90d11ebdb1f9e13387aa7699702da7e7fecec27d.camel@sipsolutions.net>
Subject: Re: [PATCH 4/6] um: split up CONFIG_GCOV
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 18 Mar 2021 22:30:38 +0100
In-Reply-To: <CAFd5g47uR=HxjVET3uygeND8tFsZtfkgsS-PjMagbcagPMTBEg@mail.gmail.com> (sfid-20210318_222737_121554_AD23102C)
References: <20210312095526.197739-1-johannes@sipsolutions.net>
         <20210312104627.927fb4c7d36f.Idb980393c41c2129ee592de4ed71e7a5518212f9@changeid>
         <CAFd5g47uR=HxjVET3uygeND8tFsZtfkgsS-PjMagbcagPMTBEg@mail.gmail.com>
         (sfid-20210318_222737_121554_AD23102C)
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, Jessica Yu <jeyu@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

Hi Brendan,

> Hey, thanks for doing this! I was looking into this a few weeks ago
> and root caused part of the issue in GCC and in the kernel, but I did
> not have a fix put together.
> 
> Anyway, most of the patches make sense to me, but I am not able to
> apply this patch on torvalds/master. Do you mind sending a rebase so I
> can test it?

Well, if you see my other replies in the thread, I gave up for various
reasons, see

https://lore.kernel.org/r/d36ea54d8c0a8dd706826ba844a6f27691f45d55.camel@sipsolutions.net

Personally, I ended up switching to CONFIG_GCOV_KERNEL instead because
it actually works for modules, but then it was _really_ slow (think 30s
to copy data for a few modules), but I root-caused this and ultimately
sent these patches instead:

https://patchwork.ozlabs.org/project/linux-um/patch/20210315233804.d3e52f6a3422.I9672eef7dfa7ce6c3de1ccf7ab8d9aad1fa7f3a6@changeid/
https://patchwork.ozlabs.org/project/linux-um/patch/20210315234731.2e03184a344b.I04f1816296f04c5aa7d7d88b33bd4a14dd458da8@changeid/


johannes


