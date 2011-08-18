Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4E4CED56.1030100@nod.at>
Date: Thu, 18 Aug 2011 12:45:42 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <4E4C2B6F.7000800@nod.at> <4E4CB13C.7010502@meduna.org>
In-Reply-To: <4E4CB13C.7010502@meduna.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [uml-devel] Floating point problems on UML - help needed
To: Stanislav Meduna <stano@meduna.org>
Cc: linux-kernel@vger.kernel.org, gunnarlindroth@hotmail.com, user-mode-linux-devel@lists.sourceforge.net, inguin@gmx.de
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 18.08.2011 08:29, schrieb Stanislav Meduna:
> On 17.08.2011 22:58, Richard Weinberger wrote:
>
>> It looks like FPU registers get sometimes lost after switching between
>> two or more threads.
>
> This is probably a bug in UML I reported nearly three years ago.
> For me mode=skas0 worked aruond the issue.
>
> http://thread.gmane.org/gmane.linux.uml.devel/11824/focus=11840
>
> You might try the patch posted in
> http://thread.gmane.org/gmane.linux.uml.devel/12158
> (I don't have the environment to test it anymore)

Cool, saving the FP registers explicitly on each task switch solves the 
issue.
Do you know why Ingo's patch was never applied?
Ingo?

Thanks,
//richard
