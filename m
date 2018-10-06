Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g8tvF-0006Ff-FY
 for linux-um@lists.infradead.org; Sat, 06 Oct 2018 21:15:38 +0000
From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v3] Optimise TLB flush for kernel mm in UML
Date: Sat, 06 Oct 2018 23:15:25 +0200
Message-ID: <1764739.0Z0hY7T85t@blindfold>
In-Reply-To: <83f296bd-feb1-5177-228e-f294aa22fa5f@kot-begemot.co.uk>
References: <20181004172510.27410-1-anton.ivanov@cambridgegreys.com>
 <1615399.BP76ARYnqk@blindfold>
 <83f296bd-feb1-5177-228e-f294aa22fa5f@kot-begemot.co.uk>
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: linux-um@lists.infradead.org

Am Samstag, 6. Oktober 2018, 23:04:08 CEST schrieb Anton Ivanov:
> On 06/10/2018 21:38, Richard Weinberger wrote:
> > Anton,
> >
> > Am Donnerstag, 4. Oktober 2018, 19:25:10 CEST schrieb anton.ivanov@cambridgegreys.com:
> >> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> >>
> >> This patch introduces bulking up memory ranges to be passed to
> >> mmap/munmap/mprotect instead of doing everything one page at a time.
> >>
> >> This is already being done for the userspace UML portion, this
> >> adds a simplified version of it for the kernel mm.
> >>
> >> This results in speed up of up to 10%+ in some areas (sequential
> >> disk read measured with dd, etc).
> > Nice!
> > Do you have also data on how much less memory mappings get installed?
> 
> 
> Not proper statistics. I had some debug printks early on and instead of 
> single pages I was seeing a few hundred Kbytes at a time being mapped in 
> places. I can try a few trial runs with some debug printks to collect stats.
> 
> >
> >> Add further speed-up by removing a mandatory tlb force flush
> >> for swapless kernel.
> > It is also not entirely clear to me why swap is a problem here,
> > can you please elaborate?
> 
> I asked this question on the list a while back.
> 
> One of the main remaining huge performance bugbears  in UML which 
> accounts for most of its "fame" of being slow is the fact that there is 
> a full TLB flush every time a fork happens in the UML userspace. It is 
> also executed with force = 1.
> 
> You pointed me to an old commit from the days svn was being used which 
> was fixing exactly that by introducing the force parameter.
> 
> I tested force on/off and the condition that commit is trying to cure 
> still stands. If swap is enabled the tlb flush on fork/exec needs to 
> have force=1. If, however, there is no swap in the system the force is 
> not needed. It happily works without it.
> 
> Why - dunno. I do not fully understand some of that code.

Okay, I hoped you figured in the meanwhile.
Seems like we need to dig deeper in the history.

Thanks,
//richard



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

