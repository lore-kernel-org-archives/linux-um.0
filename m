Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQF2Y-0002xZ-F7
 for linux-um@lists.infradead.org; Wed, 07 Oct 2020 19:23:55 +0000
Message-ID: <11f40c1a85a118d8207a6f05fc574164a01af3a9.camel@sipsolutions.net>
Subject: Re: [RFC v7 20/21] um: host: add test programs
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 07 Oct 2020 21:23:51 +0200
In-Reply-To: <363dceeefe1c468adca17cec0b7ba4fad7c76ef3.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
 <363dceeefe1c468adca17cec0b7ba4fad7c76ef3.1601960644.git.thehajime@gmail.com>
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
> +LKL_TEST_CALL(getpid, lkl_sys_getpid, 1)

Could that be unified with KUNIT somehow?

> +++ b/tools/um/tests/run.py
> @@ -0,0 +1,172 @@
> +#!/usr/bin/env python
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; version 2 of the License
> +#
> +# Author: Octavian Purdila <tavi@cs.pub.ro>
> +#
> +
> +from __future__ import print_function
> +
> +import argparse
> +import os
> +import subprocess
> +import sys
> +import tap13

ok, I see now, you're doing something with TAP (test anything
protocol)...

Hmm. I must say I'm not a fan of adding a whole testing framework to the
kernel like that, even if it's pretty simple.

> +import xml.etree.ElementTree as ET
> +
> +from junit_xml import TestSuite, TestCase

yuck

Let's see if you can use KUNIT instead. Anything beyond that doesn't
really need to live in the kernel, IMHO.

johanens


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

