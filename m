Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSZZk-0001rZ-6z
 for linux-um@lists.infradead.org; Fri, 30 Nov 2018 03:34:45 +0000
Received: by mail-pl1-f193.google.com with SMTP id g9so2097303plo.3
 for <linux-um@lists.infradead.org>; Thu, 29 Nov 2018 19:34:34 -0800 (PST)
Date: Thu, 29 Nov 2018 19:34:29 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [RFC v3 08/19] arch: um: add shim to trap to allow installing a
 fault catcher for tests
Message-ID: <20181130033429.GK18410@garbanzo.do-not-panic.com>
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-9-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181128193636.254378-9-brendanhiggins@google.com>
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
To: Brendan Higgins <brendanhiggins@google.com>
Cc: brakmo@fb.com, dri-devel@lists.freedesktop.org, linux-kselftest@vger.kernel.org, shuah@kernel.org, robh@kernel.org, frowand.list@gmail.com, linux-nvdimm@lists.01.org, richard@nod.at, knut.omang@oracle.com, kieran.bingham@ideasonboard.com, joel@jms.id.au, jdike@addtoit.com, Tim.Bird@sony.com, keescook@google.com, linux-um@lists.infradead.org, rostedt@goodmis.org, julia.lawall@lip6.fr, dan.j.williams@intel.com, kunit-dev@googlegroups.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, daniel@ffwll.ch, mpe@ellerman.id.au, joe@perches.com, khilman@baylibre.com

On Wed, Nov 28, 2018 at 11:36:25AM -0800, Brendan Higgins wrote:
> diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
> index cced829460427..bf90e678b3d71 100644
> --- a/arch/um/kernel/trap.c
> +++ b/arch/um/kernel/trap.c
> @@ -201,6 +201,12 @@ void segv_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
>  	segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
>  }
>  
> +static void segv_run_catcher(jmp_buf *catcher, void *fault_addr)
> +{
> +	current->thread.fault_addr = fault_addr;
> +	UML_LONGJMP(catcher, 1);
> +}
> +
>  /*
>   * We give a *copy* of the faultinfo in the regs to segv.
>   * This must be done, since nesting SEGVs could overwrite
> @@ -219,7 +225,10 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
>  	if (!is_user && regs)
>  		current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
>  
> -	if (!is_user && (address >= start_vm) && (address < end_vm)) {
> +	catcher = current->thread.fault_catcher;

This and..

> +	if (catcher && current->thread.is_running_test)
> +		segv_run_catcher(catcher, (void *) address);
> +	else if (!is_user && (address >= start_vm) && (address < end_vm)) {
>  		flush_tlb_kernel_vm();
>  		goto out;
>  	}

*not this*

> @@ -246,12 +255,10 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
>  		address = 0;
>  	}
>  
> -	catcher = current->thread.fault_catcher;
>  	if (!err)
>  		goto out;
>  	else if (catcher != NULL) {
> -		current->thread.fault_addr = (void *) address;
> -		UML_LONGJMP(catcher, 1);
> +		segv_run_catcher(catcher, (void *) address);
>  	}
>  	else if (current->thread.fault_addr != NULL)
>  		panic("fault_addr set but no fault catcher");

But with this seems one atomic change which should be submitted
separately, its just a helper. Think it would make the actual
change needed easier to review, ie, your needed changes would
be smaller and clearer for what you need.

  Luis

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

