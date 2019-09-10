Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7gZc-0001EH-FC
 for linux-um@lists.infradead.org; Tue, 10 Sep 2019 13:52:49 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <johannes@sipsolutions.net>) id 1i7gZb-0006n6-7H
 for linux-um@lists.infradead.org; Tue, 10 Sep 2019 15:52:47 +0200
Message-ID: <f4578c1983a939afce44a731a493adce098a178a.camel@sipsolutions.net>
Subject: Re: [PATCH v4 1/5] um: don't use generic barrier.h
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 10 Sep 2019 15:52:45 +0200
In-Reply-To: <1568123461-I95235a4f9e6929241afd5150f1ceceb45f5e28af@changeid>
References: <20190910135129.23095-1-johannes@sipsolutions.net>
 <1568123461-I95235a4f9e6929241afd5150f1ceceb45f5e28af@changeid>
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
To: linux-um@lists.infradead.org

On Tue, 2019-09-10 at 15:51 +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> UML has its own platform-specific barrier.h under arch/x86/um/,
> which should get used. Fix the build system to use it, and then
> fix the barrier.h to actually compile.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> I'm debugging some odd stuff with virtio, and the next patch is to
> remove dma_rmb/dma_wmb from this, or at least make them conditional
> on virtio support, since if we have virtio support we really need
> memory barriers there, not just compiler barriers.
> .
> At least in theory. My problem isn't actually fixed by this.

Oh, forgot to edit this - my problem turned out to be the "unbacked
memory" part that I fixed in the virtio patch.

Still, I think we need this.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

