Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXREL-007CiR-7C
 for linux-um@lists.infradead.org; Mon, 04 Oct 2021 16:54:23 +0000
Received: by mail-qt1-x832.google.com with SMTP id e16so6297634qte.13
 for <linux-um@lists.infradead.org>; Mon, 04 Oct 2021 09:54:17 -0700 (PDT)
Date: Mon, 4 Oct 2021 11:54:10 -0500
From: Glenn Washburn <development@efficientek.com>
Subject: Re: Bug 214611 - UM: stdout output ceases under certain conditions
Message-ID: <20211004115410.4716345d@crass-HP-ZBook-15-G2>
In-Reply-To: <aad9145655670d2f7d06a8dffd93d99171183fe0.camel@sipsolutions.net>
References: <20211002210023.55861502@crass-HP-ZBook-15-G2>
 <aad9145655670d2f7d06a8dffd93d99171183fe0.camel@sipsolutions.net>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: development@efficientek.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org

On Mon, 04 Oct 2021 14:48:34 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> On Sat, 2021-10-02 at 21:00 -0500, Glenn Washburn wrote:
> > Hi list,
> > 
> > I'm notifying the list of a bug report[1] I created in the kernel
> > bugzilla. I'm not subscribed to this list, so please add this my email
> > in any replies to this email.
> 
> 
> > [1] https://bugzilla.kernel.org/show_bug.cgi?id=214611
> 
> This really has nothing to do with UBD or something. What's happening is
> that you're using the command line badly.
> 
> What do you expect this:
> 
>   ... < <(cat /dev/null)
> 
> to do?

This was just a way to trigger the issue I was seeing. I have a bash
script which was doing something like the following:

grep "search" /path/to/file |
while read VAR; do
  run_some_script_which_eventually_runs_uml $VAR;
done

I was confused why running this script caused UML to lose output always
when mounting the ubd in the UML mount script. And it didn't happen
when I ran "run_some_script_which_eventually_runs_uml" alone. Since the
amount of data returned by the grep was small, this issue was triggered
all the time. If the output were a lot of data, I might have noticed
that early runs of run_some_script_which_eventually_runs_uml would not
have output disappear after mounting. Thanks for debugging this.

> What happens is that the shell creates a pipe. This pipe is connected on
> the one side to fd:1 in UML (stdin) and on the other to stdout of 'cat'.
> 
> Now this is all fine, but 'cat' will *quit immediately* since it cannot
> read anything from /dev/null (it's write-only!).
> 
> Therefore, the fd:1 in UML will be invalidated pretty much immediately,
> receiving EPOLLHUP.
> 
> This is detected by the epoll code, raising an interrupt into the line
> level code, and the line code then closes the stdio console channel
> entirely, including stdout.

This seems like it could be a bug. Couldn't the console not be closed,
but the console handling code internally mark stdin as closed? Perhaps
there could even be logic to detect if stdin and stdout are from the
same fd, then close the console, otherwise don't. From a user
perspective, thinking of UML as a normal process, it doesn't make sense
that closing stdin would close stdout as well.

> If anything, the bug is that when you're not causing enough interrupts
> by using ubd, somehow this situation doesn't get detected, and the
> console remains open, so you still see the output... I think this might
> be if closing the FD didn't generate a SIGIO?

This leads to strange behavior. But for this issue, I think the
suggestion above would obviate the need to do anything about this.

> In fact, if you generate SIGIO in *any* other way, including pressing
> enter while the script is running even if stdin is redirected from your
> dead cat [1], you still get the same behaviour of the channel getting
> closed.

Ok, I've confirmed that. I think that's another reason to fix this in
a manner that doesn't tie stdin to stdout, just hitting enter can make
outut disappear (non-intuitive). In my case, stdout was going to a file.
So my intuition would say that stdin (from a pipe) and stdout (to a
file) shouldn't be connected (yes a program can create any kind of
connection it wants, but it's not intuitive). It would be like rsync
-av dir1 dir2 < <(cat /dev/null) having its output disappear if you
pressed enter in the middle of the run.

> 
> 
> johannes
> 
> [1] did I really just write that? heh.

Thanks, got a chuckle out of that.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

