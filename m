Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1508522803.30181.3.camel@perches.com>
Subject: Re: [PATCH] um: Use common error handling code in port_listen_fd()
From: Joe Perches <joe@perches.com>
Date: Fri, 20 Oct 2017 11:06:43 -0700
In-Reply-To: <b16407cf-0caa-ea1d-7997-0e9a231468f3@users.sourceforge.net>
References: <b16407cf-0caa-ea1d-7997-0e9a231468f3@users.sourceforge.net>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, 2017-10-20 at 19:29 +0200, SF Markus Elfring wrote:
> arch/um/drivers/port_user.c

If you are going to use multiple labels,
it'd be nicer to rename out: too.


