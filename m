Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] um: Protect memory mapped file
References: <1450818910-23355-1-git-send-email-mic@digikod.net>
From: Richard Weinberger <richard@nod.at>
Message-ID: <5692BD91.50100@nod.at>
Date: Sun, 10 Jan 2016 21:22:41 +0100
MIME-Version: 1.0
In-Reply-To: <1450818910-23355-1-git-send-email-mic@digikod.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Tristan Schmelcher <tschmelcher@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 22.12.2015 um 22:15 schrieb Mickaël Salaün:
> This series protect the memory mapped file. This apply on v4.4-rc6.
> 
> Changes since v4:
> * fix spelling [1/2]
> 
> Changes since v3:
> * add Tristan Schmelcher's ack
> 
> Changes since v2; addressed Tristan Schmelcher's comment:
> * remove the whole fchmod call [1/2]
> 
> Changes since v1; addressed Richard Weinberger's comments:
> * add attacker model to the patch description [1/2]
> * remove errno reset [2/2]
> 
> Regards,
>  Mickaël
> 
> Mickaël Salaün (2):
>   um: Do not set unsecure permission for temporary file
>   um: Use race-free temporary file creation

Applied!

Thanks,
//richard

