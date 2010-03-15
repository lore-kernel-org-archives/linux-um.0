Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tabbott@ksplice.com>) id 1NqzYF-00025E-Ay
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Mar 2010 01:57:03 +0000
Received: from mail-qy0-f180.google.com ([209.85.221.180])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NqzYE-0004WL-0v for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 15 Mar 2010 01:57:03 +0000
Received: by qyk10 with SMTP id 10so2329170qyk.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 14 Mar 2010 18:56:56 -0700 (PDT)
Date: Sun, 14 Mar 2010 20:51:47 -0400 (EDT)
From: Tim Abbott <tabbott@ksplice.com>
In-Reply-To: <alpine.DEB.1.10.1001041421450.4942@dr-wily.mit.edu>
Message-ID: <alpine.DEB.1.10.1001112141420.18920@dr-wily.mit.edu>
References: <alpine.DEB.1.10.1001041421450.4942@dr-wily.mit.edu>
MIME-Version: 1.0
Subject: Re: [uml-devel] [REGRESSION] um: CONFIG_STATIC_LINK=y broken
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: richard -rw- weinberger <richard.weinberger@gmail.com>, user-mode-linux-devel@lists.sourceforge.net

Hi Jeff,

I noticed that this fix for CONFIG_STATIC_LINK=y still hasn't been merged 
yet, two months after the original report and fix.  Is there an issue with 
it that needs addressing?

	-Tim Abbott

On Mon, 4 Jan 2010, Tim Abbott wrote:

> Hi Linus,
> 
> The following patch fixes a regression that I caused in 2.6.32 when 
> cleaning up the um architecture's linker scripts.
> 
> I've not heard anything from the um maintainers (they have had since 
> Richard Weinberger reported that this patch fixed the problem on December 
> 22), so I'm sending this to you now (and CCing stable@ since it affects 
> 2.6.32).
> 
> 	-Tim Abbott
> 
> --
> 
> um: remove PAGE_SIZE alignment in linker script causing kernel segfault.
> 
> The linker script cleanup that I did in commit 
> 5d150a97f9391f5bcd7ba0d59d7a11c3de3cea80 accidentally introduced an 
> ALIGN(PAGE_SIZE) when converting to use INIT_TEXT_SECTION; Richard 
> Weinberger reported that this causes the kernel to segfault with 
> CONFIG_STATIC_LINK=y.
> 
> I'm not certain why this extra alignment is a problem, but it seems likely 
> it is because previously
> 
> __init_begin = _stext = _text = _sinittext 
> 
> and with the extra ALIGN(PAGE_SIZE), _sinittext becomes different from the 
> rest.  So there is likely a bug here where something is assuming that 
> _sinittext is the same as one of those other symbols.  But reverting the 
> accidental change fixes the regression, so it seems worth committing that 
> now.
> 
> Signed-off-by: Tim Abbott <tabbott@ksplice.com>
> Reported-by: richard -rw- weinberger <richard.weinberger@gmail.com>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: user-mode-linux-devel@lists.sourceforge.net
> ---
>  arch/um/kernel/uml.lds.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/um/kernel/uml.lds.S b/arch/um/kernel/uml.lds.S
> index e7a6cca..664f942 100644
> --- a/arch/um/kernel/uml.lds.S
> +++ b/arch/um/kernel/uml.lds.S
> @@ -22,7 +22,7 @@ SECTIONS
>    _text = .;
>    _stext = .;
>    __init_begin = .;
> -  INIT_TEXT_SECTION(PAGE_SIZE)
> +  INIT_TEXT_SECTION(0)
>    . = ALIGN(PAGE_SIZE);
>  
>    .text      :
> -- 
> 1.6.5.7
> 

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

