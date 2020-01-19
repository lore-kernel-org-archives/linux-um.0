Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1itIG9-00022A-Pn
 for linux-um@lists.infradead.org; Sun, 19 Jan 2020 21:37:31 +0000
Received: by mail-wr1-x442.google.com with SMTP id d16so27595659wre.10
 for <linux-um@lists.infradead.org>; Sun, 19 Jan 2020 13:37:29 -0800 (PST)
MIME-Version: 1.0
References: <20191210223403.244842-1-brendanhiggins@google.com>
In-Reply-To: <20191210223403.244842-1-brendanhiggins@google.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 19 Jan 2020 22:37:17 +0100
Message-ID: <CAFLxGvwHALbhE8XVWCijx25n-LpysYR=fH6WnHADn_=c_BZqow@mail.gmail.com>
Subject: Re: [PATCH v1] um: drivers: mark non-vector net transports as obsolete
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
To: Brendan Higgins <brendanhiggins@google.com>
Cc: "Berg, Johannes" <johannes.berg@intel.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, davidgow@google.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Tue, Dec 10, 2019 at 11:34 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> UML_NET_VECTOR now supports filters compiled with pcap outside of UML;
> it also supports: EoGRE, EoL2TPv3, RAW (+/- BPF), TAP and BESS.
>
> While vector drivers are not 1:1 replacements for the existing drivers,
> you can achieve the same topologies and the same connectivity at much
> higher performance (2.5 to 9 Gbit on mid-range Ryzen desktop) - the old
> drivers test out in the 500Mbit range on the same hardware.
>
> For all these reasons, the non-vector based transports are now
> unnecessary, and some, most notably pcap and vde are maintenance
> burdens. Thus, it makes sense to at least start thinking about removing
> the non-vector transports, so for now, mark them as obsolete.
>
> Link: https://lore.kernel.org/lkml/15f048d3-07ab-61c1-c6e0-0712e626dd33@cambridgegreys.com/T/#u
> Suggested-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>
> I pretty much stole the commit message from Anton's comments in the
> above link. Anton, if you would like me to credit you as a co-developer,
> feel free to respond with the tags and I will include them on the next
> revision.
>
> ---
>  arch/um/drivers/Kconfig | 81 +++++++++++++++++++++--------------------
>  1 file changed, 41 insertions(+), 40 deletions(-)

Applied. Thanks.

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

