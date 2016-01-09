Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 9 Jan 2016 03:51:25 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] um: Fix get_signal() usage
Message-ID: <20160109035125.GA365@ZenIV.linux.org.uk>
References: <1447836703-32594-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1447836703-32594-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Nov 18, 2015 at 09:51:43AM +0100, Richard Weinberger wrote:
> If get_signal() returns us a signal to post
> we must not call it again, otherwise the already
> posted signal will be overridden.
> Before commit a610d6e672d this was the case as we stopped
> the while after a successful handle_signal().

Old behaviour had been wrong.  If you have several pending signals,
more than one sigframe should be built, as if the second, etc. had
been delivered right on the entry into the handler.

Stopping after the first one is obviously wrong - consider the case
when attempt to deliver it has raised SIGSEGV.

