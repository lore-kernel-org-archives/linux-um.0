Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 7 Jun 2012 10:22:28 +0100
From: Alan Cox <alan@linux.intel.com>
Message-ID: <20120607102228.0ed8281e@bob.linux.org.uk>
In-Reply-To: <4FD06A22.6040002@nod.at>
References: <1338841657-30358-1-git-send-email-richard@nod.at>
	<4FCF6748.6020005@panasas.com>
	<4FD059AC.8050808@panasas.com>
	<4FD06A22.6040002@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [uml-devel] um: TTY fixes (?)
To: Richard Weinberger <richard@nod.at>
Cc: Boaz Harrosh <bharrosh@panasas.com>, user-mode-linux-devel@lists.sourceforge.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, jslaby@suse.cz
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

> Breaking existing applications is a no-go, sorry.

Being insecure should also be a no-no.

Not sure what Jiri thinks but for the moment I think we need to push it
with a module option as to whether hangup on console is enabled or not.

I don't want to just break the existing user space, but leaving other
vendors systems insecure just to cover Fedora's backside is also not
entirely fair either.

Alan
