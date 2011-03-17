Return-Path: <linux-kernel-owner@vger.kernel.org>
From: WANG Cong <xiyou.wangcong@gmail.com>
Date: Thu, 17 Mar 2011 12:52:20 +0000 (UTC)
Message-ID: <ilt063$vm1$4@dough.gmane.org>
References: <1300365449-12548-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] um: Remove file pointer from ioctl
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, 17 Mar 2011 13:37:29 +0100, Richard Weinberger wrote:

> Commit 6caa76b (tty: now phase out the ioctl file pointer for good)
> removed the ioctl file pointer.
> User Mode Linux's line driver uses this ioctl and needs a signature
> update too.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>

Acked-by: WANG Cong <xiyou.wangcong@gmail.com>

Thanks.

