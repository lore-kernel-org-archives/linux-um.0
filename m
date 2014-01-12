Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <hpa@zytor.com>) id 1W2OQc-0006sV-U9
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jan 2014 17:02:26 +0000
Received: from terminus.zytor.com ([198.137.202.10] helo=mail.zytor.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1W2OQb-0002Ld-9Y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jan 2014 17:02:26 +0000
Message-ID: <52D2CA8E.7090707@zytor.com>
Date: Sun, 12 Jan 2014 09:02:06 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
References: <20140112120305.GA13076@gmail.com>
	<1389538341-31383-1-git-send-email-richard@nod.at>
In-Reply-To: <1389538341-31383-1-git-send-email-richard@nod.at>
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
Subject: Re: [uml-devel] [PATCH] um, x86: Fix vDSO build
To: Richard Weinberger <richard@nod.at>, mingo@redhat.com, Fengguang Wu <fengguang.wu@intel.com>
Cc: paul.gortmaker@windriver.com, tglx@linutronix.de, user-mode-linux-devel@lists.sourceforge.net, linux-tip-commits@vger.kernel.org

On 01/12/2014 06:52 AM, Richard Weinberger wrote:
> Commit "x86: Delete non-required instances of include <linux/init.h>"
> broke the UML build.
> 
> arch/x86/um/vdso/vdso.S: Assembler messages:
> arch/x86/um/vdso/vdso.S:2: Error: no such instruction: `__initdata'
> arch/x86/um/vdso/vdso.S:9: Error: no such instruction: `__finit'
> 
> UML's vDSO needs linux/init.h.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/x86/um/vdso/vdso.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/um/vdso/vdso.S b/arch/x86/um/vdso/vdso.S
> index 4b4bd4c..1cb468a 100644
> --- a/arch/x86/um/vdso/vdso.S
> +++ b/arch/x86/um/vdso/vdso.S
> @@ -1,3 +1,4 @@
> +#include <linux/init.h>
>  
>  __INITDATA
>  

So more bits that got "cleaned up" but never actually tested.  Sigh.

Fengguang, could we get UM builds added to the test robot?

	-hpa



------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today.
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

