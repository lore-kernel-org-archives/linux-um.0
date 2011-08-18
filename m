Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4E4CF94B.4010803@gmx.de>
Date: Thu, 18 Aug 2011 13:36:43 +0200
From: Ingo van Lil <inguin@gmx.de>
MIME-Version: 1.0
References: <4E4C2B6F.7000800@nod.at> <4E4CB13C.7010502@meduna.org> <4E4CED56.1030100@nod.at>
In-Reply-To: <4E4CED56.1030100@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [uml-devel] Floating point problems on UML - help needed
To: Richard Weinberger <richard@nod.at>
Cc: Stanislav Meduna <stano@meduna.org>, linux-kernel@vger.kernel.org, gunnarlindroth@hotmail.com, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 18/08/2011 12:45, Richard Weinberger wrote:

>> You might try the patch posted in
>> http://thread.gmane.org/gmane.linux.uml.devel/12158
>> (I don't have the environment to test it anymore)
>
> Cool, saving the FP registers explicitly on each task switch solves the
> issue.
> Do you know why Ingo's patch was never applied?
> Ingo?

I don't know why it was never applied, I guess it just slipped between 
the cracks. I've been using the patch for several months back in 2009, 
and it reliably fixed the observed problems.

My employer switched from UML to QEMU/KVM since then, so I eventually 
lost interest.

Cheers,
Ingo
