Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXNOc-006UrC-9M
 for linux-um@lists.infradead.org; Mon, 04 Oct 2021 12:48:43 +0000
Message-ID: <aad9145655670d2f7d06a8dffd93d99171183fe0.camel@sipsolutions.net>
Subject: Re: Bug 214611 - UM: stdout output ceases under certain conditions
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 04 Oct 2021 14:48:34 +0200
In-Reply-To: <20211002210023.55861502@crass-HP-ZBook-15-G2>
References: <20211002210023.55861502@crass-HP-ZBook-15-G2>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: development@efficientek.com, linux-um@lists.infradead.org

On Sat, 2021-10-02 at 21:00 -0500, Glenn Washburn wrote:
> Hi list,
> 
> I'm notifying the list of a bug report[1] I created in the kernel
> bugzilla. I'm not subscribed to this list, so please add this my email
> in any replies to this email.


> [1] https://bugzilla.kernel.org/show_bug.cgi?id=214611

This really has nothing to do with UBD or something. What's happening is
that you're using the command line badly.

What do you expect this:

  ... < <(cat /dev/null)

to do?

What happens is that the shell creates a pipe. This pipe is connected on
the one side to fd:1 in UML (stdin) and on the other to stdout of 'cat'.

Now this is all fine, but 'cat' will *quit immediately* since it cannot
read anything from /dev/null (it's write-only!).

Therefore, the fd:1 in UML will be invalidated pretty much immediately,
receiving EPOLLHUP.

This is detected by the epoll code, raising an interrupt into the line
level code, and the line code then closes the stdio console channel
entirely, including stdout.


If anything, the bug is that when you're not causing enough interrupts
by using ubd, somehow this situation doesn't get detected, and the
console remains open, so you still see the output... I think this might
be if closing the FD didn't generate a SIGIO?

In fact, if you generate SIGIO in *any* other way, including pressing
enter while the script is running even if stdin is redirected from your
dead cat [1], you still get the same behaviour of the channel getting
closed.


johannes

[1] did I really just write that? heh.


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

