Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 09/10] tty: Consolidate noctty checks in tty_open()
References: <1448677557-16420-1-git-send-email-peter@hurleysoftware.com>
 <1452402833-8652-1-git-send-email-peter@hurleysoftware.com>
 <1452402833-8652-10-git-send-email-peter@hurleysoftware.com>
 <CAFLxGvwW2A-7bNa0sz72622xDShm_yhSs-JzsiSVh5qd3VBAVQ@mail.gmail.com>
From: Peter Hurley <peter@hurleysoftware.com>
Message-ID: <56F6DDC7.6060609@hurleysoftware.com>
Date: Sat, 26 Mar 2016 12:06:47 -0700
MIME-Version: 1.0
In-Reply-To: <CAFLxGvwW2A-7bNa0sz72622xDShm_yhSs-JzsiSVh5qd3VBAVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, LKML <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Linus Torvalds <torvalds@linux-foundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi Richard,

On 03/26/2016 10:58 AM, Richard Weinberger wrote:
> On Sun, Jan 10, 2016 at 6:13 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> Evaluate the conditions which prevent this tty being the controlling
>> terminal in one place, just before setting the controlling terminal.
>>
>> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
>> ---
>>  drivers/tty/tty_io.c | 17 ++++++++---------
>>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> Peter,
> 
> This commit breaks existing userspace.
> I noticed that on UserModeLinux with Debian Squeeze as userspace, getty does not
> give me a controlling tty upon login.
> It does not seem to happen on newer distros. But still this needs
> further investigation.
> 
> Please me know what debug information you need.

Sorry about that; I hadn't considered the implications of UML console.
Can you test the blob below?

Regards,
Peter Hurley

--- >% ---
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 608beb6..a361c61 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2158,7 +2157,9 @@ retry_open:
 	read_lock(&tasklist_lock);
 	spin_lock_irq(&current->sighand->siglock);
 	noctty = (filp->f_flags & O_NOCTTY) ||
+#ifdef CONFIG_VT
 			device == MKDEV(TTY_MAJOR, 0) ||
+#endif
 			device == MKDEV(TTYAUX_MAJOR, 1) ||
 			(tty->driver->type == TTY_DRIVER_TYPE_PTY &&
 			 tty->driver->subtype == PTY_TYPE_MASTER);


