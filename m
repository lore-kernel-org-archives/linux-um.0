Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvd5I-0001kD-9Y
 for linux-um@lists.infradead.org; Wed, 15 Jul 2020 08:48:12 +0000
Received: by mail-pj1-x1043.google.com with SMTP id cm21so2756150pjb.3
 for <linux-um@lists.infradead.org>; Wed, 15 Jul 2020 01:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200704085213.444645-1-ignat@cloudflare.com>
 <20200704085213.444645-3-ignat@cloudflare.com>
 <8b168d8c-f526-42b4-7cec-ec7c26c64122@cambridgegreys.com>
 <CALrw=nFaeMPH9GbMWwiT4rV32=uLKa3ZOYpmnkKTA3bvMiyXYg@mail.gmail.com>
 <72b84dca-e285-bb1f-1b69-5b29c70806d8@cambridgegreys.com>
 <54c5ffb6416bf59f2f287762820ce84d8ad9b495.camel@sipsolutions.net>
In-Reply-To: <54c5ffb6416bf59f2f287762820ce84d8ad9b495.camel@sipsolutions.net>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 15 Jul 2020 01:47:58 -0700
Message-ID: <CAFd5g47ZOpxjmFGnq+EXrnbT4HEziH3WVZGoFtaqBPBNN+gdWA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] um: some fixes to build UML with musl
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
Cc: kernel-team <kernel-team@cloudflare.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Ignat Korchagin <ignat@cloudflare.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Tue, Jul 14, 2020 at 9:02 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2020-07-14 at 11:43 +0100, Anton Ivanov wrote:
>
> > Patch is OK with me, should not read patches before the 3rd double espresso next time.
> >
> > I will +1 it, Richard, Johannes, what do you think?
>
> I got dropped off the list in "The Great Infradead Purge" but I see it
> in patchwork ;)
>
> Not sure we should modify cc-can-link.sh without at least CC'ing
> Masahiro Yamada?
>
> But yeah, looks fine to me. Not that I have any interest in static
> linking.

Yeah, looks good to me as well, but I think the others here know the
drivers here better than I.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

