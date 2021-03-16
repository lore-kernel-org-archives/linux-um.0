Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM6U6-000LDs-00
 for linux-um@lists.infradead.org; Tue, 16 Mar 2021 09:59:31 +0000
Message-ID: <8d38e204acf8fbd1de42890ff8a351cbe689c1d3.camel@sipsolutions.net>
Subject: Re: [PATCH] um: implement arch_sync_kernel_mappings
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 16 Mar 2021 10:59:27 +0100
In-Reply-To: <20210316095841.5837-1-anton.ivanov@cambridgegreys.com>
References: <20210316095841.5837-1-anton.ivanov@cambridgegreys.com>
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
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org

On Tue, 2021-03-16 at 09:58 +0000, anton.ivanov@cambridgegreys.com
wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> This improves the tlb flushing behavior by syncing modified
> ranges out of map_kernel_range_noflush in a way which is
> similar to x86.

So I take it this replaces my patch?

Want me to test it (without the kvmalloc)?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

