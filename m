Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLTwj-00EMOm-Fl
 for linux-um@lists.infradead.org; Sun, 14 Mar 2021 16:50:31 +0000
Message-ID: <e18da756e9efcae8489c658907b62d68f0969da0.camel@sipsolutions.net>
Subject: Re: [RFC v8 07/20] um: lkl: host interface
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sun, 14 Mar 2021 17:50:27 +0100
In-Reply-To: <f149135f1943eb81998d54c923c10ebffb0b4518.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
 <f149135f1943eb81998d54c923c10ebffb0b4518.1611103406.git.thehajime@gmail.com>
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


> +/**
> + * struct lkl_host_operations - host operations used by the Linux kernel
> + *
> + * These operations must be provided by a host library or by the application
> + * itself.
> + *
> + */
> +struct lkl_host_operations {
> +};

IIRC, in previous reviews we discussed this and you said you'd look at
just making those extern functions, instead of function pointers, since
realistically there's no use in being able to switch these at runtime.
What happened to that? Any particular reason not to?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

