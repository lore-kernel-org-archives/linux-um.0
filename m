Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQBGn-0002wW-7L
 for linux-um@lists.infradead.org; Wed, 07 Oct 2020 15:22:21 +0000
Message-ID: <255740d56676f005fc01e1a76959fef80ad68ef5.camel@sipsolutions.net>
Subject: Re: [RFC v7 04/21] um: host: implement os_initcalls and os_exitcalls
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 07 Oct 2020 17:22:18 +0200
In-Reply-To: <d3bfb0e0e4300bb5191ae51918dd0795de343dc2.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
 <d3bfb0e0e4300bb5191ae51918dd0795de343dc2.1601960644.git.thehajime@gmail.com>
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
Cc: tavi.purdila@gmail.com, linux-kernel-library@freelists.org, retrage01@gmail.com, Octavian Purdila <tavi@cs.pub.ro>, linux-arch@vger.kernel.org

On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:

> Note that this patch should be merged with "um: move arch/um/os-Linux
> dir to tools/um" but for now it is separate to make the review easier.

Not a fan of that, I must say ...

> +extern void (*__start_os_exitcalls)(void);
> +extern void (*__stop_os_exitcalls)(void);
> +
> +void os_exitcalls(void)
> +{
> +	exitcall_t *call;
> +
> +	call = &__stop_os_exitcalls;
> +	while (--call >= &__start_os_exitcalls)
> +		(*call)();

You should check for and skip NULL pointers, there always are alignment
issues with automatic section filling like this, more so with clang than
gcc.

> +}
> +
> +extern int (*__start_os_initcalls)(void);
> +extern int (*__stop_os_initcalls)(void);
> +
> +int os_initcalls(void)
> +{
> +	initcall_t *call;
> +
> +	call = &__stop_os_initcalls;
> +	while (--call >= &__start_os_initcalls)
> +		(*call)();

Same here.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

