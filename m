Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLXZg-00EWV6-Ng
 for linux-um@lists.infradead.org; Sun, 14 Mar 2021 20:43:06 +0000
Message-ID: <1aebaecdb4c5b3e62f5a89618b9d13f237d6b3c1.camel@sipsolutions.net>
Subject: Re: [RFC v8 11/20] um: lkl: basic console support
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sun, 14 Mar 2021 21:42:52 +0100
In-Reply-To: <5ec3a7157f7d96943b5701f8d57e102181cd56d2.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
 <5ec3a7157f7d96943b5701f8d57e102181cd56d2.1611103406.git.thehajime@gmail.com>
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
Cc: tavi.purdila@gmail.com, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, retrage01@gmail.com


> 
> -obj-y := stdio_console.o fd.o chan_kern.o chan_user.o line.o
> +ifndef CONFIG_UMMODE_LIB
> +obj-y := stdio_console.o
> +else
> +obj-y :=
> +endif
> +obj-y += fd.o chan_kern.o chan_user.o line.o

Might nicer to do via Kconfig, such as

config STDIO_CONSOLE
	def_bool y
	depends on !UMMODE_LIB

and then

obj-$(CONFIG_STDIO_CONSOLE) += stdio_console.o

here. Similar to CONFIG_STDDER_CONSOLE, after all.
> +/**
> + * lkl_print - optional operation that receives console messages

How is it optional? I don't see you having a __weak definition?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

