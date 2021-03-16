Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM5UN-000AsW-7I
 for linux-um@lists.infradead.org; Tue, 16 Mar 2021 08:55:45 +0000
Message-ID: <0d2ce878a618b9ac5868b19ca72ef5d88cd5d3c9.camel@sipsolutions.net>
Subject: Re: [PATCH] um: implement flush_cache_vmap/flush_cache_vunmap
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 16 Mar 2021 09:55:40 +0100
In-Reply-To: <27e8fe7b-8567-4489-6af3-cf13ad4ab25a@kot-begemot.co.uk>
References: <20210315233804.d3e52f6a3422.I9672eef7dfa7ce6c3de1ccf7ab8d9aad1fa7f3a6@changeid>
 <27e8fe7b-8567-4489-6af3-cf13ad4ab25a@kot-begemot.co.uk>
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, linux-um@lists.infradead.org

On Tue, 2021-03-16 at 08:46 +0000, Anton Ivanov wrote:
> 
> Well spotted.
> 
> Unless I am mistaken, there may be a slightly better way of doing it.
> 
> We can implement arch_sync_kernel_mappings() and sync only where the
> page modified mask says so by setting ARCH_PAGE_TABLE_SYNC_MASK
> 
> This way flush_cache_* can remain nops as in asm-generic

Would that actually buy us anything?

Not that I mind, or even understand the TLB code well, but it seems
fairly similar?

> I am going to give that a spin, if it works, I will post it to the list by lunchtime GMT

Sounds good to me :)

I also made these patches:

https://lore.kernel.org/lkml/20210315235453.e3fbb86e99a0.I08a3ee6dbe47ea3e8024956083f162884a958e40@changeid/T/#u


so my "vmalloc-heavy workload" no longer is vmalloc heavy since it now
uses kvmalloc and never hits vmalloc, always kmalloc :)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

