Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1452402833-8652-10-git-send-email-peter@hurleysoftware.com>
References: <1448677557-16420-1-git-send-email-peter@hurleysoftware.com>
	<1452402833-8652-1-git-send-email-peter@hurleysoftware.com>
	<1452402833-8652-10-git-send-email-peter@hurleysoftware.com>
Date: Sat, 26 Mar 2016 18:58:41 +0100
Message-ID: <CAFLxGvwW2A-7bNa0sz72622xDShm_yhSs-JzsiSVh5qd3VBAVQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] tty: Consolidate noctty checks in tty_open()
From: Richard Weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, LKML <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Linus Torvalds <torvalds@linux-foundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, Jan 10, 2016 at 6:13 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> Evaluate the conditions which prevent this tty being the controlling
> terminal in one place, just before setting the controlling terminal.
>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/tty/tty_io.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

Peter,

This commit breaks existing userspace.
I noticed that on UserModeLinux with Debian Squeeze as userspace, getty does not
give me a controlling tty upon login.
It does not seem to happen on newer distros. But still this needs
further investigation.

Please me know what debug information you need.

-- 
Thanks,
//richard

