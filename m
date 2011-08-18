Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4E4CB13C.7010502@meduna.org>
Date: Thu, 18 Aug 2011 08:29:16 +0200
From: Stanislav Meduna <stano@meduna.org>
MIME-Version: 1.0
References: <4E4C2B6F.7000800@nod.at>
In-Reply-To: <4E4C2B6F.7000800@nod.at>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [uml-devel] Floating point problems on UML - help needed
To: Richard Weinberger <richard@nod.at>
Cc: linux-kernel@vger.kernel.org, gunnarlindroth@hotmail.com, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 17.08.2011 22:58, Richard Weinberger wrote:

> It looks like FPU registers get sometimes lost after switching between
> two or more threads.

This is probably a bug in UML I reported nearly three years ago.
For me mode=skas0 worked aruond the issue.

http://thread.gmane.org/gmane.linux.uml.devel/11824/focus=11840

You might try the patch posted in
http://thread.gmane.org/gmane.linux.uml.devel/12158
(I don't have the environment to test it anymore)

Regards
-- 
                                     Stano
