Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 20 Feb 2010 15:09:36 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [Patch] um: tell git to ignore generated files
Message-ID: <20100220150936.GP30031@ZenIV.linux.org.uk>
References: <20100220143359.GD3000@hack>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100220143359.GD3000@hack>
Sender: linux-kernel-owner@vger.kernel.org
To: Am??rico Wang <xiyou.wangcong@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sat, Feb 20, 2010 at 10:33:59PM +0800, Am??rico Wang wrote:
> 
> git should ignore these files, since they are generated.

> +include/shared/kern_constants.h
> +include/shared/user_constants.h

I have patches taking that to include/generated, actually
