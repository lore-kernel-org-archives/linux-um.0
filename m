Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <eaa15fe0-dee2-3969-012a-9a0356acc069@nod.at>
References: <20161110015326.GA51351@juliacomputing.com> <f95971bb-8e9a-3937-a3f7-b1904fb61af1@nod.at>
 <CABV8kRxxjigyieEZJwywUxDmf_LAqSqHpsvd46nWueJe7hFCsg@mail.gmail.com>
 <b2baeaa1-b19c-c95f-2cee-4b4ba0411ca7@nod.at> <CABV8kRyr+PZmfd8B+rN2vWfbnmjmp85oGH_BU7zbUyqDQt+NxQ@mail.gmail.com>
 <eaa15fe0-dee2-3969-012a-9a0356acc069@nod.at>
From: Keno Fischer <keno@juliacomputing.com>
Date: Thu, 10 Nov 2016 15:46:01 -0500
Message-ID: <CABV8kRzxbmZrdBwky1=VHyPgH4eB9CZpLHgRMTxOhfsp6ETdGQ@mail.gmail.com>
Subject: Re: [PATCH] um: Fix compile failure due to current_text_address() definition
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Nov 10, 2016 at 3:19 PM, Richard Weinberger <richard@nod.at> wrote:
> Can you please reply to Sebastian's patch series and explain him how you trigger
> that error?
> I don't have a gcc broken by Debian on my machine right now.

I'm not sure how to reply to his patch series directly since I'm not
subscribed to lkml
(I imagine I can set headers manually, such that things get
appropriately threaded,
but for now let me just reply here). I don't think there's much to it.
It seems like any
use of `current_text_addr()` in `ARCH=um` build will cause this
problem, there's just
not very many such uses in the code base. I believe this particular
problem should
be reproducible as long as CONFIG_INET is set for an `ARCH=um` build.

