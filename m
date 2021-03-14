Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLXXV-00EWPd-SB
 for linux-um@lists.infradead.org; Sun, 14 Mar 2021 20:40:43 +0000
Message-ID: <cf6713530642cdd11abc91a2ddb67f040c806aba.camel@sipsolutions.net>
Subject: Re: [RFC v8 12/20] um: lkl: initialization and cleanup
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sun, 14 Mar 2021 21:40:39 +0100
In-Reply-To: <031847ceca73023566fba8e84433a615eac6a2f3.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
 <031847ceca73023566fba8e84433a615eac6a2f3.1611103406.git.thehajime@gmail.com>
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

On Wed, 2021-01-20 at 11:27 +0900, Hajime Tazaki wrote:
> 
> +	panic_blink = lkl_panic_blink;

Using a panic notifier would seem more appropriate?

> +	init_sem = lkl_sem_alloc(0);

what's the deal with this?

> +	if (!init_sem)
> +		return -ENOMEM;
> +
> +	ret = lkl_cpu_init();
> +	if (ret)
> +		goto out_free_init_sem;
> +
> +	ret = lkl_thread_create(lkl_run_kernel, NULL);
> +	if (!ret) {
> +		ret = -ENOMEM;
> +		goto out_free_init_sem;
> +	}
> +
> +	lkl_sem_down(init_sem);
> +	lkl_sem_free(init_sem);

You free it before the kernel really even started?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

