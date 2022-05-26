Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nu9oG-00EDe7-HQ
	for linux-um@lists.infradead.org; Thu, 26 May 2022 09:29:37 +0000
Message-ID: <d5558b1a1ce7e1cb878f12462ae63a4d7b1b17a1.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v3] UML: add support for KASAN under x86_64
From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 26 May 2022 11:29:20 +0200
In-Reply-To: <20220526010111.755166-1-davidgow@google.com>
References: <20220525111756.GA15955@axis.com>
	 <20220526010111.755166-1-davidgow@google.com>
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
To: David Gow <davidgow@google.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>, Patricia Alfonso <trishalfonso@google.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, anton.ivanov@cambridgegreys.com, Dmitry Vyukov <dvyukov@google.com>, Brendan Higgins <brendanhiggins@google.com>
Cc: kasan-dev <kasan-dev@googlegroups.com>, linux-um@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Daniel Latypov <dlatypov@google.com>

On Wed, 2022-05-25 at 18:01 -0700, David Gow wrote:
> 
> +#ifdef CONFIG_KASAN
> +void kasan_init(void)
> +{
> +	/*
> +	 * kasan_map_memory will map all of the required address space and
> +	 * the host machine will allocate physical memory as necessary.
> +	 */
> +	kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
> +	init_task.kasan_depth = 0;
> +	os_info("KernelAddressSanitizer initialized\n");
> 

Can we remove this? Or maybe print it later somehow, when the other
KASAN machinery initializes?

As it is, this gets printed even if you run just "./linux --version" or
"--help", which is a bit strange.

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

