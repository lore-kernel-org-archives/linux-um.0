Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hsM4C-0003Ow-3t
 for linux-um@lists.infradead.org; Tue, 30 Jul 2019 06:57:01 +0000
Message-ID: <e29f4e44ac9d671521287d492b96cb8e5295b424.camel@sipsolutions.net>
Subject: Re: [PATCHv3 4/5] um: Fix off by one error in IRQ enumeration
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 30 Jul 2019 08:56:53 +0200
In-Reply-To: <20190722073025.20844-4-anton.ivanov@cambridgegreys.com>
References: <20190722073025.20844-1-anton.ivanov@cambridgegreys.com>
 <20190722073025.20844-4-anton.ivanov@cambridgegreys.com>
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
Cc: richard@nod.at

On Mon, 2019-07-22 at 08:30 +0100, anton.ivanov@cambridgegreys.com
wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> Fix an off-by-one in IRQ enumeration
> 
> Reported by: Dana Johnson <djohns042@gmail.com>

nit: "Reported-by"
 
> -#define LAST_IRQ (VECTOR_IRQ_SPACE + VECTOR_BASE_IRQ)
> +#define LAST_IRQ (VECTOR_IRQ_SPACE + VECTOR_BASE_IRQ - 1)

Somebody internally at my group just made the same patch, but came to
the cnoclusion that we also need, in arch/um/kernel/irq.c:


-   for (i = 1; i < LAST_IRQ; i++)
+   for (i = 1; i <= LAST_IRQ; i++)

in init_IRQ()?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

