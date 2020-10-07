Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQBfD-0007EK-PA
 for linux-um@lists.infradead.org; Wed, 07 Oct 2020 15:47:36 +0000
Message-ID: <486e080e64056189b5309bbcaec2ebf235d501a0.camel@sipsolutions.net>
Subject: Re: [RFC v7 10/21] um: nommu: memory handling
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 07 Oct 2020 17:47:33 +0200
In-Reply-To: <de40a235d95ad582dae11741e272a5cf300384f2.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
 <de40a235d95ad582dae11741e272a5cf300384f2.1601960644.git.thehajime@gmail.com>
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
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: tavi.purdila@gmail.com, linux-kernel-library@freelists.org, retrage01@gmail.com, linux-arch@vger.kernel.org

On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> 
>   * These operations must be provided by a host library or by the application
>   * itself.
>   *
> + * @mem_alloc - allocate memory
> + * @mem_free - free memory
> + *

Actual kernel-doc would be nicer.

> +	empty_zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> +	memset((void *)empty_zero_page, 0, PAGE_SIZE);
> +
> +	{
> +		unsigned long zones_size[MAX_NR_ZONES] = {0, };

Hmm, what's with the extra scope?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

