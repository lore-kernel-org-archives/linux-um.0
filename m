Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQaNf-0004HP-85
 for linux-um@lists.infradead.org; Thu, 08 Oct 2020 18:11:08 +0000
Received: by mail-lj1-x243.google.com with SMTP id a15so6770617ljk.2
 for <linux-um@lists.infradead.org>; Thu, 08 Oct 2020 11:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601960644.git.thehajime@gmail.com>
 <9494c2558406a8fd2938fef0c470dd640b7835ed.1601960644.git.thehajime@gmail.com>
 <0563db2b81f44028515e19b8edeb50e1cf29d922.camel@sipsolutions.net>
In-Reply-To: <0563db2b81f44028515e19b8edeb50e1cf29d922.camel@sipsolutions.net>
From: Octavian Purdila <tavi.purdila@gmail.com>
Date: Thu, 8 Oct 2020 21:10:55 +0300
Message-ID: <CAMoF9u2zohNEtqYxEPNZBkW_XJvnAWo3OHtVo3jva8+c94Lksg@mail.gmail.com>
Subject: Re: [RFC v7 09/21] um: nommu: host interface
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
Cc: linux-arch <linux-arch@vger.kernel.org>, Richard Weinberger <richard@nod.at>, jdike@addtoit.com, linux-um <linux-um@lists.infradead.org>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library <linux-kernel-library@freelists.org>, Hajime Tazaki <thehajime@gmail.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Wed, Oct 7, 2020 at 6:45 PM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> > This patch introduces the host operations that define the interface
> > between the LKL and the host. These operations must be provided either
> > by a host library or by the application itself.
> >
>
> I kinda find patches like this very pointless ... you see nothing, and
> can't really say anything. Maybe add the infra with the first user?
>
> > +/* Defined in {posix,nt}-host.c */
>
> That doesn't exist either yet ...
>

Noted, we will fix it in the next patch series.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

