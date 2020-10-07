Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQB7q-0002Go-TM
 for linux-um@lists.infradead.org; Wed, 07 Oct 2020 15:13:08 +0000
Message-ID: <0817bfdee3ee28ae8b94251ed559cf4e844a5ea4.camel@sipsolutions.net>
Subject: Re: [RFC v7 02/21] um: add os init and exit calls
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 07 Oct 2020 17:13:02 +0200
In-Reply-To: <184f5b2c6a0c399edf519d27989519a35ab90700.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
 <184f5b2c6a0c399edf519d27989519a35ab90700.1601960644.git.thehajime@gmail.com>
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
> 
> -#define __define_initcall(level,fn) \
> -	static initcall_t __initcall_##fn __used \
> -	__attribute__((__section__(".initcall" level ".init"))) = fn
> -
> -/* Userspace initcalls shouldn't depend on anything in the kernel, so we'll
> - * make them run first.
> - */
> -#define __initcall(fn) __define_initcall("1", fn)
> +#undef __uml_exit_call
> +#define __uml_exit_call		__used __section(os_exitcalls)

Doesn't that break calling of sigio_cleanup and remove_umid_dir?

After all,

> +void __weak os_exitcalls(void)
> +{
> +}

This does nothing so far.

Also, why the __weak?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

