Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQEoe-0002DX-JE
 for linux-um@lists.infradead.org; Wed, 07 Oct 2020 19:09:33 +0000
Message-ID: <661d5a2f715b1c65809ae81f1d56deb2fccb653c.camel@sipsolutions.net>
Subject: Re: [RFC v7 15/21] um: nommu: integrate with irq infrastructure of UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 07 Oct 2020 21:09:29 +0200
In-Reply-To: <68b53edd5ec17510626ae19546752cde198ecc3e.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
 <68b53edd5ec17510626ae19546752cde198ecc3e.1601960644.git.thehajime@gmail.com>
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


> @@ -541,6 +542,11 @@ unsigned long to_irq_stack(unsigned long *mask_out)
>  	unsigned long mask, old;
>  	int nested;
>  
> +#ifndef CONFIG_MMU

Also here and throughout, not sure I like (and it makes sense) to have
the equation of !CONFIG_MMU == LKL.

I mean, sure, that may actually be _true_ (at least right now), but it
doesn't feel like all of this really is a consequence of *NOMMU*, it's
more a consequence of LKL.

At least I think it is?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

