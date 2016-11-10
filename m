Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1c4kMx-0001T7-HL
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Nov 2016 08:05:59 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c4kMw-0002lm-47
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Nov 2016 08:05:59 +0000
References: <20161110015326.GA51351@juliacomputing.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <f95971bb-8e9a-3937-a3f7-b1904fb61af1@nod.at>
Date: Thu, 10 Nov 2016 09:05:48 +0100
MIME-Version: 1.0
In-Reply-To: <20161110015326.GA51351@juliacomputing.com>
Subject: Re: [uml-devel] [PATCH] um: Fix compile failure due to
 current_text_address() definition
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
To: Keno Fischer <keno@juliacomputing.com>, linux-kernel@vger.kernel.org
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

Keno,

On 10.11.2016 02:53, Keno Fischer wrote:
> Fixes the following link error:
> ```
> /usr/bin/ld: net/built-in.o: relocation R_X86_64_32S against `.text'
> can not be used when making a shared object; recompile with -fPIC
> ```
> 
> This is the same definition used on some other architectures.
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---
> I am not sure this is the correct patch in the context of uml. I believe this
> should give the runtime ip, which may be different between runs. It may be
> better to use the offset in .text (e.g. by using `pc-__text_start`), which
> should be consistent.

The problem is ready being solved in a generic way:
http://marc.info/?l=linux-kernel&m=147828481602561&w=2

Can you please give this patch a try?

Thanks,
//richard

------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

