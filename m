Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lilium.sigma-star.at ([109.75.188.150])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fDWOV-0006rq-Fx
 for linux-um@lists.infradead.org; Tue, 01 May 2018 14:36:41 +0000
From: Richard Weinberger <richard@sigma-star.at>
Subject: Re: Question about process.c
Date: Tue, 01 May 2018 16:36:24 +0200
Message-ID: <4362422.B3hMBL5bEi@blindfold>
In-Reply-To: <40d875d4-8071-85e1-bad9-83995c9ebf8b@cambridgegreys.com>
References: <e58ff1a0-df76-7213-08d5-1f796a6a3956@cambridgegreys.com>
 <1708862.d7yAjbcJLQ@blindfold>
 <40d875d4-8071-85e1-bad9-83995c9ebf8b@cambridgegreys.com>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org

Anton,

Am Dienstag, 1. Mai 2018, 15:48:48 CEST schrieb Anton Ivanov:
> arch/um/kernel/process.c line 140 invokes force_flush_all();
> 
> which does a full tlb flush with the force flag set.
> 
> I did a quick test and I did not notice any breakage if we replace that 
> with a quickly hacked together new function called gentle_flush_all() 
> which does the same but without setting the force flag in the tlb routines.
> 
> At the same time I got 10% or better speedup for fork-heavy things like 
> startup, etc.
> 
> In fact, this is one of the last remaining major performance bugbears. 
> We got most of the other stuff to a very reasonable standard - 
> networking, disk, etc is not that far off from let's say qemu and the 
> overall "slowness" is now mostly down to the huge cost of fork/exec.
> 
> Example (ab)using busybox. Busybox executes cat passed as the find -exec 
> argument internally shortcutting to its applet. As a result there is no 
> cost of fork/exec incurred when we run a find -exec cat {} via busybox. 
> Normal find executes /bin/cat instead.
> 
> This allows us to compare and attribute the cost of fork/exec in scripts 
> as well as gives us a benchmark to see the effect of any changes.
> 
> Bare metal:
> 
> aivanov@amistad:/var/autofs/local/src/linux-work/linux-submit$ time 
> busybox find /mnt/usr -type f -exec cat {} > /dev/null \;
> 
> real    0m16.511s
> user    0m12.672s
> sys    0m4.001s
> aivanov@amistad:/var/autofs/local/src/linux-work/linux-submit$ time find 
> /mnt/usr -type f -exec cat {} > /dev/null \;
> 
> real    0m25.329s
> user    0m16.397s
> sys    0m9.185s
> 
> UML:
> 
> root@uml-switch:~# time busybox find /usr -type f -exec cat {} > 
> /dev/null \;
> 
> real    0m11.447s
> user    0m0.000s
> sys    0m8.820s
> root@uml-switch:~# time find /usr -type f -exec cat {} > /dev/null \;
> 
> real    7m8.228s
> user    0m0.000s
> sys    6m42.780s
> 
> The filesystem is identical in both cases. The experiment is not 
> perfectly "clean" as i am doing other stuff on my laptop, but it is 
> reasonably indicative
> 
> In fact, in the longer term I would really like to somehow speed-up most 
> of the stuff tlb.c It is painfully slow at present.

Hmmm, not sure. I fear without going deep into the UML history we cannot know.
I think we have to do a full flush for security reasons.

Thanks,
//richard

-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

