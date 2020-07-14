Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvNOS-00046H-2L
 for linux-um@lists.infradead.org; Tue, 14 Jul 2020 16:02:59 +0000
Message-ID: <54c5ffb6416bf59f2f287762820ce84d8ad9b495.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/3] um: some fixes to build UML with musl
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 14 Jul 2020 18:02:29 +0200
In-Reply-To: <72b84dca-e285-bb1f-1b69-5b29c70806d8@cambridgegreys.com>
References: <20200704085213.444645-1-ignat@cloudflare.com>
 <20200704085213.444645-3-ignat@cloudflare.com>
 <8b168d8c-f526-42b4-7cec-ec7c26c64122@cambridgegreys.com>
 <CALrw=nFaeMPH9GbMWwiT4rV32=uLKa3ZOYpmnkKTA3bvMiyXYg@mail.gmail.com>
 <72b84dca-e285-bb1f-1b69-5b29c70806d8@cambridgegreys.com>
MIME-Version: 1.0
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Ignat Korchagin <ignat@cloudflare.com>
Cc: kernel-team <kernel-team@cloudflare.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, Brendan Higgins <brendanhiggins@google.com>

On Tue, 2020-07-14 at 11:43 +0100, Anton Ivanov wrote:

> Patch is OK with me, should not read patches before the 3rd double espresso next time.
> 
> I will +1 it, Richard, Johannes, what do you think?

I got dropped off the list in "The Great Infradead Purge" but I see it
in patchwork ;)

Not sure we should modify cc-can-link.sh without at least CC'ing
Masahiro Yamada?

But yeah, looks fine to me. Not that I have any interest in static
linking.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

