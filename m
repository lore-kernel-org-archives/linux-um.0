Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQEkq-0001dd-Ts
 for linux-um@lists.infradead.org; Wed, 07 Oct 2020 19:05:37 +0000
Message-ID: <8ff2e602fca71fb7244c178017959cc8d153fbfd.camel@sipsolutions.net>
Subject: Re: [RFC v7 12/21] um: nommu: system call interface and application
 API
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 07 Oct 2020 21:05:30 +0200
In-Reply-To: <03cee062a2841e3597ae181f1903d21394651f62.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
 <03cee062a2841e3597ae181f1903d21394651f62.1601960644.git.thehajime@gmail.com>
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
> +++ b/arch/um/nommu/include/uapi/asm/syscalls.h
> @@ -0,0 +1,287 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */

That doesn't really make sense - if you use LKL you're linking Linux, so
you can't use this "WITH Linux-syscall-note"?

> +#ifndef __UM_NOMMU_UAPI_SYSCALLS_H
> +#define __UM_NOMMU_UAPI_SYSCALLS_H

[snip]

This file really worries me, it includes half the world and (re)defines
the other half ... How is this ever going to be maintained?

> index 000000000000..ec7356c0dee9
> --- /dev/null
> +++ b/arch/um/scripts/headers_install.py
> @@ -0,0 +1,197 @@
> +#!/usr/bin/env python

might want to make that explicitly 'python3', some newer distros (e.g.
ubuntu 20.04) are now shipping without a 'python' by default.

> +def has_lkl_prefix(w):
> +  return w.startswith("lkl") or w.startswith("_lkl") or w.startswith("__lkl") \
> +         or w.startswith("LKL") or w.startswith("_LKL") or w.startswith("__LKL")


> +        content = re.sub(re.compile("(\/\*(\*(?!\/)|[^*])*\*\/)", re.S|re.M), " ", open(h).read())
> 
> +    dir = os.path.dirname(h)
> +    out_dir = args.path + "/" + re.sub("(" + srctree + "/arch/um/nommu/include/uapi/|arch/um/nommu/include/generated/uapi/|include/generated/uapi/|include/generated|" + install_hdr_path + "/include/)(.*)", "lkl/\\2", dir)


you have some very long lines in places, I'm sure you could fix that
(e.g. the last one by doing something with '|'.join([...]))

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

