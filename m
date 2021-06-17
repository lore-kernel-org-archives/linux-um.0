Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltxjj-00BWOY-1o
 for linux-um@lists.infradead.org; Thu, 17 Jun 2021 19:31:36 +0000
Message-ID: <db83b3c4a2202c2591898c410f4980cf88fb1613.camel@sipsolutions.net>
Subject: Re: [PATCH v4 4/9] um: export signals_enabled directly
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 17 Jun 2021 21:31:30 +0200
In-Reply-To: <CAFLxGvy8aZq9OO+--bz7vxFa3s+NgaPqTFQO+DLBFivS+Fai-Q@mail.gmail.com>
 (sfid-20210617_212157_642443_0F782CCF)
References: <20210305122010.442577-1-johannes@sipsolutions.net>
 <20210305131934.b1cae3585b98.I2a08cbe698fc23f1731e33e4f2582475290b90dc@changeid>
 <CAFLxGvy8aZq9OO+--bz7vxFa3s+NgaPqTFQO+DLBFivS+Fai-Q@mail.gmail.com>
 (sfid-20210617_212157_642443_0F782CCF)
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: linux-um <linux-um@lists.infradead.org>

On Thu, 2021-06-17 at 21:21 +0200, Richard Weinberger wrote:
> On Fri, Mar 5, 2021 at 1:20 PM Johannes Berg <johannes@sipsolutions.net> wrote:
> > +#define UML_SETJMP(buf) ({                             \
> > +       int n, enable;                                  \
> > +       enable = *(volatile int *)&signals_enabled;     \
> 
> Isn't this a case for READ_ONCE()?

I guess, but it's in shared code, so must compile without kernel-space
headers.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

