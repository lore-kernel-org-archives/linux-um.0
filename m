Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E4bSQ-0003c5-MU	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Aug 2005 02:40:38 -0700
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)	id 1E4bSO-0005Uf-9f
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Aug 2005 02:40:38 -0700
From: Russell King <rmk+lkml@arm.linux.org.uk>
Message-ID: <20050815104022.D19811@flint.arm.linux.org.uk>
References: <20050812182145.DF52E24E7F3@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050812182145.DF52E24E7F3@zion.home.lan>;
	from blaisorblade@yahoo.it on Fri, Aug 12, 2005 at 08:21:45PM +0200
Subject: [uml-devel] Re: [patch 18/39] remap_file_pages protection support:
	add VM_FAULT_SIGSEGV
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 15 Aug 2005 10:40:22 +0100
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, mingo@elte.hu

On Fri, Aug 12, 2005 at 08:21:45PM +0200, blaisorblade@yahoo.it wrote:
> @@ -632,10 +632,11 @@ static inline int page_mapped(struct pag
>   * Used to decide whether a process gets delivered SIGBUS or
>   * just gets major/minor fault counters bumped up.
>   */
> -#define VM_FAULT_OOM	(-1)
> -#define VM_FAULT_SIGBUS	0
> -#define VM_FAULT_MINOR	1
> -#define VM_FAULT_MAJOR	2
> +#define VM_FAULT_OOM		(-1)
> +#define VM_FAULT_SIGBUS		0
> +#define VM_FAULT_MINOR		1
> +#define VM_FAULT_MAJOR		2
> +#define VM_FAULT_SIGSEGV	3
>  
>  #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
>  

Please arrange for "success" values to be numerically larger than "failure"
values.  This will avoid breaking ARM.

Is there a reason why we don't use -ve numbers for failure and +ve for
success here?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
