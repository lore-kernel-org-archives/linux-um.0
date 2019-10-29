Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPMO4-00010u-9c
 for linux-um@lists.infradead.org; Tue, 29 Oct 2019 07:57:57 +0000
Message-ID: <179d1a35e32288b22b96545f21e141ba57265025.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 00/47] Unifying LKL into UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 29 Oct 2019 08:57:54 +0100
In-Reply-To: <cover.1571798507.git.thehajime@gmail.com>
References: <cover.1571798507.git.thehajime@gmail.com>
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
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>

On Wed, 2019-10-23 at 13:37 +0900, Hajime Tazaki wrote:
> 
> LKL (Linux Kernel Library) is aiming to allow reusing the Linux kernel code
> as extensively as possible with minimal effort and reduced maintenance
> overhead.

[snip]

Can you comment a bit on what's what?

For example, I look at patch 24 ("lkl tools: virtio: add network device
support") and wonder what that really is? Is it a hypervisor-side
implementation of the virtio-net device? If so, why is that considered
"tools"? (In ARCH=um, the hv-code usually lives in
arch/um/drivers/*_user.c or similar.)

Also, taking that as an example again, I think that's something we
should rather leave out initially - it looks like it has hooks into DPDK
and all kinds of other network interfaces on the host, which duplicates
a lot of existing functionality in ARCH=um.

Additionally, we (Intel) recently contributed a vhost-user backend, so
we don't really *need* a hypervisor implementation of e.g. DPDK
integration at all, that should be possible over vhost-user instead.

Looking further at the series - many of your patches really need better
commit logs explaining what and why they do something. Particularly the
reverts, but even trivial patches like the first one in the series.

patch 2: doesn't explain why it's necessary - how is this not covered by
adding a "config SOMETHING\n  def_bool y" in the architecture?

patch 4: kernel-doc doesn't parse, it's also very awkward to add this
without any users, why not add a very simple version of the struct with
the first patch needing it, and then extend it in each next patch?

[oops, out of time, will continue later]

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

