Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kndFn-0005r4-4R
 for linux-um@lists.infradead.org; Fri, 11 Dec 2020 07:54:15 +0000
Message-ID: <b136db8b5b804f95cf2e7eb14bf8fc9b66ee62a3.camel@sipsolutions.net>
Subject: Re: [PATCH] um: time-travel: actually apply "free-until" optimisation
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 11 Dec 2020 08:54:09 +0100
In-Reply-To: <CAFLxGvyTvpsF+Hzcy-2z=cdED_OxVye_jKfmsbeqKPu4evxf3Q@mail.gmail.com>
 (sfid-20201210_232857_377124_2A3F4EF2)
References: <20201203153655.9143e9112c12.I0326b116f23cf30c573a54e9a0d9882c5703ef65@changeid>
 <CAFLxGvyTvpsF+Hzcy-2z=cdED_OxVye_jKfmsbeqKPu4evxf3Q@mail.gmail.com>
 (sfid-20201210_232857_377124_2A3F4EF2)
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

On Thu, 2020-12-10 at 23:28 +0100, Richard Weinberger wrote:
> 
> > -               if (!irqs_disabled() && !in_interrupt() && !in_softirq())
> > +               if (!irqs_disabled() && !in_interrupt() && !in_softirq() &&
> > +                   !time_travel_ext_waiting)
> 
> This will not build with timetravel support disabled.

Ahrg, sorry, will fix.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

