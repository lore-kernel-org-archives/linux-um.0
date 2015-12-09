Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linus971@gmail.com>) id 1a6TfK-0003MZ-Pj
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Dec 2015 01:35:34 +0000
Received: from mail-ig0-f173.google.com ([209.85.213.173])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1a6TfJ-0001vM-KU
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Dec 2015 01:35:34 +0000
Received: by igcto18 with SMTP id to18so30078113igc.0
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 08 Dec 2015 17:35:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56674E18.7020905@nod.at>
References: <56674E18.7020905@nod.at>
Date: Tue, 8 Dec 2015 17:35:28 -0800
Message-ID: <CA+55aFx53MbO2HrVkrMr4K-8DU2gJTsmpaEECT3i4prUjcMUng@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
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
Subject: Re: [uml-devel] [GIT PULL] UML fixes for 4.4-rc5
To: Richard Weinberger <richard@nod.at>, Ingo Molnar <mingo@kernel.org>
Cc: the arch/x86 maintainers <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

On Tue, Dec 8, 2015 at 1:39 PM, Richard Weinberger <richard@nod.at> wrote:
>
> This pull request contains various bug fixes, most of them are
> fall out from the merge window.
>
> Richard Weinberger (2):
>       um: Fix fpstate handling

Ugh. This is very ugly. It's apparently the result of commit
530e5c827182 ("x86/headers: Make sigcontext pointers bit independent")
and apparently nobody noticed the uml fallout.

I've pulled, but I wanted the x86 people involved to be aware of this
ugly corner. I wonder if there might be some way for uml to continue
to use that fpstate entry as a pointer, at least when the wordsize
matches (which it will)?

                   Linus

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

