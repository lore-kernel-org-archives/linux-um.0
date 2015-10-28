Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
In-Reply-To: <CAHVbs9NVbHPxOonwtHd3VpOrn2uiLAxb27fCVSsKGwgxeZjS4w@mail.gmail.com>
References: <CAHVbs9NVbHPxOonwtHd3VpOrn2uiLAxb27fCVSsKGwgxeZjS4w@mail.gmail.com>
Date: Wed, 28 Oct 2015 18:23:26 +0100
Message-ID: <CAFLxGvxsvAJqnbgURkKKbebQKZzuCkOzqVTCTLSfs8RWUjRN1A@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [uml-user] Any reason for a kernel thread not run
	after calling schedule()?
To: Ricardo Nunes <ricardomiguel.sn@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "user-mode-linux-user@lists.sourceforge.net" <user-mode-linux-user@lists.sourceforge.net>

On Wed, Oct 28, 2015 at 5:36 PM, Ricardo Nunes
<ricardomiguel.sn@gmail.com> wrote:
> Hi,
>
> I'm making a UML driver to adapt a real driver to UML and hardware
> emulation.
>
> In this case I have a kernel thread trying to read a register, which is now
> done through a netlink channel to a userspace application (asynchronous
> response) but inside a synchronous function (the function that I'm
> implementing returns the register value). The first attempt was done doing:
>
> Kernel thread
>
> sleeping_task = current;
> set_current_state(TASK_INTERRUPTIBLE);
> schedule();
>
> Netlink new message callback
>
> wake_up_process(sleeping_task);
>
> But the kernel thread never runs again, unless I call schedule() in netlink
> callback function after wake_up_process, which will make that callback being
> blocked. I also tried using wait_queue but after the same result I saw the
> functions and realised that they also use schedule for putting the process
> to sleep.
>
> This worked in a "real" linux module (not with netlink callback, but between
> 2 kernel threads), I don't understand why shouldn't in UML. Any reason you
> might remember?

Can you please share your code?

-- 
Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

