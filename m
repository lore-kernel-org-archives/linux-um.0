Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkc5f-0004fJ-Ic
 for linux-um@lists.infradead.org; Fri, 18 Jan 2019 21:54:17 +0000
From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] um: Remove duplicate headers
Date: Fri, 18 Jan 2019 22:54:12 +0100
Message-ID: <9119450.NpuUixIce5@blindfold>
In-Reply-To: <d9f525fb-847f-312e-43e7-c80b65936680@cambridgegreys.com>
References: <5c41e99b.1c69fb81.f240b.506a@mx.google.com>
 <4621128.kXzvTGAT2u@blindfold>
 <d9f525fb-847f-312e-43e7-c80b65936680@cambridgegreys.com>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Sabyasachi Gupta <sabyasachi.linux@gmail.com>, yuehaibing@huawei.com, jdike@addtoit.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, jrdr.linux@gmail.com, brajeswar.linux@gmail.com

Am Freitag, 18. Januar 2019, 21:00:22 CET schrieb Anton Ivanov:
> >> Hi Sabyasachi,
> >>
> >> I believe we have an identical patch enqueued already from a couple of
> >> weeks back.
> > 
> > Hmm, did I miss that one in patchwork?
> > 
> > Thanks,
> > //richard
> > 
> > 
> > 
> > _______________________________________________
> > linux-um mailing list
> > linux-um@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-um
> > 
> https://patchwork.ozlabs.org/patch/1020163/

Ahh, I thought I forgot this for the last merge window.
Now things make sense again.

Anton, can you please test/Ack the patch? Then it can go to -next.

Thanks,
//richard




_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

