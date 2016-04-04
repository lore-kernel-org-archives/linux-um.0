Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1anCGY-0007Bq-Rx
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Apr 2016 21:42:34 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1anCGX-00036d-E9
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Apr 2016 21:42:34 +0000
References: <1458406721-7478-1-git-send-email-elicooper@gmx.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <5702DFC0.4070307@nod.at>
Date: Mon, 4 Apr 2016 23:42:24 +0200
MIME-Version: 1.0
In-Reply-To: <1458406721-7478-1-git-send-email-elicooper@gmx.com>
Subject: Re: [uml-devel] [PATCH v3 0/3] um: fix and extend FPU support
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
To: Eli Cooper <elicooper@gmx.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

Am 19.03.2016 um 17:58 schrieb Eli Cooper:
> This series first fixes a bug that results in corrupted FPU state after
> invoking signal handlers. It also adds support for the extended processor
> state (XSTATE) for x86_64 UML, especially the YMM registers used by AVX(2)
> instructions.
> 
> Tested with a minimal multi-threaded FPU-intensive test program (see below).
> This series supersedes the previous sigreturn fix as that one is incorrect
> when the process is multi-threaded.
> 
> Changes since v2:
>  - Add an improved sigreturn fix to this series
>  - Merge the ptrace changes into the last commit
>  - Make the selftest program multi-threaded
> 
> Changes since v1:
>  - Refactor functions with oversized stack frame
>  - Add a tiny selftest program to the cover letter
> 
> Eli Cooper (3):
>   um: fix FPU state preservation around signal handlers
>   um: extend fpstate to _xstate to support YMM registers
>   um: add extended processor state save/restore support

Sorry for my late response.
I'll put this now into -next and give it some testing.

Thanks a lot for fixing!
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

