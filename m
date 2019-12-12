Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifCSg-0001cq-VQ
 for linux-um@lists.infradead.org; Thu, 12 Dec 2019 00:36:12 +0000
Received: by mail-pg1-x543.google.com with SMTP id b9so186215pgk.12
 for <linux-um@lists.infradead.org>; Wed, 11 Dec 2019 16:36:07 -0800 (PST)
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <e1e0fdadd05387200caf361dc08713a811263258.camel@sipsolutions.net>
In-Reply-To: <e1e0fdadd05387200caf361dc08713a811263258.camel@sipsolutions.net>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Wed, 11 Dec 2019 16:35:55 -0800
Message-ID: <CAFd5g47tOCDossSbW1y1dO-2gEjuPDWW4pHTY3A3ZVvwyOTSEQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] uml: add unspecified HAS_IOMEM dependencies
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
Cc: linux-um <linux-um@lists.infradead.org>

On Wed, Dec 11, 2019 at 12:06 PM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> (stripping CCs a lot)
>
> On Wed, 2019-12-11 at 11:27 -0800, Brendan Higgins wrote:
> > # TL;DR
> >
> > This patchset adds a missing HAS_IOMEM dependency to several drivers in
> > an attempt to get allyesconfig closer to working for ARCH=um.
>
> Out of curiosity, how big does that monstrosity get? :)

A bit more than 4000 lines as opposed to over 13000 lines for x86 and ARM.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

