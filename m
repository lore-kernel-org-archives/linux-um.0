Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knoeH-0000pv-AW
 for linux-um@lists.infradead.org; Fri, 11 Dec 2020 20:04:18 +0000
Message-ID: <580fe708174c7daf90e8a3d68c0487a1e9aa434d.camel@sipsolutions.net>
Subject: Re: [PATCH v4 1/7] um: allow the use of glibc functions instead of
 builtins
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 11 Dec 2020 21:03:53 +0100
In-Reply-To: <20201211174559.26010-2-anton.ivanov@cambridgegreys.com>
References: <20201211174559.26010-1-anton.ivanov@cambridgegreys.com>
 <20201211174559.26010-2-anton.ivanov@cambridgegreys.com>
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
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> The UML kernel runs as a normal userspace process and can use most
> of glibc string.h functionality instead of built-ins. At present,
> when using built-ins, it is also limited to their unoptimized
> versions, because it does not have the runtime code patching present
> on x86 via apply_alternatives()
> 
> Allowing the use of glibc for memcpy, memmove, etc provides 1-5%
> boost on common file io as measured by cat and dd. The size of
> the linux executable is also reduced by ~10KBytes.
> 
> It is possible to turn this on/off via the kernel configuration.
> 
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

