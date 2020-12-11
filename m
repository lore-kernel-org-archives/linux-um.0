Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knoiv-000105-JJ
 for linux-um@lists.infradead.org; Fri, 11 Dec 2020 20:09:06 +0000
Message-ID: <d5ca568663ab7394ead9a5345ce42df16b5f6aaa.camel@sipsolutions.net>
Subject: Re: [PATCH v4 3/7] um: "borrow" atomics from x86 architecture
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 11 Dec 2020 21:08:47 +0100
In-Reply-To: <20201211174559.26010-4-anton.ivanov@cambridgegreys.com>
References: <20201211174559.26010-1-anton.ivanov@cambridgegreys.com>
 <20201211174559.26010-4-anton.ivanov@cambridgegreys.com>
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

On Fri, 2020-12-11 at 17:45 +0000, anton.ivanov@cambridgegreys.com
wrote:
> 
> +++ b/arch/um/include/asm/atomic.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ATOMIC_XOR_H

XOR?

And also here - are the symlinks really needed?

Not that I mind them too much, but it's a bit strange ... and would be a
lot harder to port to other arches, if anyone should be inclined, if
there are hard symlinks to x86.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

