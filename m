Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gfMnf-0004Cx-Ua
 for linux-um@lists.infradead.org; Fri, 04 Jan 2019 10:34:01 +0000
From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] um: Try to avoid kmalloc in signal handling
Date: Fri, 04 Jan 2019 11:33:57 +0100
Message-ID: <9157944.H6u4diqB1j@blindfold>
In-Reply-To: <108ad3b6-93ee-5d8c-c1bf-b83e22ff3d3f@cambridgegreys.com>
References: <20190104100517.9809-1-anton.ivanov@cambridgegreys.com>
 <2157515.SUgOQPs8Ts@blindfold>
 <108ad3b6-93ee-5d8c-c1bf-b83e22ff3d3f@cambridgegreys.com>
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
Cc: linux-um@lists.infradead.org

Am Freitag, 4. Januar 2019, 11:19:46 CET schrieb Anton Ivanov:
> > I fear this is not correct.
> > Think of task switching, if you push something to reg_file[],
> > it is not guaranteed that the same task will run next and pop the item.
> > The order can change.
> 
> It should not occur for the signals that map onto IRQ (timer and IO) - 
> there it is all kernel.
> 
> I cannot trigger that for the other ones, but it may be possible.

We need to be super sure about this.
 
> IMO we should just bite the bullet and go back to using the stack 
> increasing the minimum stack order needed to 1 for 32 bit and to 2 for 
> 64 bit.

Increasing the kernel stack just for this is also a huge overhead.
But I never benchmarked it myself.

> x86 if I read it correctly is still using the stack even for the new 
> register sets.

Are you sure? I don't think so. The kernel stack is small and the xregset is
huge.
Where did you see this?

Thanks,
//richard



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

