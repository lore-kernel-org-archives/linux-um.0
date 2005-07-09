Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DrDBH-00009a-4K	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Jul 2005 04:07:35 -0700
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1DrDBF-0001uz-LH	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 09 Jul 2005 04:07:35 -0700
From: Russell King <rmk+lkml@arm.linux.org.uk>
Message-ID: <20050709120703.C2175@flint.arm.linux.org.uk>
References: <20050709110143.D59181E9EA4@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050709110143.D59181E9EA4@zion.home.lan>;
	from blaisorblade@yahoo.it on Sat, Jul 09, 2005 at 01:01:33PM +0200
Subject: [uml-devel] Re: [patch 1/1] uml: fix lvalue for gcc4
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
Date: Sat, 9 Jul 2005 12:07:03 +0100
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sat, Jul 09, 2005 at 01:01:33PM +0200, blaisorblade@yahoo.it wrote:
> diff -puN arch/um/sys-x86_64/signal.c~uml-fix-for-gcc4-lvalue arch/um/sys-x86_64/signal.c
> --- linux-2.6.git/arch/um/sys-x86_64/signal.c~uml-fix-for-gcc4-lvalue	2005-07-09 13:01:03.000000000 +0200
> +++ linux-2.6.git-paolo/arch/um/sys-x86_64/signal.c	2005-07-09 13:01:03.000000000 +0200
> @@ -168,7 +168,7 @@ int setup_signal_stack_si(unsigned long 
>  
>  	frame = (struct rt_sigframe __user *)
>  		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;
> -	((unsigned char *) frame) -= 128;
> +	frame -= 128 / sizeof(frame);

Are you sure these two are identical?

The above code fragment looks suspicious anyway, particularly:

 	frame = (struct rt_sigframe __user *)
 		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;

which will put the frame at 8 * sizeof(struct rt_sigframe) below
the point which round_down() would return (which would be 1 struct
rt_sigframe below stack_top, rounded down).

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
